//
//  Test2ViewController.m
//  RTRootViewControllerMayCrash
//
//  Created by eShow on 2020/1/17.
//  Copyright © 2020 jiaoyingbrother. All rights reserved.
//

#import "Test2ViewController.h"
#import "TestViewController.h"

@interface Test2ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (nonatomic, assign) BOOL didShow;
@end

@implementation Test2ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.didShow) {
        self.descLabel.text = @"如果你是通过popToTest2按钮返回,请左滑,程序崩溃";
    }
    self.didShow = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [@"Test2ViewController" stringByAppendingString:@(self.index).description];
}

- (IBAction)clickMe:(id)sender {
    if (self.index == 0) {
        Test2ViewController *vc = [Test2ViewController new];
        vc.index = 1;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        TestViewController *vc = [TestViewController new];
        vc.index = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
