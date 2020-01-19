//
//  TestViewController.m
//  RTRootViewControllerMayCrash
//
//  Created by eShow on 2020/1/17.
//  Copyright © 2020 jiaoyingbrother. All rights reserved.
//

#import "TestViewController.h"
#import "Test2ViewController.h"

#import "RTRootNavigationController.h"

@interface TestViewController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation TestViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.rt_navigationController) {
        self.rt_navigationController.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.rt_navigationController) {
        self.rt_navigationController.delegate = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [@"index" stringByAppendingString: @(self.index).description];
    if (self.index > 2) {
        self.descLabel.text = @"可以点击pop了,此时调用的是popToViewController: 然后rtrootnavigationcontroller里面的popgesture设置的时候rtrootnavigationcontroller.rt_delegate 不为空, 此时通过方法转发手势响应代理,在当前viewcontroller被自动释放的时候  rtrootnavigationcontroller.rt_delegate 自动为nil,此时又不响应首饰代理,当触发手势时,程序崩溃";
    } else {
        self.descLabel.text = @"请点击clickme";
    }
    
}

- (IBAction)btnAction:(id)sender {
    TestViewController *vc = [TestViewController new];
    vc.index = self.index + 1;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)popToIndex1:(UIButton *)sender {
    sender.enabled = NO;
    self.descLabel.text = @"请等候3秒,模拟异步网络请求";
    for (Test2ViewController *aVC in self.rt_navigationController.rt_viewControllers) {
        if ([aVC isKindOfClass:[Test2ViewController class]] && aVC.index == 1) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popToViewController:aVC animated:YES];
                });
            });
            return;
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"拦截返回手势的业务弹窗,例如:\"当前界面的信息非常关键哦,确认要退出吗?\"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    return NO;
}


@end
