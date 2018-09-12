//
//  MarqueeViewController.m
//  LDUIDemo
//
//  Created by lzcdev on 2018/8/31.
//  Copyright © 2018年 lzcdev. All rights reserved.
//

#import "MarqueeViewController.h"
#import "MarqueeView.h"
@interface MarqueeViewController ()

@end

@implementation MarqueeViewController

- (void)viewDidLoad {
    [super viewDidLoad];


        MarqueeView *view = [[MarqueeView alloc] initWithFrame:CGRectMake(30, 100, 300, 30)];
    view.textArray = @[@"https://www.lzcdev.com",@"其实iOS学起来一点也不难，就是头有点冷。zzzzzzzz", @"哈哈哈😄", @"https://github.com/lzcdev"];
        view.backgroundColor = [UIColor orangeColor];
//        view.scrollDirection = LDScrollDirectionVertical;
        // view.timeInterval = 0.0001;
        [self.view addSubview:view];
}


@end
