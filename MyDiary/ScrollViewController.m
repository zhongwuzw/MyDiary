//
//  ScrollViewController.m
//  MyDiary
//
//  Created by liumingl on 12-11-30.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

@end

@implementation ScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    self.emailField.delegate = self;
    self.addressField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
}

-(void) keyboardDidShow:(NSNotification *) notification
{
    // 获取虚拟键盘在屏幕垂直方向的坐标值
    NSDictionary* info = [notification userInfo];
    CGRect keyboardFrame = [[info
                             objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 获取屏幕上状态栏的高度值
    CGRect statusBarFrame = [[UIApplication sharedApplication]
                             statusBarFrame];
    
    self.statusBarHeight = statusBarFrame.size.height;
    self.keyboardY = keyboardFrame.origin.y;
    
    float textFieldTop = self.currentTextField.frame.origin.y;
    float textFieldBottom = textFieldTop +
    self.currentTextField.frame.size.height;
    
    if (textFieldBottom > self.keyboardY) {
        [self.scrollView setContentOffset:CGPointMake(0, textFieldBottom - self.keyboardY + self.statusBarHeight) animated:YES];
    }
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    // 将currentTextField指向到用户当前交互的Text Field
    self.currentTextField = textField;
    
    float textFieldTop = self.currentTextField.frame.origin.y;
    float textFieldBottom = textFieldTop +
    self.currentTextField.frame.size.height;
    
    if ((textFieldBottom > self.keyboardY) && (self.keyboardY != 0.0)) {
        [self.scrollView setContentOffset:CGPointMake(0, textFieldBottom -
                                                 self.keyboardY + self.statusBarHeight) animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 当用户点击虚拟键盘的return按钮后，让键盘消失
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)createAccount:(id)sender {
}
@end
