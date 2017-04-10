//
//  IDInformationViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/20.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "IDInformationViewController.h"

@interface IDInformationViewController ()<UIActionSheetDelegate>
{
    UIActionSheet* _actionSheet;
}
/**滚动的scrollView*/
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)WyBut *leftCredentialsBut;
@property(nonatomic,weak)WyBut *rightCredentialsBut;
@property(nonatomic,weak)WyBut *bottomLeftCredentialsBut;
@property(nonatomic,weak)WyBut *bottomRightCredentialsBut;
@property(nonatomic,weak)WyBut *partitionViewLeftCredentials;
@property(nonatomic,copy)NSString *leftCredentialsStr;
@property(nonatomic,copy)NSString *rightCredentialsStr;
@property(nonatomic,copy)NSString *bottomLeftCredentialsStr;
@property(nonatomic,copy)NSString *bottomRightCredentialsStr;
@property(nonatomic,copy)NSString *partitionViewLeftCredentialsStr;
@end

@implementation IDInformationViewController
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        //隐藏指示条
        scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView = scrollView;
        scrollView.frame = self.view.bounds;
        scrollView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        [self.view addSubview:scrollView];
    }
    return  _scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置页面
    [self setupUi];
}
#pragma mark --------设置页面
-(void)setupUi{
    //加载弹出框
    
    _actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    //设置顶部的view
    UIView *topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0, WYmargin, ScreenWidth, ScreenWidth*0.618);
    topView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:topView];
    
    //身份证上传
    UILabel *information = [[UILabel alloc]init];
    information.font = Font16;
    information.text = @"身份证上传";
    information.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:information];
    information.sd_layout.leftSpaceToView(topView,WYmargin).topEqualToView(topView).rightEqualToView(topView).heightRatioToView(topView,0.25);
    //设置分割线
    UIView *informationWire = [[UIView alloc]init];
    informationWire.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [topView addSubview:informationWire];
    informationWire.sd_layout.leftSpaceToView(topView,WYmargin).topSpaceToView(information,0).rightSpaceToView(topView,WYmargin).heightIs(1);
    //证件图片
    UILabel *credentials = [[UILabel alloc]init];
    credentials.font = Font16;
    credentials.text = @"证件图片";
    credentials.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:credentials];
    credentials.sd_layout.leftSpaceToView(topView,WYmargin).topSpaceToView(informationWire,0).widthRatioToView(topView,0.25).heightRatioToView(topView,0.25);
    
    //左面的证件图片
    WyBut *leftCredentialsBut = [[WyBut alloc]init];
    _leftCredentialsBut = leftCredentialsBut;
    [leftCredentialsBut setBackgroundImage:[UIImage imageNamed:@"点此上传"] forState:UIControlStateNormal];
    
    [leftCredentialsBut addTarget:self action:@selector(leftCredentialsButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:leftCredentialsBut];
    leftCredentialsBut.sd_layout.leftSpaceToView(credentials,0).topSpaceToView(information,WYmargin*2+WYmargin2).widthRatioToView(topView,0.3).heightEqualToWidth();
    
    //右面的证件图片
    WyBut *rightCredentialsBut = [[WyBut alloc]init];
    _rightCredentialsBut = rightCredentialsBut;
    [rightCredentialsBut setBackgroundImage:[UIImage imageNamed:@"点此上传"] forState:UIControlStateNormal];
    [rightCredentialsBut addTarget:self action:@selector(rightCredentialsButClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightCredentialsBut];
    rightCredentialsBut.sd_layout.leftSpaceToView(leftCredentialsBut,WYmargin2).topSpaceToView(information,WYmargin*2+WYmargin2).widthRatioToView(topView,0.3).heightEqualToWidth();
    
    //设置底部
    UIView *bottomView = [[UIView alloc]init];
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(topView.frame)+WYmargin2+WYmargin, ScreenWidth, ScreenWidth*0.618);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:bottomView];
    
    //银行卡上传
    UILabel *BankCard = [[UILabel alloc]init];
    BankCard.font = Font16;
    BankCard.text = @"银行卡上传";
    BankCard.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:BankCard];
    BankCard.sd_layout.leftSpaceToView(bottomView,WYmargin).topEqualToView(bottomView).rightEqualToView(bottomView).heightRatioToView(topView,0.25);
    //设置分割线
    UIView *bottomViewInformationWire = [[UIView alloc]init];
    bottomViewInformationWire.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [bottomView addSubview:bottomViewInformationWire];
    bottomViewInformationWire.sd_layout.leftSpaceToView(bottomView,WYmargin).topSpaceToView(BankCard,0).rightSpaceToView(bottomView,WYmargin).heightIs(1);
    //证件图片
    UILabel * bottomCredentials = [[UILabel alloc]init];
    bottomCredentials.font = Font16;
    bottomCredentials.text = @"证件图片";
    bottomCredentials.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:bottomCredentials];
    bottomCredentials.sd_layout.leftSpaceToView(bottomView,WYmargin).topSpaceToView(bottomViewInformationWire,0).widthRatioToView(bottomView,0.25).heightRatioToView(bottomView,0.25);
    
    //左面的证件图片
    WyBut * bottomLeftCredentialsBut = [[WyBut alloc]init];
    _bottomLeftCredentialsBut = bottomLeftCredentialsBut;
     [bottomLeftCredentialsBut addTarget:self action:@selector(bottomLeftCredentialsButClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomLeftCredentialsBut setBackgroundImage:[UIImage imageNamed:@"点此上传"] forState:UIControlStateNormal];
    [bottomView addSubview:bottomLeftCredentialsBut];
    bottomLeftCredentialsBut.sd_layout.leftSpaceToView(bottomCredentials,0).topSpaceToView(bottomViewInformationWire,WYmargin*2+WYmargin2).widthRatioToView(bottomView,0.3).heightEqualToWidth();
    
    //右面的证件图片
    WyBut * bottomRightCredentialsBut = [[WyBut alloc]init];
    _bottomRightCredentialsBut = bottomRightCredentialsBut;
     [bottomRightCredentialsBut addTarget:self action:@selector(bottomRightCredentialsButClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomRightCredentialsBut setBackgroundImage:[UIImage imageNamed:@"点此上传"] forState:UIControlStateNormal];
    [bottomView addSubview:bottomRightCredentialsBut];
    bottomRightCredentialsBut.sd_layout.leftSpaceToView( bottomLeftCredentialsBut,WYmargin2).topSpaceToView(bottomViewInformationWire,WYmargin*2+WYmargin2).widthRatioToView(bottomView,0.3).heightEqualToWidth();
    
    //手持照片上传的view
    UIView *partitionView = [[UIView alloc]init];
    partitionView.frame = CGRectMake(0, CGRectGetMaxY(bottomView.frame)+WYmargin2+WYmargin, ScreenWidth, ScreenWidth*0.618);
    partitionView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:partitionView];
    
    //银行卡上传
    UILabel *handImage = [[UILabel alloc]init];
    handImage.font = Font16;
    handImage.text = @"手持照片上传";
    handImage.textAlignment = NSTextAlignmentLeft;
    [partitionView addSubview:handImage];
    handImage.sd_layout.leftSpaceToView(partitionView,WYmargin).topEqualToView(partitionView).rightEqualToView(partitionView).heightRatioToView(partitionView,0.25);
    //设置分割线
    UIView *partitionViewInformationWire = [[UIView alloc]init];
    partitionViewInformationWire.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [partitionView addSubview:partitionViewInformationWire];
    partitionViewInformationWire.sd_layout.leftSpaceToView(partitionView,WYmargin).topSpaceToView(handImage,0).rightSpaceToView(partitionView,WYmargin).heightIs(1);
    //证件图片
    UILabel * partitionViewCredentials = [[UILabel alloc]init];
    partitionViewCredentials.font = Font16;
    partitionViewCredentials.text = @"证件图片";
    partitionViewCredentials.textAlignment = NSTextAlignmentLeft;
    [partitionView addSubview:partitionViewCredentials];
    partitionViewCredentials.sd_layout.leftSpaceToView(partitionView,WYmargin).topSpaceToView(partitionViewInformationWire,0).widthRatioToView(partitionView,0.25).heightRatioToView(partitionView,0.25);
    
    //左面的证件图片
    WyBut * partitionViewLeftCredentialsBut = [[WyBut alloc]init];
    _partitionViewLeftCredentials = partitionViewLeftCredentialsBut;
     [partitionViewLeftCredentialsBut addTarget:self action:@selector(partitionViewLeftCredentialsBut:) forControlEvents:UIControlEventTouchUpInside];
    
    [partitionViewLeftCredentialsBut setBackgroundImage:[UIImage imageNamed:@"点此上传"] forState:UIControlStateNormal];
    [partitionView addSubview:partitionViewLeftCredentialsBut];
    partitionViewLeftCredentialsBut.sd_layout.leftSpaceToView(partitionViewCredentials,0).topSpaceToView(partitionViewInformationWire,WYmargin*2+WYmargin2).widthRatioToView(partitionView,0.3).heightEqualToWidth();
    

    
    //顶部的显示文字
    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.font = Font12;
    bottomLabel.numberOfLines = 2;
    bottomLabel.textColor = WYRGb(0, 113, 236);
    
    bottomLabel.frame = CGRectMake(WYmargin, CGRectGetMaxY(partitionView.frame), ScreenWidth- WYmargin*2, 30);
    NSString *head = [self.numId substringToIndex:3];
    NSString *tail =  [self.numId substringFromIndex:self.numId.length - 3];
    bottomLabel.text = [NSString stringWithFormat:@"*请上传xx(%@*****%@)对应的身份证以及银行卡正反面照片",head,tail];
    
    [self.scrollView addSubview:bottomLabel];
    
    WyBut *bottomeBut = [[WyBut alloc]init];
    
    [self.scrollView addSubview:bottomeBut];
    bottomeBut.frame = CGRectMake(WYmargin*2, CGRectGetMaxY(bottomLabel.frame)+WYmargin*2, ScreenWidth-WYmargin*4, 44);
    bottomeBut.titleLabel.font = Font18;
    [bottomeBut setTitle:@"上传" forState:UIControlStateNormal];
    [bottomeBut addTarget:self action:@selector(bottomeButClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomeBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bottomeBut.backgroundColor = WYRGb(0, 113, 236);
    bottomeBut.layer.cornerRadius = 5;
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(bottomeBut.frame)+WYmargin*2+64);
}
#pragma mark --------5张照片点击的方法
//身份证照片左边按钮点击
- (void)leftCredentialsButClick:(WyBut *)but{
    but.tag = 100;
    //弹出头像选择框
    [_actionSheet showInView:[UIApplication sharedApplication].keyWindow];

}
//身份证照片右边按钮点击
- (void)rightCredentialsButClick:(WyBut *)but{
        but.tag = 100;
    //弹出头像选择框
     [_actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}
//银行卡照片左边按钮点击
- (void)bottomLeftCredentialsButClick:(WyBut *)but{
        but.tag = 100;
    //弹出头像选择框
     [_actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}
//银行卡照片右边按钮点击
- (void)bottomRightCredentialsButClick:(WyBut *)but{
        but.tag = 100;
    //弹出头像选择框
      [_actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}
//手持照片按钮点击
- (void)partitionViewLeftCredentialsBut:(WyBut *)but{
        but.tag = 100;
    //弹出头像选择框
      [_actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    WYLog(@"%zd",buttonIndex);
    switch (buttonIndex) {//跳转页面
        case 0:{//拍照
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            //                imagePicker.allowsEditing = YES; //允许照片可以被编辑
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1:{//相册
            //进入相册
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            //                imagePicker.allowsEditing = YES; //允许照片可以被编辑
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 2:{//取消
          [self setupTag];
        }
            
            
            break;
        default:
            break;
    }
}
#pragma mark --------相册的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    WYLog(@"%zd",_leftCredentialsBut.tag);
    //设置返回图片的尺寸
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if ( _leftCredentialsBut.tag == 100) {
        [_leftCredentialsBut setBackgroundImage:image forState:UIControlStateNormal];
        //设置编码
         self.leftCredentialsStr= [self imageBase64WithDataURL:image proportion:1];
    }else if (_rightCredentialsBut.tag == 100){
        [_rightCredentialsBut setBackgroundImage:image forState:UIControlStateNormal];
        self.rightCredentialsStr= [self imageBase64WithDataURL:image proportion:1];
    }else if (_bottomLeftCredentialsBut.tag == 100){
        [_bottomLeftCredentialsBut setBackgroundImage:image forState:UIControlStateNormal];
        self.bottomLeftCredentialsStr= [self imageBase64WithDataURL:image proportion:1];
    }else if (_bottomRightCredentialsBut.tag == 100){
        [_bottomRightCredentialsBut setBackgroundImage:image forState:UIControlStateNormal];
        self.bottomRightCredentialsStr= [self imageBase64WithDataURL:image proportion:1];
    }else if (_partitionViewLeftCredentials.tag == 100){
        [_partitionViewLeftCredentials setBackgroundImage:image forState:UIControlStateNormal];
        self.partitionViewLeftCredentialsStr= [self imageBase64WithDataURL:image proportion:1];
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
    //设置按钮tag
    [self setupTag];
}
- (void)setupTag{
    WYLog(@"为什么调用我啊");
    _leftCredentialsBut.tag = 0;
    _rightCredentialsBut.tag = 1;
    _bottomLeftCredentialsBut.tag = 2;
    _bottomRightCredentialsBut.tag = 3;
    _partitionViewLeftCredentials.tag = 4;
}
#pragma mark--------上传按钮点击
- (void)bottomeButClick{
    
    [self ShowMBProgressHUD];
     NSDictionary * userinfo=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    if (!self.leftCredentialsStr.length) {
        [self ShowComplitedHUDWith:@"请上传身份证正面"];
        return;
    }else if (!self.rightCredentialsStr.length){
    [self ShowComplitedHUDWith:@"请上传身份证反面"];
         return;
    }else if (!self.bottomLeftCredentialsStr.length){
        [self ShowComplitedHUDWith:@"请上传银行卡正面"];
        return;
    }else if (!self.bottomRightCredentialsStr.length){
        [self ShowComplitedHUDWith:@"请上传银行卡反面"];
        return;
    }else if (!self.partitionViewLeftCredentialsStr.length){
        [self ShowComplitedHUDWith:@"请上传手持身份证照"];
        return;
    }
    
    NSDictionary *dict = @{@"userId":userinfo[@"registerid"],@"realName":self.realName,@"numId":self.numId,@"bankCard":self.bankCard,@"phone":self.phone,@"imgIdPositive":self.leftCredentialsStr,@"imgIdOther":self.rightCredentialsStr,@"imgIdHold":self.partitionViewLeftCredentialsStr,@"imgBankPositive":self.bottomLeftCredentialsStr,@"imgBankOther":self.bottomRightCredentialsStr};
    
    [WYHttpTool postHttps:UPLOADAUTHENINFO  param:dict Success:^(NSDictionary *dict, BOOL success) {
        WYLog(@"%@",dict);
        [self HideTheHUD];
        if ([dict[@"code"] isEqualToString:@"0"]) {//请求成功
        }else{
        [self ShowComplitedHUDWith:dict[@"msg"]];
        }
    } fail:^(NSError *error) {
          WYLog(@"%@",error);
        [self HideTheHUD];
        [self ShowComplitedHUDWith:@"网络加载失败..."];
    }];


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
