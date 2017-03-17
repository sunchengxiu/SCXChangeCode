//
//  UIView+codeCategory.m
//  获取验证码
//
//  Created by 孙承秀 on 2017/2/22.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "UIView+codeCategory.h"
#import <objc/runtime.h>
#import "MCTestView.h"
#import "UIColor+Hex.h"
const char *codeViewKey;
@interface MCCodeViewController : UIViewController<UITextFieldDelegate , UIGestureRecognizerDelegate>


/*************  确定按钮 ***************/
@property ( nonatomic , strong )UIButton *okButton;

/*************  取消按钮 ***************/
@property ( nonatomic , strong )UIButton *cancelButton;

/*************  背景试图 ***************/
@property ( nonatomic , strong )UIView *backView;

/*************  coverView ***************/
@property ( nonatomic , strong )UIView *codeView;

/*************  改变验证码按钮 ***************/
@property ( nonatomic , strong )UIButton *changeButton;

/*************  横线 ***************/
@property ( nonatomic , strong )UIView *lineView;

/*************  竖线 ***************/
@property ( nonatomic , strong )UIView *secondView;

/*************  标题 ***************/
@property ( nonatomic , strong )UILabel *titleLabel;

/*************  验证码输入框 ***************/
@property ( nonatomic , strong )UITextField *codeTextfield;

/*************  验证码图 ***************/
@property ( nonatomic , strong )MCTestView *testView;

// 获取验证码
- (void)getCode;

// 隐藏验证码试图
- (void)cancelButtonClick;
@end

@implementation MCCodeViewController
-(instancetype)init{
    if (self = [super init]) {
        [self layuoutView];
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelButtonClick];
}
- (void)layuoutView{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    // 添加试图
    [window addSubview:self.backView];
    [window addSubview:self.codeView];
    [self.codeView addSubview:self.titleLabel];
    [self.codeView addSubview:self.codeTextfield];
    [self.codeView addSubview:self.testView];
    [self.codeView addSubview:self.changeButton];
    [self.codeView addSubview:self.cancelButton];
    [self.codeView addSubview:self.okButton];
    [self.codeView addSubview:self.lineView];
    [self.codeView addSubview:self.secondView];
    
    // 背景图
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.mas_equalTo(window);
        
    }];
    
    
    
    // 验证码图
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.backView.center);
        
        make.size.mas_equalTo(CGSizeMake(200, 200));
        
    }];
    
    // 标题试图
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeView.mas_top).offset(15);
        
        make.centerX.mas_equalTo(self.codeView.mas_centerX);
    }];
    
    // 输入验证码框
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.codeView.mas_left).offset(15);
        make.right.mas_equalTo(self.codeView.mas_right).offset(-15);
        make.height.mas_equalTo(40);
    }];
    
    // 验证码图
    [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.codeView).offset(15);
        make.top.mas_equalTo(self.codeTextfield.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(60, 45));
    }];
    
    // 改变验证码按钮
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeTextfield.mas_bottom).offset(25);
        make.left.mas_equalTo(self.testView.mas_right).offset(15);
        make.right.mas_equalTo(self.codeView.mas_right).offset(-15);
    }];
    
    [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.codeView.mas_right).offset(-25);
        make.bottom.equalTo(self.codeView.mas_bottom).offset = -5;
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeView.mas_left).offset(25);
        make.bottom.equalTo(self.codeView.mas_bottom).offset = -5;
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.changeButton.mas_bottom).offset = 15;
        make.height.mas_equalTo(1);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.codeView.mas_centerX);
        make.top.equalTo(self.lineView.mas_bottom).offset = 0;
        make.bottom.equalTo(self.codeView.mas_bottom).offset = 0;
        make.width.mas_equalTo(1);
    }];
    
}

