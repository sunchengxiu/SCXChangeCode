//
//  ViewController.m
//  获取验证码
//
//  Created by 孙承秀 on 2017/2/22.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "ViewController.h"
#import "UIView+codeCategory.h"
@interface ViewController (){

   
}

@end

@implementation ViewController
singleM(viewController)
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *getCode = ({
        
        UIButton *codeButton = [[UIButton alloc]init];
        
        [codeButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        
        [codeButton setBackgroundColor:[UIColor blueColor]];
        
        [codeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
        codeButton;
        
    });
    [self.view addSubview:getCode];
    
    [getCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(self.view.mas_left).offset((screen_width - 100)/2);
        make.top.mas_equalTo(self.view.mas_top).offset(200);
    }];
}
#pragma  mark - 获取验证码
- (void)getCode{
    [self.view show];

}

@end
