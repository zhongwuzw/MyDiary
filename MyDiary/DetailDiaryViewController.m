//
//  DetailDiaryViewController.m
//  MyDiary
//
//  Created by 刘铭 on 12-11-14.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "DetailDiaryViewController.h"
#import "ImageStore.h"

@interface DetailDiaryViewController ()

@end

@implementation DetailDiaryViewController

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
}

-(void)viewWillAppear:(BOOL)animated
{
   // self.view.backgroundColor = [UIColor clearColor];
    [super viewWillAppear:animated];
    
    NSLog(@"%@",self.diary.title);
    
    NSString *audioFileName = [self.diary audioFileName];
    if (audioFileName) {
        [self.audioButton setHidden:NO];
    }else {
        [self.audioButton setHidden:YES];
    }
    
    self.diaryTitle.text = self.diary.title;
    self.diaryContent.text = self.diary.content;
    
    NSLog(@"diary is %@",self.diaryTitle.text);
    NSLog(@"diary is %@",self.diaryContent.text);
    
    NSString *photoKey = [self.diary photoKey];
    
    if (photoKey) {
        UIImage *imageToDisplay = [[ImageStore defaultImageStore]
                                   imageForKey:photoKey];
        [self.diaryPhoto setImage:imageToDisplay];
    }else {
        [self.diaryPhoto setImage:nil];
    }
    
    // 修改导航栏标题为“日记内容”
    [[self navigationItem] setTitle:@"日记内容"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playAudio:(id)sender {
    NSArray *folders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsFolder = [folders objectAtIndex:0];
    
    NSData *fileData = [NSData dataWithContentsOfFile:[documentsFolder
                                                       stringByAppendingPathComponent:self.diary.audioFileName]];
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:nil];
    
    // 开始播放音频
    if (self.audioPlayer != nil){
        if ([self.audioPlayer prepareToPlay] && [self.audioPlayer play]){
            NSLog(@"正常播放音频文件");
        } else {
            NSLog(@"播放失败");
        }
    } else {
        NSLog(@"初始化AVAudioPlayer失败。");
    }
}
@end
