//
//  RecommendCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/2.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "RecommendCell.h"
#import "UIButton+WebCache.h"
#import "correlateListModel.h"
@interface RecommendCell()
/**滚动的scrollView*/
@property(nonatomic,weak)UIScrollView *scrollView;
@end
@implementation RecommendCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"RecommendCell";
    
    RecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[RecommendCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    _scrollView = scrollView;
    [self.contentView addSubview:scrollView];
    
}
#pragma mark --------设置view
- (void)setupView:(NSMutableArray *)array{
    if (array.count && self.scrollView.tag !=100) {
        self.scrollView.tag =100;
        CGFloat viewW = (ScreenWidth - WYmargin2*4) /3;
        for (int i = 0; i<array.count; i++) {
            UIView *view = [[UIView alloc]init];
            [self.scrollView addSubview:view];
            //图片
            UIButton *imageBut = [[UIButton alloc]init];
            imageBut.tag = i;
            [imageBut addTarget:self action:@selector(imageButClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:imageBut];
            correlateListModel *model = array[i];
            [imageBut sd_setBackgroundImageWithURL:[NSURL URLWithString:model.imgUrl] forState:UIControlStateNormal
                                  placeholderImage:nil];
            imageBut.frame = CGRectMake(0, WYmargin, viewW, viewW);
            view.frame = CGRectMake(WYmargin/2+ i *(WYmargin+viewW), 0, viewW, CGRectGetMaxY(view.subviews.lastObject.frame));
            
        }
        self.scrollView.sd_layout.heightIs(viewW+WYmargin).topEqualToView(self.contentView).leftEqualToView(self.contentView).widthRatioToView(self.contentView,1);
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.scrollView.subviews.lastObject.frame)+WYmargin/2, 0);
        
        [self setupAutoHeightWithBottomView:self.scrollView bottomMargin:WYmargin];
    }
  
}
#pragma mark --------图片点击
- (void)imageButClick:(UIButton *)but{
    //发送推送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RecommendCellClick" object:nil userInfo:@{@"key":@(but.tag)}];
}

@end
