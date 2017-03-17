//
//  MCTestView.h
//  获取验证码
//
//  Created by 孙承秀 on 2017/2/22.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCTestView : UIView

/*************  随机字符数组 ***************/
@property ( nonatomic , strong )NSArray *charArray;

/*************  验证码字符串 ***************/
@property ( nonatomic , strong )NSMutableString *charStr;

/*************  获取验证码 ***************/
- (void)getCode;
@end
