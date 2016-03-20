//
//  ViewController.m
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import "TwitterFeedViewController.h"

@interface TwitterFeedViewController ()

@end

@implementation TwitterFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButton:(UIButton *)sender {
    [[TwitterFeedSharedManager manager] setAuthorizationWithSuccess:^(id responseObject) {
        NSLog(@"");
    } error:^(NSError *error) {
    
    }];
}


@end
