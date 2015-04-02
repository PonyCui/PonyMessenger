//
//  PPMChatContactViewController.m
//  PonyMessenger
//
//  Created by 崔 明辉 on 15-3-18.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PPMChatContactViewController.h"
#import "PPMChatContactListPresenter.h"
#import "PPMChatContactListInteractor.h"
#import "PPMChatContactCellInteractor.h"
#import "PPMChatContactCellPresenter.h"
#import "PPMChatContactTableViewCell.h"

@interface PPMChatContactViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *sectionIndexTitles;

@property (nonatomic, copy) NSArray *sectionCells;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *tableFooterViewTextLabel;

@end

@implementation PPMChatContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.parentViewController.title = @"通讯录";
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_contactsHL"];
    [self.eventHandler updateView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionIndexTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < [self.sectionCells count]) {
        return [self.sectionCells[section] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    PPMChatContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexPath.section < [self.sectionCells count] &&
        indexPath.row < [self.sectionCells[indexPath.section] count]) {
        PPMChatContactCellInteractor *cellInteractor = self.sectionCells[indexPath.section][indexPath.row];
        cell.eventHandler.cellInteractor = cellInteractor;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section < [self.sectionIndexTitles count]) {
        return self.sectionIndexTitles[section];
    }
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexTitles;
}

#pragma mark - Events

#warning - FIXME:重构，搬到Interactor里面！
- (void)reloadTableView {
    NSMutableArray *sectionIndexTitles = [NSMutableArray array];
    NSMutableArray *sectionCells = [NSMutableArray array];
    __block NSMutableArray *currentSectionCells = nil;
    [self.eventHandler.listInteractor.contacts
     enumerateObjectsUsingBlock:^(PPMChatContactCellInteractor *obj, NSUInteger idx, BOOL *stop) {
         if ([sectionIndexTitles indexOfObject:obj.letter] == NSNotFound) {
             [sectionIndexTitles addObject:obj.letter];
             if (currentSectionCells != nil) {
                 [sectionCells addObject:currentSectionCells];
             }
             currentSectionCells = [NSMutableArray array];
         }
         [currentSectionCells addObject:obj];
    }];
    if ([currentSectionCells count] > 0) {
        [sectionCells addObject:currentSectionCells];
    }
    self.sectionIndexTitles = sectionIndexTitles;
    self.sectionCells = sectionCells;
    self.tableFooterViewTextLabel.text = [NSString stringWithFormat:@"%lu位联系人", (unsigned long)[self.eventHandler.listInteractor.contacts count]];
    [self.tableView reloadData];
}

- (IBAction)handleAddContactButtonTapped:(id)sender {
    [self.eventHandler addContact];
}


@end
