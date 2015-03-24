//
//  PPMChatRecentViewController.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-17.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatRecentViewController.h"
#import "PPMChatRecentListPresenter.h"
#import "PPMChatRecentListInteractor.h"
#import "PPMChatRecentTableViewCell.h"
#import "PPMChatRecentCellPresenter.h"

@interface PPMChatRecentViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PPMChatRecentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parentViewController.title = @"微信";
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_mainframeHL"];
    [self.eventHandler updateView];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
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
    return [self.eventHandler.listInteractor.cellInteractors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    PPMChatRecentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexPath.row < [self.eventHandler.listInteractor.cellInteractors count]) {
        cell.eventHandler.cellInteractor = self.eventHandler.listInteractor.cellInteractors[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PPMChatRecentTableViewCell *cell = (PPMChatRecentTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell.eventHandler presentChatViewControllerToNavigationController:self.navigationController];
}

#pragma mark - Events

- (void)reloadTableView {
    [self.tableView reloadData];
}

@end
