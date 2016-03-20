//
//  TwitterFeedSharedManager.m
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import "TwitterFeedSharedManager.h"

#define kConsumerKey @"am6BTAfu4nQZffIFR2TOMZMNH"
#define kConsumerSecretKey @"KDxwzNYCYmHNfrPyjhM23Oxl4sqoy0ETOsEa0Vm3keYdta7Lpi"

#define kBaseURL @"https://api.twitter.com/"

@implementation TwitterFeedSharedManager

+ (instancetype) manager
{
    static TwitterFeedSharedManager* manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [configuration setHTTPMaximumConnectionsPerHost:1];
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL] sessionConfiguration:configuration];
    });
    return manager;

}

- (void) setAuthorizationWithSuccess:(void(^)(id responseObject))success
                               error:(void(^)(NSError *error))error
{
    [self performURLSessionTaskForRequest:[self customizeRequestForToken] successBlock:success errorBlock:error];
}

- (void) getTimeLineByScreenName:(NSString *)name
                        pageSize:(int)size
                         Success:(void(^)(id responseObject))success
                           error:(void(^)(NSError *error))error
{
    @weakify(self);
    [self setAuthorizationWithSuccess:^(id responseObject) {
        
        NSString *token = [NSString stringWithFormat:@"%@ %@", @"Bearer", responseObject[@"access_token"] ];
        @strongify(self);
        [self GET:@"1.1/statuses/user_timeline.json"
           header:@{@"Authorization":token}
       parameters:@{@"screen_name":name,
                    @"count":[NSNumber numberWithInt:size]}
     successBlock:^(id responseObject) {
        
         
                        
                        
    } errorBlock:error];
    } error:error];
}

#pragma mark - Private Methods

-(NSURLRequest *) customizeRequestForToken{
    NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    NSString *consumerKeyRFC1738 = [kConsumerKey stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSString *consumerSecretRFC1738 = [kConsumerSecretKey stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSString *concatKeySecret = [[consumerKeyRFC1738 stringByAppendingString:@":"] stringByAppendingString:consumerSecretRFC1738];
    NSString *concatKeySecretBase64 = [[concatKeySecret dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"https://api.twitter.com/oauth2/token"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:[@"Basic " stringByAppendingString:concatKeySecretBase64] forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString *str = @"grant_type=client_credentials";
    NSData *httpBody = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:httpBody];
    
    return request;
}
@end
