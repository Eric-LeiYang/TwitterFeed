//
//  TwitterFeedModel.h
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "TwitterFeedRealm.h"
@interface TwitterFeedModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *profileImageUrl;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *twitterText;

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (instancetype) initWithRealmObject:(TwitterFeedRealm *)realm;

@end
