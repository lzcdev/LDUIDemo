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
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) NSUInteger count;

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
    _scrollDirection = LDScrollDirectionHorizontal;
    _textFont = 17;
    _count = 0;
    _timeInterval = 0.001;
    _marginLeft = 10;
}

- (void)initView {
    _originX = self.frame.size.width;
    _originY = self.frame.size.height;
    self.layer.masksToBounds = YES;
    _textLabel = [UILabel new];
    [self addSubview:_textLabel];
}

- (void)loopVertical {
    if (_originY + self.frame.size.height < 0) {
        _originY = self.frame.size.height;
        _count++;
        if (_count == _textArray.count) {
            _count = 0;
        }
        _width = [self getWidthWithText:_textArray[_count] height:self.frame.size.height font:_textFont];
        _textLabel.text = _textArray[_count];
    }
    
    _textLabel.frame = CGRectMake(_marginLeft, _originY-=0.01, _width, self.frame.size.height);
    
}

- (void)loopHorizontal {
    if (_originX + _width < 0) {
        _originX = self.frame.size.width;
        _count++;
        if (_count == _textArray.count) {
            _count = 0;
        }
        _width = [self getWidthWithText:_textArray[_count] height:self.frame.size.height font:_textFont];
        _textLabel.text = _textArray[_count];
    }
    
    _textLabel.frame = CGRectMake(_originX-=0.01, 0, _width, self.frame.size.height);
    
}

- (void)setScrollDirection:(LDScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    [self setTextLabel];
    
}

- (void)setMarginLeft:(CGFloat)marginLeft {
    _marginLeft = marginLeft;
}

- (void)setTextArray:(NSArray *)textArray {
    _textArray = textArray;
    if (_textArray.count == 0) {
        return;
    }
    _textLabel.text = _textArray[_count];
    
    [self setTextLabel];
    
    
}

- (void)setTimeInterval:(CGFloat)timeInterval {
    _timeInterval = timeInterval;
    [self setTextLabel];
}

- (void)setTextFont:(CGFloat)textFont {
    _textFont = textFont;
    _textLabel.font = [UIFont systemFontOfSize:_textFont];
    [self setTextLabel];
}

- (void)setTextLabel {
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _width = [self getWidthWithText:_textArray[_count] height:self.frame.size.height font:_textFont];
    
    switch (_scrollDirection) {
        case LDScrollDirectionVertical:
            _textLabel.frame = CGRectMake(0, _originY, _width, self.frame.size.height);
            _timer = [NSTimer timerWithTimeInterval:_timeInterval target:self selector:@selector(loopVertical) userInfo:nil repeats:YES];
            break;
        case LDScrollDirectionHorizontal:
            _textLabel.frame = CGRectMake(_originX, 0, _width, self.frame.size.height);
            _timer = [NSTimer timerWithTimeInterval:_timeInterval target:self selector:@selector(loopHorizontal) userInfo:nil repeats:YES];
            
            break;
        default:
            break;
    }
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
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
