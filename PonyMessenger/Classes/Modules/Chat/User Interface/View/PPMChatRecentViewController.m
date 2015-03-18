//
//  PPMChatRecentViewController.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatRecentViewController.h"

@interface PPMChatRecentViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PPMChatRecentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parentViewController.title = @"微信";
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_mainframeHL"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 99;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell;
}

@end
