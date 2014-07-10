//
//  CameraViewController.m
//  MyDiary
//
//  Created by 刘 铭 on 12-11-16.
//  Copyright (c) 2012年 刘铭. All rights reserved.
//

#import "CameraViewController.h"
#import "ImageStore.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doDismiss:(id)sender {
    [self.delegate cameraViewControllerDidReturn:self];
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    // 如果设备的摄像头可以使用则进行拍照，否则使用照片库
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker
         setSourceType:UIImagePickerControllerSourceTypeCamera];
    }else {
        [imagePicker
         setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    // 设置imagePicker的delegate属性，使他指向当前控制器
    [imagePicker setDelegate:self];
    
    // 将UIImagePickerController的视图呈现在屏幕上面
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *oldPhotoKey = [self.diary photoKey];
    
    if (oldPhotoKey) {
        // 删除之前的老照片
        [[ImageStore defaultImageStore] deleteImageForKey:oldPhotoKey];
    }
    
    // 从info中获取用户选择的照片信息
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // 创建一个CFUUID类型的对象
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    
    // 创建一个字符串
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    [self.diary setPhotoKey:(__bridge NSString *)newUniqueIDString];
    
    // 前面使用Create创建的Core Foundation，在不使用的时候需要将其释放
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    
    // 使用键名将图像存入ImageStore
    [[ImageStore defaultImageStore] setImage:image forKey:[self.diary photoKey]];
    
    [self.picture setImage:image];
    
    // 销毁UIImagePickerController控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
