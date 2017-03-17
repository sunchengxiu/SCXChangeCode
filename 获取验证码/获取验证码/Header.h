//
//  Header.h
//  获取验证码
//
//  Created by 孙承秀 on 2017/2/22.
//  Copyright © 2017年 孙承秀. All rights reserved.
//


// 单利
#define singleH(name) + (instancetype)share##name;
#define singleM(name)\
static id shareSingle = nil;\
+(instancetype)share##name{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        shareSingle = [[self alloc]init];\
    });\
    return shareSingle;\
}
