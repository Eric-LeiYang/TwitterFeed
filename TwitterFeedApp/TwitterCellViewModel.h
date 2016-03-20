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
#import "TwitterFeedSharedManager.h"

@interface TwitterCellViewModel : NSObject

@property NSString *name;
@property NSString *userName;
@property UIImage *avatarImage;
@property NSString *timeString;
@property NSString *twitterText;

/**
 *  init cell view model with model object
 *
 *  @param model model object
 *
 *  @return return view model instance
 */
- (instancetype)initWithModel:(TwitterFeedModel *)model;

@end
