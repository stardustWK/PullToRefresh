//
//  ViewControllerOC.m
//  PullToRefreshDemo
//
//  Created by kun wang on 2019/06/27.
//  Copyright © 2019 Yalantis. All rights reserved.
//

#import "ViewControllerOC.h"
@import PullToRefresh;

@interface ViewControllerOC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NSInteger dataSourceCount;
@end

@implementation ViewControllerOC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSourceCount = 20;

    [self.tableView addPullToRefreshWithHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.dataSourceCount = 20;
            [self.tableView endTopRefreshing];
        });
    }];

    [self.tableView addInfiniteScrollingWithHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.dataSourceCount += 20;
            [self.tableView endBottomRefreshing];
        });
    }];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceCount;
}

@end
