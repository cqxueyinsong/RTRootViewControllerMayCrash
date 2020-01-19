//
//  ViewController.m
//  RTRootViewControllerMayCrash
//
//  Created by eShow on 2020/1/17.
//  Copyright © 2020 jiaoyingbrother. All rights reserved.
//

#import "ViewController.h"
#import "RTRootNavigationController.h"
#import "Test2ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, assign) NSInteger index;
@end

@implementation ViewController

- (IBAction)btnAction:(id)sender {
    Test2ViewController *vc = [Test2ViewController new];
    RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
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
