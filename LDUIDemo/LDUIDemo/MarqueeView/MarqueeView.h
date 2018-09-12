//
//  MarqueeView.h
//  LDUIDemo
//
//  Created by lzcdev on 2018/9/4.
//  Copyright © 2018年 lzcdev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LDScrollDirection) {
    LDScrollDirectionHorizontal = 0,
    LDScrollDirectionVertical,
};

@interface MarqueeView : UIView
/** 滑动方向，默认横向 */
@property (nonatomic, assign) LDScrollDirection scrollDirection;
/** 字体，默认17 */
@property (nonatomic, assign) CGFloat textFont;
/** 定时器间隔（滚动速度），默认0.001，越小越快 */
@property (nonatomic, assign) CGFloat timeInterval;
/** 展示的文字数组 */
@property (nonatomic, strong) NSArray *textArray;
/** 文字距离左边的距离,默认10 */
@property (nonatomic, assign) CGFloat marginLeft;

@end
