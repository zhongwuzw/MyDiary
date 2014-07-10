//
//  RecordViewController.m
//  MyDiary
//
//  Created by 刘铭 on 12-11-18.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()

@end

@implementation RecordViewController

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
    
    if (self.diary.audioFileName != nil) {
        self.playButton.hidden = NO;
    }else {
        self.playButton.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 修改之前的recordOption:方法中参数的类型，由id改为UIButton
- (IBAction)recordOption:(UIButton *)sender {
    NSError *error = nil;
    // 如果当前录音按钮的标题为录音，在用户点击时执行的代码
    if ([sender.titleLabel.text isEqualToString:@"录音"]) {
        NSString *pathAsString = [self audioRecordingPath];
        NSURL *audioRecordingURL = [NSURL fileURLWithPath:pathAsString];
        
        self.audioRecorder = [[AVAudioRecorder alloc]
                              initWithURL:audioRecordingURL
                              settings:[self audioRecordingSettings]
                              error:&error];
        
        if (self.audioRecorder != nil) {
            self.audioRecorder.delegate = self;
            
            if ([self.audioRecorder prepareToRecord] &&
                [self.audioRecorder record]) {
                self.recordButton.titleLabel.text = @"停止录音";
                [self.recordButton setTitle:@"停止录音"
                              forState:UIControlStateNormal];
                self.recordInfo.text = @"成功开始录音！";
            }else {
                self.recordInfo.text = @"录音失败！";
                self.audioRecorder = nil;
            }
        }else {
            NSLog(@"创建audio recorder实例失败！");
        }
    }
    // 如果当前录音按钮的标题为停止录音，在用户点击时执行的代码
    else if ([sender.titleLabel.text isEqualToString:@"停止录音"]) {
        [self stopRecordingOnAudioRecorder:self.audioRecorder];
        [self.recordButton setTitle:@"录音" forState:UIControlStateNormal];
    }
}

- (void) stopRecordingOnAudioRecorder :(AVAudioRecorder *)aRecorder{
    [aRecorder stop];
    NSLog(@"录音结束！");
}

- (IBAction)doDismiss:(id)sender {
    [self.delegate recordViewControllerDidReturn:self];
}

- (IBAction)playOption:(id)sender {
    NSArray *folders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsFolder = [folders objectAtIndex:0];
    
    NSData *fileData = [NSData dataWithContentsOfFile:[documentsFolder stringByAppendingPathComponent:self.diary.audioFileName]];
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:nil];
    
    // 开始播放音频
    if (self.audioPlayer != nil){
        // 设置AVAudioPlayer的delegate并播放声音
        self.audioPlayer.delegate = self;
        if ([self.audioPlayer prepareToPlay] && [self.audioPlayer play]){
            self.recordInfo.text = @"正常播放音频文件！";
        } else {
            self.recordInfo.text = @"播放音频失败！";
        }
    } else {
        NSLog(@"初始化AVAudioPlayer失败。");
    }
}

- (NSString *)audioRecordingPath
{
    NSString *path = nil;
    NSArray *folders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsFolder = [folders objectAtIndex:0];
    
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    NSString *fileName = (__bridge NSString *)newUniqueIDString;
    // 向字符串后面添加指定的文件扩展名
    self.diary.audioFileName = [fileName stringByAppendingPathExtension:@"m4a"];
    
    // 前面使用Create创建的Core Foundation，在不使用的时候需要将其释放
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    
    path = [documentsFolder stringByAppendingPathComponent:self.diary.audioFileName];
    
    return path;
}

-(NSDictionary *)audioRecordingSettings
{
    NSDictionary *result = nil;
    
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    
    [settings setValue:[NSNumber numberWithInteger:kAudioFormatAppleLossless]
                forKey:AVFormatIDKey];
    
    [settings setValue:[NSNumber numberWithFloat:44100.0f]
                forKey:AVSampleRateKey];
    
    [settings setValue:[NSNumber numberWithInteger:1]
                forKey:AVNumberOfChannelsKey];
    
    [settings setValue:[NSNumber numberWithInteger:AVAudioQualityLow]
                forKey:AVEncoderAudioQualityKey];
    
    result = [NSDictionary dictionaryWithDictionary:settings];
    return result;
}

-(void)viewWillDisappear:(BOOL)animated
{
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder stop];
        NSLog(@"录音结束！");
    }
    
    self.audioRecorder = nil;
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (flag) {
        NSLog(@"录音正常结束。");
        [self.playButton setHidden:NO];
    }
}

-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    // 如果有声音正在播放，则暂停
}

-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player
                        withFlags:(NSUInteger)flags
{
    if (flags == AVAudioSessionInterruptionFlags_ShouldResume &&
        player != nil) {
        [player play];
    }
}

- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder{
    NSLog(@"录音过程被中断");
}

- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder
                           withFlags:(NSUInteger)flags{
    if (flags == AVAudioSessionInterruptionFlags_ShouldResume)
    {
        NSLog(@"恢复录音");
        [recorder record];
    }
}


@end
