//
//  RealmHelpers.h
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterFeedModel.h"
#import "TwitterFeedRealm.h"

@interface RealmHelpers : NSObject

/**
 *  Persist to Realm
 *
 *  @param dictionary object dictionary
 *
 *  @return save success or not
 */
+ (BOOL) saveTwitterFeedModelToRealm:(NSDictionary *) dictionary;

/**
 *  Retrieval from Realm
 *
 *  @return Array of object
 */
+ (NSArray *) allTwitterFeedModelFromRealm;

@end
