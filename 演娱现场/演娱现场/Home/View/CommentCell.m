//
//  CommentCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/2/24.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
@interface CommentCell()
/**评论的label*/
@property(nonatomic,weak)UILabel *commnetLabel;
@property(nonatomic,weak)UIImageView *topImageView;
@end
@implementation CommentCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"CommentCell";
    
    CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[CommentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    //个人评论view
    UILabel *commnetLabel = [[UILabel alloc]init];
    _commnetLabel = commnetLabel;
    commnetLabel.font = CFont16;
    commnetLabel.text = @"个人评论";
    commnetLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:commnetLabel];
    commnetLabel.sd_layout.leftSpaceToView(self.contentView,WYmargin).topEqualToView(self.contentView).widthRatioToView(self.contentView,1).heightIs(42);
    [self.contentView addSubview:commnetLabel];
    //顶部的图片
    UIImageView *topImageView = [[UIImageView alloc]init];
    _topImageView = topImageView;
    [self.contentView addSubview:topImageView];
    topImageView.sd_layout.topSpaceToView(commnetLabel,0).leftEqualToView(self.contentView).rightEqualToView(self.contentView).heightIs(ScreenWidth *0.618);
  }
#pragma mark --------设置view
- (void)setupView{
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1490930803&di=e2f0ffb16d9913bf032165e1e9568be9&src=http://img4.duitang.com/uploads/blog/201403/09/20140309132941_XHM4N.thumb.600_0.jpeg"] placeholderImage:nil];

}

@end
