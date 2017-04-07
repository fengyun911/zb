//
//  NewsCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/2/24.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "NewsCell.h"
#import "UIButton+WebCache.h"
#import "liveListModel.h"
@interface NewsCell()

/**滚动的scrollView*/
@property(nonatomic,weak)UIScrollView *scrollView;
/**资讯的label*/
@property(nonatomic,weak)UILabel *newsLabel;
//记录是否创建的view
@property(nonatomic,weak)UIView *bgView;
@end
@implementation NewsCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"NewsCell";
    
    NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[NewsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = HOMECELLBG;
    }
    
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置cell
        [self setupCell];
    }
    
    return  self;
}
- (void)setupCell{
    //资讯的view
    UILabel *newsLabel = [[UILabel alloc]init];
    _newsLabel = newsLabel;
    newsLabel.font = CFont16;
    newsLabel.text = @"直播资讯";
    newsLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:newsLabel];
    newsLabel.sd_layout.leftSpaceToView(self.contentView,WYmargin).topEqualToView(self.contentView).widthRatioToView(self.contentView,1).heightIs(42);
    [self.contentView addSubview:newsLabel];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    //隐藏指示条
    scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView = scrollView;
    [self.contentView addSubview:scrollView];

}
#pragma mark --------设置view
- (void)setupView:(NSMutableArray *)array{
    if (_bgView == nil &&array.count) {
        CGFloat viewW = (ScreenWidth - WYmargin2*4) /3;
        for (int i = 0; i<array.count; i++) {
            UIView *view = [[UIView alloc]init];
            _bgView =view;
            [self.scrollView addSubview:view];
            //图片
            UIButton *imageBut = [[UIButton alloc]init];
            imageBut.tag = i;
            [imageBut addTarget:self action:@selector(imageButClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:imageBut];
            liveListModel *model = array[i];
            [imageBut sd_setBackgroundImageWithURL:[NSURL URLWithString:model.imgUrl] forState:UIControlStateNormal
                                  placeholderImage:nil];
            imageBut.frame = CGRectMake(0, 0, viewW, viewW);
            //标题
            UILabel *nameLabel = [[UILabel alloc]init];
            [view addSubview:nameLabel];
            nameLabel.text = model.title;
            nameLabel.font = CFont16;
            nameLabel.textColor = [UIColor whiteColor];
            nameLabel.sd_layout.leftSpaceToView(view,WYmargin2).topSpaceToView(imageBut,0).rightSpaceToView(view,WYmargin2).heightIs(20);
            //观看数
            WyBut *quantityBut = [[WyBut alloc]init];
            [view addSubview:quantityBut];
            [quantityBut setTitle:model.followSize forState:UIControlStateNormal];
            [quantityBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [quantityBut setImage:[UIImage imageNamed:@"观看-拷贝-2"] forState:UIControlStateNormal];
            quantityBut.titleEdgeInsets = UIEdgeInsetsMake(0, WYmargin2, 0, 0);
            quantityBut.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WYmargin2);
            quantityBut.titleLabel.font = Font14;
            quantityBut.sd_layout.leftEqualToView(nameLabel).rightEqualToView(nameLabel).heightIs(14).topSpaceToView(nameLabel,0);
            
            view.frame = CGRectMake(WYmargin+ i *(WYmargin+viewW), 0, viewW, viewW);
            
        }
        self.scrollView.sd_layout.topSpaceToView(_newsLabel,0).leftEqualToView(self.contentView).widthRatioToView(self.contentView,1).heightIs(42+viewW);
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.scrollView.subviews.lastObject.frame)+WYmargin, 0);
        
        [self setupAutoHeightWithBottomView:self.scrollView bottomMargin:WYmargin];
    }
  
}
#pragma mark --------图片按钮点击
- (void)imageButClick:(UIButton *)but
{
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"NewsCell" object:nil userInfo:@{@"tag":@(but.tag)}];
}
@end
