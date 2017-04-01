//
//  TopUIScrollViewCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/2/22.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "TopUIScrollViewCell.h"
#import "SDCycleScrollView.h"
#import "bannerListModel.h"
@interface TopUIScrollViewCell()<SDCycleScrollViewDelegate>
@property(nonatomic,weak)SDCycleScrollView *SDCycleScrollView;
@end
@implementation TopUIScrollViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"TopUIScrollViewCell";
    
    TopUIScrollViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[TopUIScrollViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
         
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
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [[SDCycleScrollView alloc]init];
    _SDCycleScrollView = cycleScrollView;
    cycleScrollView.delegate = self;
    cycleScrollView.autoScrollTimeInterval = 5;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
//    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:cycleScrollView];
    
    _SDCycleScrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.618);
    [self setupAutoHeightWithBottomView:_SDCycleScrollView bottomMargin:0];
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //发送通知告诉点击了哪个图片
    NSDictionary *dict = @{@"key":@(index)};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"cycleScrollView" object:nil userInfo:dict];
  
}
-(void)setupView:(NSMutableArray *)array{
    

    NSMutableArray *imagesURLStrings = [NSMutableArray array];
    _SDCycleScrollView.imageURLStringsGroup = imagesURLStrings;
    for (int i = 0; i <array.count; i++) {
        bannerListModel *model = array[i];
        [imagesURLStrings addObject:[model.imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    if (imagesURLStrings.count) {

        _SDCycleScrollView.imageURLStringsGroup = imagesURLStrings;
    }
   
    
}
@end
