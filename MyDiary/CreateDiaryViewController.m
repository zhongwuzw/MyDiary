//
//  CreateDiaryViewController.m
//  MyDiary
//
//  Created by 刘 铭 on 12-11-15.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "CreateDiaryViewController.h"

@interface CreateDiaryViewController ()

@end

@implementation CreateDiaryViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TakePicture"]) {
        CameraViewController *cameraViewController = (CameraViewController *)[segue destinationViewController];
        // 设置createDiaryViewController对象的delegate属性
        cameraViewController.delegate = self;
        
        cameraViewController.diary = self.diary;
    }
    if ([segue.identifier isEqualToString:@"Record"]) {
        RecordViewController *recordViewController =
        (RecordViewController *)[segue destinationViewController];
        recordViewController.delegate = self;
        
        recordViewController.diary = self.diary;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.diary = [[Diary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.diary = [[Diary alloc] init];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy年M月d日 'at' h:mm a"];
    NSString* date = [df stringFromDate: [NSDate date]];
    self.diaryDate.text = date;
}

-(void)viewWillAppear:(BOOL)animated
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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.currentTextView = textView;
    
    float textViewTop = self.currentTextView.frame.origin.y;
    float textViewBottom = textViewTop + self.currentTextView.frame.size.height;
    
    if ((textViewBottom > self.keyboardY) && (self.keyboardY != 0.0)) {
        [(UIScrollView *)self.view setContentOffset:CGPointMake(0,
                                                                textViewBottom - self.keyboardY + self.statusBarHeight) animated:YES];
    }
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    // 如果doneInKeyboardButton按钮出现在屏幕上，将其从视图中移除
    if (self.doneInKeyboardButton.superview)
    {
        [self.doneInKeyboardButton removeFromSuperview];
    }
    
    [(UIScrollView *)self.view setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect keyboardFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    
    self.statusBarHeight = statusBarFrame.size.height;
    self.keyboardY = keyboardFrame.origin.y;
    
    float textViewTop = self.currentTextView.frame.origin.y;
    float textViewBottom = textViewTop + self.currentTextView.frame.size.height;
    
    if (textViewBottom > self.keyboardY) {
        [(UIScrollView *)self.view setContentOffset:CGPointMake(0, textViewBottom - self.keyboardY + self.statusBarHeight)
                                           animated:YES];
    }
    
    // 如果doneInKeyboardButton没有被实例化，则创建它
    if (self.doneInKeyboardButton == nil)
    {
        // 设置按钮的类型为自定义
        self.doneInKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 设置按钮在view中的位置和大小
        self.doneInKeyboardButton.frame = CGRectMake(keyboardFrame.size.width - 30, keyboardFrame.origin.y - 25, 30, 25);
        // 设置按钮上面显示的图标
        self.doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
        [self.doneInKeyboardButton setImage:[UIImage
                                        imageNamed:@"doneInKeyboard.png"]
                              forState:UIControlStateNormal];
        // 设置当用户点击按钮后所执行的方法
        [self.doneInKeyboardButton addTarget:self
                                 action:@selector(handleDoneInKeyboard:)
                       forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 获取虚拟键盘所在在视图
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    
    // 将自定义的按钮显示在虚拟键盘所在的视图上
    if (self.doneInKeyboardButton.superview == nil)
    {
        [tempWindow addSubview:self.doneInKeyboardButton];    // 注意这里直接加到window上
    }
}

- (void)handleDoneInKeyboard:(id) sender
{
    [self.currentTextView resignFirstResponder];
}

- (IBAction)cancel:(id)sender {
    [self.delegate createDiaryViewControllerDidCancel:self];
}

- (IBAction)saveDiary:(id)sender {
    self.diary.title = self.diaryTitle.text;
    self.diary.content = self.diaryContent.text;
    
    [self.delegate createDiaryViewController:self didSaveWithDiary:self.diary];
}

#pragma mark - camera view controller Delegate
-(void)cameraViewControllerDidReturn:(CameraViewController *)cameraViewController
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - record view controller Delegate
-(void)recordViewControllerDidReturn:(RecordViewController *)recordViewController
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - Text Field Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
