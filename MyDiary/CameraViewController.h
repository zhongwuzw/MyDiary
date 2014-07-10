//
//  CameraViewController.h
//  MyDiary
//
//  Created by 刘 铭 on 12-11-16.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Diary.h"

@class CameraViewController;

@protocol CameraViewControllerDelegate
- (void)cameraViewControllerDidReturn:(CameraViewController *)cameraViewController;
@end

@interface CameraViewController : UIViewController
<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) id <CameraViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (strong, nonatomic) Diary *diary;

- (IBAction)doDismiss:(id)sender;
- (IBAction)takePicture:(id)sender;

@end
