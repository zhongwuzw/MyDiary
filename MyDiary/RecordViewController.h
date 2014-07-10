//
//  RecordViewController.h
//  MyDiary
//
//  Created by 刘铭 on 12-11-18.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Diary.h"

@class RecordViewController;

@protocol RecordViewControllerDelegate
- (void)recordViewControllerDidReturn:(RecordViewController *)recordViewController;
@end

@interface RecordViewController : UIViewController
<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
@property (weak, nonatomic) id <RecordViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *recordInfo;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) Diary *diary;

- (IBAction)recordOption:(id)sender;
- (IBAction)doDismiss:(id)sender;
- (IBAction)playOption:(id)sender;

- (NSString *) audioRecordingPath;
- (NSDictionary *)audioRecordingSettings;

@end
