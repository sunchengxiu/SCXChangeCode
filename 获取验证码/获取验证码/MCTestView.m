//
//  MCTestView.m
//  获取验证码
//
//  Created by 孙承秀 on 2017/2/22.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "MCTestView.h"

@implementation MCTestView
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        
        self.layer.cornerRadius = 4;
        
        self.backgroundColor = [UIColor yellowColor];
        
        [self getCode];
    }
    return self;
}

-(void)getCode{
    
    /*************  自定义随机字符串数组 ***************/
    self.charArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    
    self.charStr = [[NSMutableString alloc]initWithCapacity:charCount];
    
    /*************  产生随机字符 ***************/
    for (NSInteger i = 0; i < charCount; i ++) {
        
        NSInteger index = arc4random() % (self.charArray.count - 1);
        
        NSMutableString *str = [self.charArray objectAtIndex:index];
        
        self.charStr =  (NSMutableString *)[self.charStr stringByAppendingString:str];
        
    }
    
}

#pragma mark - 当点击图片的时候就会更换验证码，点击的时候调用这个方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self getCode];
    [self setNeedsDisplay];
}

#pragma mark - 将验证码画到view上面
- (void)drawRect:(CGRect)rect{

    // 验证码
    NSString *code = [NSString stringWithFormat:@"%@",self.charStr];
    
    // 每个字符的size
    CGSize size = [@"S" sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}];
    
    // 每个字符应该占得总宽度
    CGFloat totalWidth = rect.size.width / code.length;
    
    // 占位宽度
    int otherWidth = totalWidth - size.width;
    
    // 占位高度
    int otherHeight = rect.size.height - size.height;
    
    // 把每个字符画到view上面
    for (NSInteger i = 0 ; i < code.length ; i ++ ) {
        
        CGFloat char_X = arc4random() % otherWidth + totalWidth * i;
        
        CGFloat char_Y = arc4random() %  otherHeight;
        
        unichar char_char = [code characterAtIndex:i];
        
        NSString *charStr = [NSString stringWithFormat:@"%C",char_char];
        
        [charStr drawAtPoint:CGPointMake(char_X, char_Y) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]}];
    }
    
    /*************  干扰线 ***************/
    
    // 获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    // 设置线宽
    CGContextSetLineWidth(ref, kLineWidth);
    
    // 绘制指定个数的彩色干扰线
    for (NSInteger i = 0; i < kLineCount; i ++) {
        
        // 设置线的起点
        CGFloat line_x = arc4random() % (int)rect.size.width;
        
        // 设置线的终点
        CGFloat line_y = arc4random() % (int)rect.size.height;
        
        CGContextMoveToPoint(ref, line_x, line_y);
        
        // 设置线的起点
        line_x = arc4random() % (int)rect.size.width;
        
        // 设置线的终点
        line_y = arc4random() % (int)rect.size.height;
        
        // 划线
        CGContextAddLineToPoint(ref, line_x, line_y);
        
        // 设置线条随机颜色
        UIColor *color = kRandomColor;
        CGContextSetStrokeColorWithColor(ref, color.CGColor);
        
        CGContextStrokePath(ref);
    }
    
    

}
@end
