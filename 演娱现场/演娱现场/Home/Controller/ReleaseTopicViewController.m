//
//  ReleaseTopicViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/29.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "ReleaseTopicViewController.h"

@interface ReleaseTopicViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *TemplateOne;
@property (weak, nonatomic) IBOutlet UIButton *TemplateTwo;
@property (weak, nonatomic) IBOutlet UIButton *TemplateThree;
@property (weak, nonatomic) IBOutlet UITextField *titleNaem;
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (weak, nonatomic) IBOutlet UIButton *image1;
@property (weak, nonatomic) IBOutlet UIButton *image2;
@property (weak, nonatomic) IBOutlet UIButton *image3;

@property(nonatomic,strong)UIImage *image;

@end

@implementation ReleaseTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建话题";
    self.view.backgroundColor = WYRGb(220, 220, 220);
    [self addAGesutreRecognizerForYourView];
    //设置页面
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark --------按钮点击
//模板一按钮点击
- (IBAction)TemplateOneButClick:(id)sender {
    [self.TemplateOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.TemplateTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.TemplateThree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.image1.hidden = NO;
    self.image2.hidden = YES;
    self.image3.hidden = YES;
}
//模板二按钮点击
- (IBAction)TemplateTwoClick:(id)sender {
    [self.TemplateOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.TemplateTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.TemplateThree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.image1.hidden = NO;
    self.image2.hidden = YES;
    self.image3.hidden = YES;
}
//模板三按钮点击
- (IBAction)TemplateThreeClick:(id)sender {
    [self.TemplateOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.TemplateTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.TemplateThree setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.image1.hidden = NO;
    self.image2.hidden = NO;
    self.image3.hidden = NO;
}
//图片1点击
- (IBAction)image1ButClick:(id)sender {
    //进入相册
    self.image1.selected = YES;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    //                imagePicker.allowsEditing = YES; //允许照片可以被编辑
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //            [self presentModalViewController:imagePicker animated:YES];
    [self presentViewController:imagePicker animated:YES completion:nil];

}
//图片2点击
- (IBAction)image2ButClick:(id)sender {
    //进入相册
    self.image2.selected = YES;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    //                imagePicker.allowsEditing = YES; //允许照片可以被编辑
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //            [self presentModalViewController:imagePicker animated:YES];
    [self presentViewController:imagePicker animated:YES completion:nil];
}
//图片3点击
- (IBAction)image3ButClick:(id)sender {
    //进入相册
    self.image3.selected = YES;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    //                imagePicker.allowsEditing = YES; //允许照片可以被编辑
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //            [self presentModalViewController:imagePicker animated:YES];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark --------创建按钮
- (IBAction)CreateButClick:(id)sender {

    NSString *imageStr = [self imageBase64WithDataURL:self.image proportion:1];
    NSDictionary *dict = @{@"userId":@"27",@"modleType":@"1",@"title":self.titleNaem.text?self.titleNaem.text:@"",@"message":self.message.text?self.message.text:@"",@"image1":imageStr};
    [WYHttpTool postHttps:SAVETOPIC param:dict Success:^(NSDictionary *dict, BOOL success) {
        if ([dict[@"code"]isEqualToString:@"0"]) {
            [self ShowMBProgressHUD:@"发布成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        WYLog(@"%@",dict);
    } fail:^(NSError *error) {
        WYLog(@"%@",error);
    }];

    
                         
}
#pragma mark --------相册的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //添加图片
    [self addImageView:info];

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //添加图片
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --------添加图片
- (void)addImageView:(NSDictionary *)info{
    //设置返回图片的尺寸
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.image = image;
    if (self.image1.selected == YES) {
        [self.image1 setBackgroundImage:image forState:UIControlStateNormal];
    }else if (self.image2.selected == YES){
    [self.image2 setBackgroundImage:image forState:UIControlStateNormal];
    }else if (self.image3.selected == YES){
    [self.image3 setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    self.image1.selected = NO;
    self.image2.selected = NO;
    self.image3.selected = NO;
}
#pragma mark --------拍照按钮点击
- (void)cameraButClick{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    //                imagePicker.allowsEditing = YES; //允许照片可以被编辑
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //            [self presentModalViewController:imagePicker animated:YES];
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
#pragma mark --------取消按钮点击
- (void)cancelButClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (NSString *)imageBase64WithDataURL:(UIImage *)image proportion:(CGFloat)proportion
{
    NSData *imageData =nil;
    //图片要压缩的比例，此处100根据需求，自行设置
     CGFloat x =proportion / image.size.height;
    if (x >1)
    {
        x = 1.0;
    }
    imageData = UIImageJPEGRepresentation(image, x);
    return [imageData base64EncodedStringWithOptions:0];
}
@end
