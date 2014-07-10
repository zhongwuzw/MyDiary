//
//  DetailDiaryViewController.h
//  MyDiary
//
//  Created by 刘铭 on 12-11-14.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "Diary.h"

@interface DetailDiaryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *diaryTitle;
@property (weak, nonatomic) IBOutlet UITextView *diaryContent;
@property (strong, nonatomic) Diary *diary;
@property (weak, nonatomic) IBOutlet UIImageView *diaryPhoto;
@property (weak, nonatomic) IBOutlet UIButton *audioButton;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
- (IBAction)playAudio:(id)sender;

@end
