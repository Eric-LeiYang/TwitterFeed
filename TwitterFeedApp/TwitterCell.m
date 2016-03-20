//
//  TwitterCell.m
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import "TwitterCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TwitterCell ()

@property TwitterCellViewModel *viewModel;

@end

@implementation TwitterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _viewModel = [[TwitterCellViewModel alloc] init];
        [self bindingViewModelWithUI];
    }
    return self;
}

#pragma mark: Private

//Binding ViewModel with UI
-(void) bindingViewModelWithUI{
    //Binding navigation title
    
    RAC(self.avatarImageView, image) = RACObserve(self.viewModel, avatarImage);
    RAC(self.nameLabel, text) = RACObserve(self.viewModel, name);
    RAC(self.usernameLabel, text) = RACObserve(self.viewModel, userName);
    RAC(self.twitterTextLabel, text) = RACObserve(self.viewModel, twitterText);
    RAC(self.timeLabel, text) = RACObserve(self.viewModel, time);
}

@end
