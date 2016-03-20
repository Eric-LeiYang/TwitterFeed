//
//  TwitterAppSessionManager.h
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SessionManager : NSObject

/**
 *  Singleton of session manager
 *
 *  @return An instance of TwitterAppSessionManager
 */
+ (instancetype) manager;

- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration;

/**
 *  GET request
 *
 *  @param path         url path
 *  @param successBlock success block
 *  @param errorBlock   error block
 *
 *  @return instance of NSURLSessionTask
 */
- (NSURLSessionTask *) GET:(NSString*)path
              successBlock:(void(^)(id responseObject))successBlock
                errorBlock:(void(^)(NSError *error))errorBlock;

/**
 *  POST request
 *
 *  @param path         url path
 *  @param hearders     header dictionary
 *  @param parameters   parameter dictionary
 *  @param successBlock success block
 *  @param errorBlock   error block
 *
 *  @return instance of NSURLSessionTask
 */
- (NSURLSessionTask *) POST:(NSString*)path
                    headers:(NSDictionary *) hearders
                 parameters:(NSDictionary *)parameters
               successBlock:(void(^)(id responseObject))successBlock
                 errorBlock:(void(^)(NSError *error))errorBlock;
@end
