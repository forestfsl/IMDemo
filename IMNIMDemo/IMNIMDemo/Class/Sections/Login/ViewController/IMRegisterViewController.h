//
//  IMRegisterViewController.h
//  IMNIMDemo
//
//  Created by songlin on 2018/8/6.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IMRegisterViewControllerDelegate <NSObject>

@optional

- (void)registDidComplete:(NSString *)account password:(NSString *)password;
@end

@interface IMRegisterViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *accountTextfield;

@property (nonatomic, weak) IBOutlet UITextField *nicknameTextfield;

@property (nonatomic, weak) IBOutlet UITextField *passwordTextfield;

@property (nonatomic, weak) IBOutlet UIView *containView;

@property (nonatomic, weak) IBOutlet UIButton *existedButton;

@property (nonatomic, weak) IBOutlet UIImageView *logo;

@property (nonatomic, weak) id<IMRegisterViewControllerDelegate> delegate;

@end
