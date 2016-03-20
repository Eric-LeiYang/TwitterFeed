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
    self.userName = self.model.userName;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.model.profileImageUrl]];
    
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            self.avatarImage = [[UIImage alloc] initWithData:data];
        }
    }];
    
    self.time = self.model.createdAt;
    self.twitterText = self.model.twitterText;
}
@end
