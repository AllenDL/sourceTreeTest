//
//  DPTableView.m
//  SellerDongPi
//
//  Created by 董亮 on 14/12/4.
//  Copyright (c) 2014年 DongPi. All rights reserved.
//

#import "DPTableView.h"
#import "MJRefresh.h"

@implementation DPTableView
@dynamic delegate;

- (void)setDelegate:(id<DPTableViewDelegate>)delegate
{
    [super setDelegate:delegate];
    if (delegate) {
        [self setupRefresh];
    }
}

- (void)setupRefresh
{
    if ([self.delegate respondsToSelector:@selector(headerRefreshStart:)]) {
        //下拉刷新(进入刷新状态就会调用self的headerReresh)
        self.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    }
    if ([self.delegate respondsToSelector:@selector(footerRefreshStart:)]) {
        //上拉加载(进入加载状态就会调用self的footerRefresh)
        self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    }
}

- (void)headerRefresh
{
    [self.delegate headerRefreshStart:self];
}

- (void)footerRefresh
{
    [self.delegate footerRefreshStart:self];
}

- (void)headerRefreshEnd
{
    [self.header endRefreshing];
}

- (void)footerRefreshEnd
{
    [self.footer endRefreshing];
}


@end
