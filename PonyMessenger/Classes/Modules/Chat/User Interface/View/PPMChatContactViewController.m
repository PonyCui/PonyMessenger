//
//  PPMChatContactViewController.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatContactViewController.h"

@interface PPMChatContactViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PPMChatContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parentViewController.title = @"通讯录";
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_contactsHL"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section % 2 ? @"B" : @"A";
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return @[@"A", @"B", @"A", @"B", @"A", @"B", @"A", @"B", @"A", @"B"];
}

#pragma mark - Events

- (void)reloadTableView {
    [self.tableView reloadData];
}

@end
