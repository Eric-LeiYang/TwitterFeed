//
//  TwitterCellViewModel.m
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import "TwitterCellViewModel.h"

@interface TwitterCellViewModel()

@property (nonatomic, readwrite) TwitterFeedModel *model;

@end

@implementation TwitterCellViewModel

#pragma mark: init methods
- (instancetype)initWithModel:(TwitterFeedModel *)model{
    self = [super init];
    if (self) {
        _model = model;
        [self initialize];
    }
    return self;
}

//initialize
- (void)initialize {
    //render value from model to ViewModel
    self.name = self.model.name;
    self.userName = [@"@" stringByAppendingString:self.model.userName];
    self.avatarImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.profileImageUrl]]];
    self.timeString = self.model.createdAt;
    self.twitterText = self.model.twitterText;
}
@end
