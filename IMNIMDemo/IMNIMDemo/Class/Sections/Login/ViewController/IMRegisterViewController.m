//
//  IMRegisterViewController.m
//  IMNIMDemo
//
//  Created by songlin on 2018/8/6.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import "IMRegisterViewController.h"
#import "IMDemoRegisterTask.h"
#import "NSString+IM.h"
#import "UIView+Toast.h"
#import "UIView+IM.h"
#import "SVProgressHUD.h"
#import "IMDemoService.h"

@interface IMRegisterViewController ()

@end

@implementation IMRegisterViewController

NTES_USE_CLEAR_BAR
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self resetTextField:self.accountTextfield];
    [self resetTextField:self.nicknameTextfield];
    [self resetTextField:self.passwordTextfield];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self setupNav];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)setupNav
{
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"完成" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [registerBtn setTitleColor:UIColorFromRGB(0x2294ff) forState:UIControlStateNormal];
    
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_done_normal"] forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"login_btn_done_pressed"] forState:UIControlStateHighlighted];
    [registerBtn addTarget:self
                    action:@selector(onRegister:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [registerBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:registerBtn];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UIImage *image = [UIImage imageNamed:@"icon_back_normal.png"];
    [self.navigationController.navigationBar setBackIndicatorImage:image];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:image];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0xffffff)];
    self.navigationItem.backBarButtonItem = backItem;
    _containView.backgroundColor = [UIColor clearColor];
}

- (void)onRegister:(id)sender
{
    IMRegisterData *data = [[IMRegisterData alloc] init];
    data.account = [_accountTextfield text];
    data.nickname= [_nicknameTextfield text];
    data.token = [[_passwordTextfield text] tokenByPassword];
    if (![self check]) {
        return;
    }
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    
    [[IMDemoService sharedService] registerUser:data
                                       completion:^(NSError *error, NSString *errorMsg) {
                                           [SVProgressHUD dismiss];
                                           if (error == nil) {
                                               [weakSelf.navigationController.view makeToast:@"注册成功"
                                                                                    duration:2
                                                                                    position:CSToastPositionCenter];
                                               if ([weakSelf.delegate respondsToSelector:@selector(registDidComplete:password:)]) {
                                                   [weakSelf.delegate registDidComplete:data.account password:[weakSelf.passwordTextfield text]];
                                               }
                                               [weakSelf.navigationController popViewControllerAnimated:YES];
                                           }
                                           else
                                           {
                                               if ([weakSelf.delegate respondsToSelector:@selector(registDidComplete:password:)]) {
                                                   [weakSelf.delegate registDidComplete:nil password:nil];
                                               }
                                               
                                               NSString *toast = [NSString stringWithFormat:@"注册失败"];
                                               if ([errorMsg isKindOfClass:[NSString class]] &&errorMsg.length) {
                                                   toast = [toast stringByAppendingFormat:@": %@",errorMsg];
                                               }
                                               [weakSelf.view makeToast:toast
                                                               duration:2
                                                               position:CSToastPositionCenter];
                                               
                                           }
                                           
                                       }];
}


- (IBAction)exist:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onChanged:(id)sender
{
    BOOL enabled = [[_accountTextfield text] length] &&
    [[_nicknameTextfield text] length] &&
    [[_passwordTextfield text] length];
    [self.navigationItem.rightBarButtonItem setEnabled:enabled];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSDictionary* userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    CGFloat bottomSpacing = -5.f;
    UIView *inputView = self.passwordTextfield.superview;
    if (inputView.bottom + bottomSpacing > CGRectGetMinY(keyboardFrame)) {
        CGFloat delta;
        if (UIScreenHeight >= 568) {
            delta = self.existedButton.bottom + bottomSpacing - CGRectGetMinY(keyboardFrame);
            self.existedButton.bottom -= delta;
        }else{
            delta = inputView.bottom + bottomSpacing - CGRectGetMinY(keyboardFrame);
        }
        inputView.bottom -= delta;
    }
    if (self.logo.bottom > self.navigationController.navigationBar.bottom) {
        self.logo.bottom = self.navigationController.navigationBar.bottom;
        self.logo.alpha  = 0;
        self.navigationItem.title = @"注册";
    }
    [UIView commitAnimations];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self onRegister:nil];
        return NO;
    }
    return YES;
}

#pragma mark - Private
- (void)resetTextField:(UITextField *)textField{
    textField.tintColor = [UIColor whiteColor];
    [textField setValue:UIColorFromRGBA(0xffffff, .6f) forKeyPath:@"_placeholderLabel.textColor"];
    textField.tintColor = [UIColor whiteColor];
    UIButton *clearButton = [textField valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:@"login_icon_clear"] forState:UIControlStateNormal];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_accountTextfield resignFirstResponder];
    [_nicknameTextfield resignFirstResponder];
    [_passwordTextfield resignFirstResponder];
}


- (BOOL)check{
    if (!self.checkAccount) {
        [self.view makeToast:@"账号长度有误"
                    duration:2
                    position:CSToastPositionCenter];
        
        return NO;
    }
    if (!self.checkPassword) {
        [self.view makeToast:@"密码长度有误"
                    duration:2
                    position:CSToastPositionCenter];
        
        return NO;
    }
    if (!self.checkNickname) {
        [self.view makeToast:@"昵称长度有误"
                    duration:2
                    position:CSToastPositionCenter];
        
        return NO;
    }
    return YES;
}

- (BOOL)checkAccount{
    NSString *account = [_accountTextfield text];
    return account.length > 0 && account.length <= 20;
}

- (BOOL)checkPassword{
    NSString *checkPassword = [_passwordTextfield text];
    return checkPassword.length >= 6 && checkPassword.length <= 20;
}

- (BOOL)checkNickname{
    NSString *nickname= [_nicknameTextfield text];
    return nickname.length > 0 && nickname.length <= 10;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
