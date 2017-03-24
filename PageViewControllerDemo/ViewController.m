//
//  ViewController.m
//  PageViewControllerDemo
//
//  Created by 王博 on 15/9/7.
//  Copyright (c) 2015年 wangbo. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    UIPageViewController * _pageVC;
    UILabel * _currentPageLabel;
    NSInteger willToPage;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 显示页码
    _currentPageLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 200, 40)];
    _currentPageLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_currentPageLabel];
    _currentPageLabel.text = @"1";
    _currentPageLabel.textAlignment = NSTextAlignmentCenter;
    
    // UIPageViewController用于显示翻页效果的控制器
    
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    // 设置数据源及代理
    _pageVC.dataSource = self;
    _pageVC.delegate = self;
    
    _pageVC.view.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50);
    
    // 数据页面自定义显示
    DetailViewController *dvc = [[DetailViewController alloc] init];
    dvc.page = 1;
    
    // 设置UIPageViewController显示内容
    [_pageVC setViewControllers:@[dvc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self.view addSubview:_pageVC.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 获取viewController的下一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    DetailViewController * old = (DetailViewController *)viewController;
    NSInteger page = old.page;
    
    if (page >= 5) {
        return nil;
    } else {
        DetailViewController * newVC = [[DetailViewController alloc] init];
        newVC.page = page + 1;
        return newVC;
    }
}

// 获取viewController的上一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    DetailViewController * old = (DetailViewController *)viewController;
    NSInteger page = old.page;
    
    if (page <= 1) {
        return nil;
    } else {
        DetailViewController * newVC = [[DetailViewController alloc] init];
        newVC.page = page - 1;
        return newVC;
    }
}

// UIPageViewController将要翻到pendingViewControllers中的页面
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    willToPage = ((DetailViewController *)pendingViewControllers[0]).page;
}

// UIPageViewController完成翻页的动作，completed表示是否翻到新页
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed) {
        _currentPageLabel.text = [NSString stringWithFormat:@"%ld", willToPage];
    }
}

@end
