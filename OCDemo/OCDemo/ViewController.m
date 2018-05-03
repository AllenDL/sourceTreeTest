//
//  ViewController.m
//  OCDemo
//
//  Created by 董亮 on 2018/4/10.
//  Copyright © 2018年 董亮. All rights reserved.
//

#import "ViewController.h"
#import "DPTableView.h" 
#import "UIView+Extension.h"

@interface ViewController ()<DPTableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>


@property (nonatomic, strong) DPTableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *btnView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSMutableArray *btnArr;

@end
///
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    _headerView.backgroundColor =[UIColor redColor];
    
    _btnArr = [[NSMutableArray alloc] init];
    NSArray *arr = @[@"1111",@"2222",@"3333",@"4444"];
    
    _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, 50)];
    for (int idx = 0; idx<arr.count; idx++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(20+70*idx, 0, 50, 50)];
        [btn setTitle:arr[idx] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor greenColor];
        btn.tag = idx;
        [btn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_btnArr addObject:btn];
        [_btnView addSubview:btn];
    }
    [_headerView addSubview:_btnView];
    [self.view addSubview:_headerView];

    _tableView = [[DPTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _headerView.height)];
    [_tableView addObserver:self
                        forKeyPath:@"contentOffset"
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    [_mainScrollView addSubview:_tableView];
}

- (void)tapBtn:(UIButton *)sender
{
    NSLog(@"%ld",sender.tag);
    
    
    NSLog(@"123");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat headerViewScrollStopY = 50;
        CGFloat btnViewScrollStopY = 25;
        UITableView *tableView = object;
        CGFloat contentOffsetY = tableView.contentOffset.y;
        NSLog(@"%f",contentOffsetY);
        if (contentOffsetY >= btnViewScrollStopY && contentOffsetY <=headerViewScrollStopY) {
            self.headerView.y = - tableView.contentOffset.y;
            self.btnView.y = tableView.contentOffset.y;
        } else if (contentOffsetY <= btnViewScrollStopY){
            self.btnView.y = btnViewScrollStopY;
        } else if (contentOffsetY >= headerViewScrollStopY) {
            self.btnView.y = headerViewScrollStopY;
        }
        // 滑动没有超过停止点,头部视图跟随移动
        if (contentOffsetY < headerViewScrollStopY) {
            self.headerView.y = - tableView.contentOffset.y;
            
        } else {
            self.headerView.y = - headerViewScrollStopY;
        }
    }
}

- (void)dealloc
{
    NSLog(@"123");
    [_tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
