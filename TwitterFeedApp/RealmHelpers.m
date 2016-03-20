//
//  RealmHelpers.m
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import "RealmHelpers.h"

@implementation RealmHelpers

#pragma mark - private

+ (BOOL) saveTwitterFeedModelToRealm:(NSDictionary *)dictionary{
    
    //convert json to model
    NSError *error = nil;
    TwitterFeedModel *model = [RealmHelpers twitterFeedModelFromDictionary:dictionary];
    
    //convert model to dictionary
    NSDictionary *modelDictionary = [MTLJSONAdapter JSONDictionaryFromModel:model error:&error];
    
    //If not in real, save it
    RLMRealm *realm = [RLMRealm defaultRealm];
    @autoreleasepool {
        RLMResults *results = [TwitterFeedRealm objectsInRealm:realm where:@"id == %@", model.id];
        if (results.count > 0) { //Get same object in realm
            return NO;
        }
        
        [realm transactionWithBlock:^{ //save it
            [TwitterFeedRealm createInRealm:realm withValue:modelDictionary];
        }];
    }
    
    if (error != nil) {
        return NO;
    }
    
    return YES;
}

+ (NSArray *) allTwitterFeedModelFromRealm{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    //get object and sorted by addedtime desc
    RLMResults *results = [[TwitterFeedRealm allObjectsInRealm:realm] sortedResultsUsingProperty:@"addedTime" ascending:NO];
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    for (TwitterFeedRealm *feed in results) {
        TwitterFeedModel *model = [[TwitterFeedModel alloc] initWithRealmObject:feed];
        [modelArray addObject:model];
    }
    
    return modelArray;
}

#pragma mark - private
+ (NSDictionary *) dictionaryWithContentsOfJSONString: (NSString *)fileLocation{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension] ofType:[fileLocation pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    
    return result;
}

+ (TwitterFeedModel *) twitterFeedModelFromDictionary: (NSDictionary *) dictionary{
    
    NSError *error = nil;
    TwitterFeedModel *model = [MTLJSONAdapter modelOfClass:TwitterFeedModel.class fromJSONDictionary:dictionary error:&error];
    
    return model;
}

@end
