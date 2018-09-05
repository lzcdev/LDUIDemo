//
//  MarqueeView.m
//  LDUIDemo
//
//  Created by lzcdev on 2018/9/4.
//  Copyright © 2018年 lzcdev. All rights reserved.
//

#import "MarqueeView.h"

@interface MarqueeView()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *textLabel2;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) NSUInteger count1;
@property (nonatomic, assign) NSUInteger count2;


@end

@implementation MarqueeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initConfig];
        [self initView];
    }
    return self;
}

- (void)initConfig {
    _scrollDirection = LDScrollDirectionVertical;
    _textFont = 17;
    _count = 0;
    _timeInterval = 0.001;
}

- (void)initView {
    _originX = self.frame.size.width;
    _originY = self.frame.size.height;
    self.layer.masksToBounds = YES;
    _textLabel = [UILabel new];
    [self addSubview:_textLabel];
    _textLabel2 = [UILabel new];
    [self addSubview:_textLabel2];
    
    
}
//- (void)loop1 {
//    _count2++;
//        _textLabel2.frame = CGRectMake(_count2, 0, 100, self.frame.size.height);
//
//    NSLog(@"CADisplarLink=%zd----%f",_count2,_textLabel2.frame.origin.x);
//}
- (void)loop {
//    _count1++;
//    _textLabel.frame = CGRectMake(_count1, 0, 100, self.frame.size.height);
//
//    NSLog(@"NSTimer=%zd----%f",_count1, _textLabel.frame.origin.x);
    if (_originX + _width < 0) {
        _originX = self.frame.size.width;
        _count++;
        if (_count == _textArray.count) {
            _count = 0;
        }
        _width = [self getWidthWithText:_textArray[_count] height:self.frame.size.height font:_textFont];
        _textLabel.text = _textArray[_count];
        _textLabel.backgroundColor = [UIColor greenColor];
    }

    _textLabel.frame = CGRectMake(_originX-=0.1, 0, _width, self.frame.size.height);
        
   
}



- (void)setTextArray:(NSArray *)textArray {
    _textArray = textArray;
    if (_textArray.count == 0) {
        return;
    }
    
    _textLabel.text = _textArray[_count];
    
    [self setTextLabel];
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:_timeInterval target:self selector:@selector(loop) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
//    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(loop1)];
//    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)setTimeInterval:(CGFloat)timeInterval {
    _timeInterval = timeInterval;
    [self setTextLabel];
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer timerWithTimeInterval:_timeInterval target:self selector:@selector(loop) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

- (void)setTextFont:(CGFloat)textFont {
    _textFont = textFont;
    _textLabel.font = [UIFont systemFontOfSize:_textFont];
    [self setTextLabel];
}

- (void)setTextLabel {
    _width = [self getWidthWithText:_textArray[_count] height:self.frame.size.height font:_textFont];
    
    switch (_scrollDirection) {
        case LDScrollDirectionVertical:
            _textLabel.frame = CGRectMake(_originX, 0, _width, self.frame.size.height);
            break;
        case LDScrollDirectionHorizontal:
            _textLabel.frame = CGRectMake(0, _originY, _width, self.frame.size.height);
            break;
        default:
            break;
    }
    
}

/**
 根据内容、高度、字体确定宽度
 
 @param text 显示的内容
 @param height 高度
 @param font 字体
 @return 宽度
 */
- (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font {
    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.width;
}

@end
