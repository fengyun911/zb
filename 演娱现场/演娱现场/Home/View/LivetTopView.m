//
//  LivetTopView.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/2.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "LivetTopView.h"

@implementation LivetTopView
{

    UIView *_cover;
}
-(id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        //设置遮盖
        UIView *cover = [[UIView alloc]init];
        _cover = cover;
        _cover.backgroundColor = [UIColor blackColor];
        _cover.alpha = 0.3;
        [self addSubview:cover];
        //设置左面的按钮
       WyBut *returnBut = [[WyBut alloc]init];
        _returnBut = returnBut;
        [_returnBut setImage:[UIImage imageNamed:@"返回-(1)"] forState:UIControlStateNormal];
        //添加按钮监听方法
        [_returnBut addTarget:self action:@selector(returnButClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_returnBut];
        //设置中间label
        UILabel *textLabel = [[UILabel alloc]init];
        _textLabel = textLabel;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = Font16;
        textLabel.textColor = LIVETTOPLABEL;
        [self addSubview:textLabel];
        //设置右边的弹幕
        WyBut * bulletScreenBut = [[WyBut alloc]init];
        _bulletScreenBut = bulletScreenBut;
        [_bulletScreenBut setImage:[UIImage imageNamed:@"直播滑动"] forState:UIControlStateNormal];
        //添加按钮监听方法
        [_bulletScreenBut addTarget:self action:@selector(bulletScreenButClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_bulletScreenBut];
        
        //分享按钮
        WyBut *shareBut = [[WyBut alloc]init];
        _shareBut = shareBut;
        [_shareBut setImage:[UIImage imageNamed:@"分享-(1)"] forState:UIControlStateNormal];
        //添加按钮监听方法
        [_shareBut addTarget:self action:@selector(shareButClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shareBut];
        
    }
    
    
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //设置蒙版
    _cover.frame = self.frame;
    //左边按钮的位置
    self.returnBut.sd_layout.leftSpaceToView(self,WYmargin).widthIs(40).heightIs(40).topSpaceToView(self,WYmargin*2);
    //设置分享
    self.shareBut.sd_layout.rightSpaceToView(self,WYmargin).widthIs(40).heightRatioToView(_returnBut,1).topSpaceToView(self,WYmargin*2);
    //设置弹幕
    self.bulletScreenBut.sd_layout.rightSpaceToView(_shareBut,WYmargin).widthIs(40).heightRatioToView(_shareBut,1).topSpaceToView(self,WYmargin*2);
    
    //中间label的位置
    _textLabel.sd_layout.heightRatioToView(_bulletScreenBut,1).topSpaceToView(self,WYmargin*2).centerXEqualToView(self).widthIs(ScreenWidth - 200);
}
#pragma mark --------返回按钮点击
- (void)returnButClick:(UIButton *)but{
    
    if ([self.delegate respondsToSelector:@selector(LivetTopView:returnButClick:)]) {
        [self.delegate LivetTopView:self returnButClick:but];
    }
    
}
#pragma mark --------弹幕按钮点击
- (void)bulletScreenButClick:(UIButton *)but{
    
    if ([self.delegate respondsToSelector:@selector(LivetTopView:bulletScreenButClick:)]) {
        [self.delegate LivetTopView:self bulletScreenButClick:but];
    }
    
}
#pragma mark --------分享按钮点击
- (void)shareButClick:(UIButton *)but{
    
    if ([self.delegate respondsToSelector:@selector(LivetTopView:shareButClick:)]) {
        [self.delegate LivetTopView:self shareButClick:but];
    }
    
}


@end
