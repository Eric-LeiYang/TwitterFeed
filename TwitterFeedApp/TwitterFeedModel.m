//
//  TwitterFeedModel.m
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import "TwitterFeedModel.h"

@implementation TwitterFeedModel 
- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue{
    self = [super initWithDictionary:dictionaryValue error:nil];
    if (self == nil) return nil;
    
    // Store a value that needs to be determined locally upon initialization.
    return self;
}

- (instancetype) initWithRealmObject:(TwitterFeedRealm *)realm{
    self = [super init];
    
    if (self) {
        self.name = realm.name;
        self.userName = realm.userName;
        self.profileImageUrl = realm.profileImageUrl;
        self.createdAt = realm.createdAt;
        self.twitterText = realm.twitterText;
    }

    return self;
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"id": @"id",
             @"name": @"name",
             @"userName": @"userName",
             @"profileImageUrl": @"profileImageUrl",
             @"createdAt": @"createdAt",
             @"twitterText": @"twitterText"
             };
}

@end
