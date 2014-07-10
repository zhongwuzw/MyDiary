//
//  CreateDiaryViewController.h
//  MyDiary
//
//  Created by 刘 铭 on 12-11-15.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Diary.h"
#import "CameraViewController.h"
#import "RecordViewController.h"

@class CreateDiaryViewController;

@protocol CreateDiaryViewControllerDelegate
// 必须实现的两个协议方法
@required
// 当用户点击返回按钮以后所实现的方法
- (void)createDiaryViewControllerDidCancel:(CreateDiaryViewController *)createDiaryController;
// 当用户点击保存按钮以后实现的协议方法，data是Diary类型的一个对象
- (void)createDiaryViewController:(CreateDiaryViewController *)createDiaryController didSaveWithDiary:(Diary *)theDiary;
@end

@interface CreateDiaryViewController : UIViewController
<UITextFieldDelegate, CameraViewControllerDelegate, RecordViewControllerDelegate, UITextViewDelegate>

@property float keyboardY;
@property float statusBarHeight;
@property (weak, nonatomic) UITextView *currentTextView;

// 声明id类型的delegate实例变量，用于保存符合
// CreateDiaryViewControllerDelegate协议的对象指针
@property (weak, nonatomic) id <CreateDiaryViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *diaryDate;
@property (weak, nonatomic) IBOutlet UITextField *diaryTitle;
@property (weak, nonatomic) IBOutlet UITextView *diaryContent;
@property (strong, nonatomic) Diary *diary;

@property (strong, nonatomic) UIButton *doneInKeyboardButton;

- (IBAction)cancel:(id)sender;
- (IBAction)saveDiary:(id)sender;

@end
