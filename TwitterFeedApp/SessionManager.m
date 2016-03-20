//
//  TwitterAppSessionManager.m
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import "SessionManager.h"

#define kConsumerKey @"am6BTAfu4nQZffIFR2TOMZMNH"
#define kConsumerSecretKey @"KDxwzNYCYmHNfrPyjhM23Oxl4sqoy0ETOsEa0Vm3keYdta7Lpi"

#define kSequestTimeOutInterval 30.0

@interface SessionManager()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong, nonnull) NSURL *baseURL;

@end

@implementation SessionManager 

+ (instancetype) manager
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [configuration setHTTPMaximumConnectionsPerHost:1];
    return [[[self class] alloc] initWithBaseURL:nil sessionConfiguration:configuration];
}

- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [SessionManager new];
    self.session = [NSURLSession sessionWithConfiguration:configuration];
    if (!self) {
        return nil;
    }
    
    // Ensure terminal slash for baseURL path, so that NSURL +URLWithString:relativeToURL: works as expected
    if ([[url path] length] > 0 && ![[url absoluteString] hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }
    
    self.baseURL = url;
    
    return self;
}

- (NSURLSessionTask *) GET:(NSString*)path
              successBlock:(void(^)(id responseObject))successBlock
                errorBlock:(void(^)(NSError *error))errorBlock
{
    NSURL *url = [self.baseURL URLByAppendingPathComponent:path];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:kSequestTimeOutInterval];
    [request setHTTPMethod:@"GET"];
    return [self performURLSessionTaskForRequest:request successBlock:successBlock errorBlock:errorBlock];
}

- (NSURLSessionTask *) POST:(NSString*)path
                    headers:(NSDictionary *) hearders
                 parameters:(NSDictionary *)parameters
               successBlock:(void(^)(id responseObject))successBlock
                 errorBlock:(void(^)(NSError *error))errorBlock
{
    NSURL *url = [self.baseURL URLByAppendingPathComponent:path];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:kSequestTimeOutInterval];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[self httpBodyForParamsDictionary:parameters]];

    for (NSString *key in [hearders allKeys]) {
        [request setValue:[hearders objectForKey:key] forHTTPHeaderField:key];
    }
    
    return [self performURLSessionTaskForRequest:request successBlock:successBlock errorBlock:errorBlock];
}

/*
 * Method to perform session task
 */

- (NSURLSessionTask *)performURLSessionTaskForRequest:(NSURLRequest *)request
                                         successBlock:(void(^)(id responseObject))successBlock
                                           errorBlock:(void(^)(NSError *error))errorBlock
{
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error || !data) {
            NSLog(@"Error: %@", error);
            if(errorBlock){
                errorBlock(error);
            }
            return;
        }
        
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            if (statusCode != 200) {
                NSLog(@"Error Code: %ld", (long)statusCode);
                if(errorBlock){
                    errorBlock(nil);
                }
                return;
            }
        }
        
        if(data){
            NSError *parseError;
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            if (!responseObject) {
                NSLog(@"Error in Parsing Data");
                if(errorBlock){
                    errorBlock(parseError);
                }
            } else {
                NSLog(@"ResponseObject for request: %@", request.URL);
                if(successBlock){
                    successBlock(responseObject);
                }
            }
        }
    }];
    [task resume];
    
    return task;
}


#pragma mark - Private Methods

/*
 * percent escape legal characters
 * replace " " with "+" for query params
 */

- (NSString *)percentEscapeString:(NSString *)string
{
    string = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet whitespaceCharacterSet]];
    return [string stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}

- (NSData *)httpBodyForParamsDictionary:(NSDictionary *)paramDictionary
{
    NSMutableArray *parameterArray = [NSMutableArray array];
    
    [paramDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
        NSString *param = [NSString stringWithFormat:@"%@=%@", key, [self percentEscapeString:obj]];
        [parameterArray addObject:param];
    }];
    
    NSString *string = [parameterArray componentsJoinedByString:@"&"];
    
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

/*
 * BearerToken = "ConsumerKey" + ":" + "ConsumerSecretKey"
 */

- (NSString *)getBase64EncodedBearerToken
{
    NSString *encodedConsumerToken = [self percentEscapeString:kConsumerKey];
    NSString *encodedConsumerSecret = [self percentEscapeString:kConsumerSecretKey];
    NSString *bearerTokenCredentials = [NSString stringWithFormat:@"%@:%@", encodedConsumerToken, encodedConsumerSecret];
    NSData *data = [bearerTokenCredentials dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

@end
