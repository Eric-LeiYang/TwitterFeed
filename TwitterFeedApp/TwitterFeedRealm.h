//
//  TwitterFeedRealm.h
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import <Realm/Realm.h>

@interface TwitterFeedRealm : RLMObject
@property int id;
@property NSString *name;
@property NSString *userName;
@property NSString *profileImageUrl;
@property NSString *createdAt;
@property NSString *twitterText;
@property NSDate *addedTime;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<TwitterFeedRealm>
RLM_ARRAY_TYPE(TwitterFeedRealm)
