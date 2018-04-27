//
//  DPTableView.h
//  SellerDongPi
//
//  Created by 董亮 on 14/12/4.
//  Copyright (c) 2014年 DongPi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPTableView;

@protocol DPTableViewDelegate <UITableViewDelegate>

@optional
- (void)headerRefreshStart:(DPTableView *)tableView;
- (void)footerRefreshStart:(DPTableView *)tableView;

@end

@interface DPTableView : UITableView

@property (nonatomic, assign) id<DPTableViewDelegate> delegate;


- (void)headerRefreshEnd;
- (void)footerRefreshEnd;

@end