#pragma mark - 懒加载
-(UIButton *)okButton{
    if (!_okButton) {
        
        _okButton = [[UIButton alloc]init];
        
        [_okButton setTitle:@"确定" forState:UIControlStateNormal];
        
        [_okButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        [_okButton setTitleColor:[UIColor colorWithHexString:@"#ff8400"] forState:UIControlStateNormal];
        
        [_okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okButton;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        
        _cancelButton = [[UIButton alloc]init];
        
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        [_cancelButton setTitleColor:[UIColor colorWithHexString:@"#ff8400"] forState:UIControlStateNormal];
        
        [_cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        
        [_titleLabel setText:@"获取验证码"];
        
        [_titleLabel setTextColor:[UIColor colorWithHexString:@"#111111"]];
        
        [_titleLabel setFont:[UIFont systemFontOfSize:16]];
    }
    return _titleLabel;
}

-(UITextField *)codeTextfield{
    
    if (!_codeTextfield) {
        
        _codeTextfield = [[UITextField alloc]init];
        
        _codeTextfield.placeholder = @"请输入校检码";
        
        _codeTextfield.font = [UIFont systemFontOfSize:15];
        
        _codeTextfield.textColor = [UIColor colorWithHexString:@"#AAAAAA"];
        
        _codeTextfield.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
        
        _codeTextfield.layer.masksToBounds = YES;
        
        _codeTextfield.layer.cornerRadius = 8.0f;
        
        _codeTextfield.layer.borderWidth = 0.5f;
        
        _codeTextfield.delegate = self;
        
        _codeTextfield.layer.borderColor = [UIColor colorWithHexString:@"#dcdcdc"].CGColor;
        
        _codeTextfield.returnKeyType = UIReturnKeyDone;
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        _codeTextfield.leftView = leftView;
        
        _codeTextfield.leftViewMode = UITextFieldViewModeAlways;
    }
    return _codeTextfield;
}

-(UIButton *)changeButton{
    
    if (!_changeButton) {
        _changeButton = [[UIButton alloc]init];
        
        [_changeButton setTitle:@"看不清,换一张" forState:UIControlStateNormal];
        
        _changeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        
        [_changeButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        
        [_changeButton addTarget:self action:@selector(ChangeCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeButton;
}
-(UIView *)lineView{
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#dcdcdc"];
    }
    return _lineView;
}
-(UIView *)secondView{
    if (!_secondView) {
        
        _secondView = [[UIView alloc]init];
        
        _secondView.backgroundColor = [UIColor colorWithHexString:@"#dcdcdc"];
    }
    return _secondView;
}
-(UIView *)backView{
    
    if (!_backView) {
        _backView = [[UIView alloc]init];
        
        _backView.tag = 2016;
        
        _backView.backgroundColor = [UIColor colorWithRed:(211.0/255.0) green:(211.0/255.0) blue:(211.0/255.0) alpha:0.4];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverViewTap)];
        
        singleTap.delegate = self;
        
        [_backView addGestureRecognizer:singleTap];
        
        
    }
    return _backView;
}
-(UIView *)codeView{
    
    if (!_codeView) {
        _codeView = [[UIView alloc]init];
        
        _codeView = [[UIView alloc]init];
        
        _codeView.backgroundColor = [UIColor whiteColor];
        
        _codeView.layer.cornerRadius = 4.0f;
        
        _codeView.layer.masksToBounds = YES;
    }
    return _codeView;
}
-(MCTestView *)testView{
    if (!_testView) {
        
        _testView = [[MCTestView alloc]init];
        
        _testView.backgroundColor = [UIColor whiteColor];
    }
    return _testView;
}
#pragma mark - 按钮点击事件
- (void)okButtonClick{
    
    if ([self.codeTextfield.text caseInsensitiveCompare:self.testView.charStr] == NSOrderedSame) {
        NSLog(@"验证码正确");
    }
    else{
        NSLog(@"验证码错误");
    }
    
}
- (void)cancelButtonClick{
    
    if (self.backView) {
        [self.backView removeFromSuperview];
        self.backView = nil;
    }
    
    if (self.codeView) {
        [self.codeView removeFromSuperview];
        self.codeView = nil;
    }
    
}
-(void)ChangeCode{
    
    [self.testView getCode];
    
    [self.testView setNeedsDisplay];
    
}
-(void)coverViewTap{
    
    [self cancelButtonClick];
}
#pragma mark - 获取验证码
- (void)getCode{
    [self layuoutView];
}


@end
@implementation UIView (codeCategory)
#pragma mark - 动态绑定属性
- (void)setCodeView:(MCCodeViewController *)view{
    
    objc_setAssociatedObject(self, &codeViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC   );
    
}

-(MCCodeViewController *)codeView{
    
    return objc_getAssociatedObject(self, &codeViewKey);
    
}
- (void)show{
    MCCodeViewController *codeVC = [[MCCodeViewController alloc]init];
    [codeVC getCode];
    self.codeView = codeVC;
    
}
- (void)hide{
    if (self.codeView) {
        [self.codeView cancelButtonClick];
    }
}
@end
