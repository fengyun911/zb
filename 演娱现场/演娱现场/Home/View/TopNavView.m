//
//  TopNavView.m
//  演娱现场
//
//  Created by 汪洋 on 2017/2/22.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "TopNavView.h"
@implementation TopNavView 
{
    WyBut *_topLeftBut;
    WyBut *_toprightBut;
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
    _topLeftBut = [[WyBut alloc]init];
        [_topLeftBut setImage:[UIImage imageNamed:@"菜单-(1)"] forState:UIControlStateNormal];
    //添加按钮监听方法
    [_topLeftBut addTarget:self action:@selector(topLeftButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_topLeftBut];
    //设置中间的搜索框
    _searchBar  = [WYSearchBar SearchBar];
    _searchBar.returnKeyType= UIReturnKeySearch;
    _searchBar.layer.borderWidth = 1;
    _searchBar.layer.borderColor = [[UIColor colorWithHexString:@"FFFFFF"] CGColor];
    _searchBar.layer.cornerRadius = 3;
    [self addSubview:_searchBar];
    //设置右边的按钮
        _toprightBut = [[WyBut alloc]init];
        [_toprightBut setTitle:@"北京" forState:UIControlStateNormal];
        //添加按钮监听方法
        [_toprightBut addTarget:self action:@selector(topRightButClick:) forControlEvents:UIControlEventTouchUpInside];
        [_toprightBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _toprightBut.titleLabel.font = CFont16;
        [self addSubview:_toprightBut];
        
    }
    
    
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //设置自动布局
    //设置蒙版
    _cover.frame = self.frame;
    //左边按钮的位置
    _topLeftBut.sd_layout.leftSpaceToView(self,WYmargin).widthIs(40).heightIs(40).topSpaceToView(self,WYmargin*2);
    //设置右边的位置
    _toprightBut.sd_layout.rightSpaceToView(self,WYmargin).widthIs(40).heightRatioToView(_topLeftBut,1).topSpaceToView(self,WYmargin*2);
    //中间搜索栏的位置
    _searchBar.sd_layout.leftSpaceToView(_topLeftBut,WYmargin).rightSpaceToView(_toprightBut,WYmargin).heightRatioToView(_toprightBut,1).topSpaceToView(self,WYmargin*2);
}
#pragma mark --------左边顶部按钮点击
- (void)topLeftButClick:(UIButton *)but{
    
    if ([self.delegate respondsToSelector:@selector(TopNavView:didLeftButClick:)]) {
        [self.delegate TopNavView:self didLeftButClick:but];
    }

}
#pragma mark --------右边顶部按钮点击
- (void)topRightButClick:(UIButton *)but{
    
    if ([self.delegate respondsToSelector:@selector(TopNavView:didLeftButClick:)]) {
        [self.delegate TopNavView:self didRightButClick:but];
    }
    
}
- (void)setupLeftBut:(NSString *)butStr{
    [_topLeftBut setImage:[UIImage imageNamed:butStr] forState:UIControlStateNormal];
}
@end
