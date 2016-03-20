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

@end

@implementation TwitterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

#pragma mark: Private

//Binding ViewModel with UI
-(void) bindingViewModel:(TwitterCellViewModel *)viewModel{
    //Binding navigation title
    
    RAC(self.avatarImageView, image) = RACObserve(viewModel, avatarImage);
    RAC(self.nameLabel, text) = RACObserve(viewModel, name);
    RAC(self.usernameLabel, text) = RACObserve(viewModel, userName);
    RAC(self.twitterTextLabel, text) = RACObserve(viewModel, twitterText);
    RAC(self.timeLabel, text) = RACObserve(viewModel, timeString);
}

@end
