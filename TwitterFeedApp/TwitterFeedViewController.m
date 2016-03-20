//
//  ViewController.m
//  TwitterFeedApp
//
//  Created by EricYang on 20/03/2016.
//  Copyright © 2016 Eric. All rights reserved.
//

#import "TwitterFeedViewController.h"
#import "RealmHelpers.h"
#import "TwitterCell.h"

@interface TwitterFeedViewController (){
    NSArray *feedModels;
}

@end

@implementation TwitterFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self fetchData];
    
}

#pragma mark - Table view data source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TwitterCell *twitterCell = [tableView dequeueReusableCellWithIdentifier:@"TwitterCell" forIndexPath:indexPath];
    
    TwitterCellViewModel *viewModel = [[TwitterCellViewModel alloc] initWithModel:feedModels[indexPath.row]];
    [twitterCell bindingViewModel: viewModel];
    
    return twitterCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return feedModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 162;
}

#pragma mark - button actions

- (IBAction)searchButton:(UIButton *)sender {
    [self fetchData];
}

#pragma mark - private

- (void) fetchData{
    if (self.nameTextField.text == nil || [self.nameTextField.text isEqualToString:@""]) {
        feedModels = [RealmHelpers allTwitterFeedModelFromRealm];
        [self.tableView reloadData];
        return;
    }
    
    [[TwitterFeedSharedManager manager] getTimeLineByScreenName:self.nameTextField.text pageSize:5 Success:^(id responseObject) {
        
        feedModels = [RealmHelpers allTwitterFeedModelFromRealm];
        [self.tableView reloadData];
        
    } error:^(NSError *error) {
        
        
    }];
}
@end
