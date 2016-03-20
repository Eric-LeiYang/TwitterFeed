//
//  ViewController.h
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterCell.h"
#import "TwitterFeedSharedManager.h"
#import "TwitterCellViewModel.h"

@interface TwitterFeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

