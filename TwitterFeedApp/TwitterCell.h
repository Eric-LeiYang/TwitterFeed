//
//  TwitterCell.h
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterCellViewModel.h"

@interface TwitterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitterTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

-(void) bindingViewModel:(TwitterCellViewModel *)viewModel;

@end
