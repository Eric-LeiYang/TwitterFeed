//
//  TwitterCellViewModel.h
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TwitterFeedModel.h"

@interface TwitterCellViewModel : NSObject

@property NSString *name;
@property NSString *userName;
@property UIImage *avatarImage;
@property NSString *time;
@property NSString *twitterText;
@end
