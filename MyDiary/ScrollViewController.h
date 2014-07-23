//
//  ScrollViewController.h
//  MyDiary
//
//  Created by liumingl on 12-11-30.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewController : UIViewController
<UITextFieldDelegate>

// 记录弹出的虚拟键盘在屏幕中Y坐标的位置
@property float keyboardY;
// 记录状态栏的高度值
@property float statusBarHeight;
// 指向当前用户操作的Text Field对象
@property (weak, nonatomic) UITextField *currentTextField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (strong, nonatomic) MKNetworkOperation *loginOperation;

- (IBAction)createAccount:(id)sender;
@end
