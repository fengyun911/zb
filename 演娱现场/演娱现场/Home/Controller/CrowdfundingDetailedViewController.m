//
//  CrowdfundingDetailedViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/8.
//  Copyright © 2017年 yyxc. All rights reserved.
// 众筹详情的控制器
#import "LivetTopView.h"
#import "CrowdfundingDetailedViewController.h"
#import "UIImageView+WebCache.h"
#import "PICircularProgressView.h"
@interface CrowdfundingDetailedViewController ()<LivetTopViewDelegate>
{
    LivetTopView *_topNav;
    UIImageView *_topImageView;
    UIView *_ScrollViewBg;
    UILabel *_bottomViewLabel;
    UIView *_bottomView;
}
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)WyBut *wyBut;
@end

@implementation CrowdfundingDetailedViewController
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView*scrollView = [[UIScrollView alloc]init];
         [self.view addSubview:scrollView];
        scrollView.backgroundColor = [UIColor blackColor];
        scrollView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
        scrollView.frame = self.view.bounds;
       
        _scrollView = scrollView;
    }
    return _scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   //设置页面
    [self setupUi];
}
#pragma mark--------设置ui
- (void)setupUi{
    //设置顶部图片
    _topImageView= [[UIImageView alloc]init];
    [self.scrollView addSubview:_topImageView];
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489630436&di=c02373ce2dc67abf99fda1867b46c773&imgtype=jpg&er=1&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F5243fbf2b21193138ff8eeb167380cd791238d73.jpg"] placeholderImage:nil];
    _topImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth *0.618);
    //设置顶部导航栏
    _topNav = [[LivetTopView alloc]init];
    _topNav.bulletScreenBut.hidden = YES;
    _topNav.shareBut.hidden = YES;
    _topNav.textLabel.text = @"众筹详情页面的数据";
    _topNav.delegate = self;
    _topNav.frame = CGRectMake(0, 0, ScreenWidth, 64);
    [_topNav layoutSubviews];
    [self.scrollView addSubview:_topNav];
    
    //创建3个方形按钮
    WyBut *letBut = [self addBut:@"心" tag:0];
    letBut.sd_layout.leftSpaceToView(self.scrollView,WYmargin/4).topSpaceToView(_topImageView,WYmargin/4).widthIs(50.5).heightIs(50.5);

    WyBut *centreBut = [self addBut:@"评论"tag:1];
    centreBut.sd_layout.leftSpaceToView(letBut,WYmargin/4).topEqualToView(letBut).widthIs(50.5).heightIs(50.5);
    
    WyBut *rightBut = [self addBut:@"分享-(1)-1"tag:2];
    rightBut.sd_layout.leftSpaceToView(centreBut,WYmargin/4).topEqualToView(letBut).widthIs(50.5).heightIs(50.5);
    
    //创建投资
    WyBut *wytz = [[WyBut alloc]init];
    [wytz addTarget:self action:@selector(wytzButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:wytz];
    wytz.backgroundColor  = [UIColor colorWithHexString:@"0978d4"];
    wytz.titleLabel.font = Font16;
    [wytz setTitleColor:[UIColor colorWithHexString:@"d8ffff"] forState:UIControlStateNormal];
    [wytz setTitle:@"我要投资" forState:UIControlStateNormal];
    [wytz setImage:[UIImage imageNamed:@"投资"] forState:UIControlStateNormal];
    wytz.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WYmargin);
    // 设置圆角
    wytz.layer.cornerRadius = 5;
    [wytz.layer setMasksToBounds:YES];
    wytz.sd_layout.leftSpaceToView(rightBut,WYmargin/4).topEqualToView(letBut).rightSpaceToView(self.scrollView,WYmargin/4).heightIs(50.5);
    
    //创建中间的view
    UIView *centreView = [[UIView alloc]init];
    centreView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self.scrollView addSubview:centreView];
    centreView.sd_layout.leftEqualToView(letBut).topSpaceToView(letBut,WYmargin/4).rightSpaceToView(self.scrollView,WYmargin/4).heightIs(_topImageView.height);
    // 设置圆角
    centreView.layer.cornerRadius = 5;
    [centreView.layer setMasksToBounds:YES];
    //中间view的标题
    UILabel *centreViewLabel = [[UILabel alloc]init];
    centreViewLabel.textAlignment = NSTextAlignmentCenter;
    centreViewLabel.text = @"发起人:今晚打老虎";
    [centreView addSubview:centreViewLabel];
    centreViewLabel.font = Font16;
    centreViewLabel.backgroundColor =[UIColor colorWithHexString:@"e8e8e8"];
    centreViewLabel.textColor = [UIColor colorWithHexString:@"666666"];
    centreViewLabel.sd_layout.leftSpaceToView(centreView,7.5).topSpaceToView(centreView,WYmargin).widthIs([centreViewLabel getLabelW:Font16 text:centreViewLabel.text]+WYmargin*4).heightIs(30);
    // 设置圆角
    centreViewLabel.layer.cornerRadius = centreViewLabel.height/2;
    [centreViewLabel.layer setMasksToBounds:YES];
    
    //设置按钮
    WyBut *centreViewBut = [[WyBut alloc]init];
    centreViewBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [centreView addSubview:centreViewBut];
    centreViewBut.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WYmargin);
    [centreViewBut setImage:[UIImage imageNamed:@"观看-拷贝-2"] forState:UIControlStateNormal];
    [centreViewBut setTitle:@"9999" forState:UIControlStateNormal];
    [centreViewBut setTitleColor:[UIColor colorWithHexString:@"717171"] forState:UIControlStateNormal];
    centreViewBut.sd_layout.rightSpaceToView(centreView,WYmargin*2).topEqualToView(centreViewLabel).bottomEqualToView(centreViewLabel).widthIs(100);
    
    
    //进度条初始化
    PICircularProgressView *progressView = [[PICircularProgressView alloc] init];
    [centreView addSubview:progressView];
    progressView.sd_layout.leftSpaceToView(centreView,ScreenWidth/5).topSpaceToView(centreView,ScreenWidth/5).widthIs(ScreenWidth/4).heightIs(ScreenWidth/4);
    progressView.textColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:0.0];
    progressView.textLabel.text = [NSString stringWithFormat:@"%@%%",@"50"];
    //        progressView.textLabel.font = Font14;
    progressView.progress = 0.5;
    
    //添加目标金额
    UILabel *mbje = [[UILabel alloc]init];
    [centreView addSubview:mbje];
    mbje.textColor = [UIColor colorWithHexString:@"717171"];
    mbje.font =Font18;
    mbje.text = [NSString stringWithFormat:@"目标金额: %@",@"380万"];
    CGFloat labelW = ScreenWidth/4/3;
    mbje.sd_layout.leftSpaceToView(progressView,WYmargin*2).topSpaceToView(centreView,ScreenWidth/5).widthIs([mbje getLabelW:Font18 text:mbje.text]).heightIs(labelW);
    UILabel *bottoMbje = [[UILabel alloc]init];
    bottoMbje.textColor = [UIColor colorWithHexString:@"717171"];
    bottoMbje.font =Font18;
    bottoMbje.text = @"...............................";
    [centreView addSubview:bottoMbje];
    bottoMbje.sd_layout.leftEqualToView(mbje).topSpaceToView(mbje,-WYmargin).heightIs(WYmargin).widthIs([mbje getLabelW:Font18 text:mbje.text]+WYmargin);
    
    //添加完成率
    UILabel *wcl = [[UILabel alloc]init];
    [centreView addSubview:wcl];
    wcl.textColor = [UIColor colorWithHexString:@"717171"];
    wcl.font =Font18;
    wcl.text = [NSString stringWithFormat:@"完成率: %@",@"67%"];
    wcl.sd_layout.leftSpaceToView(progressView,WYmargin*2).topSpaceToView(mbje,0).widthIs([wcl getLabelW:Font18 text:wcl.text]).heightIs(labelW);
    UILabel *bottoWcl = [[UILabel alloc]init];
    bottoWcl.textColor = [UIColor colorWithHexString:@"717171"];
    bottoWcl.font =Font18;
    bottoWcl.text = @"...............................";
    [centreView addSubview:bottoWcl];
    bottoWcl.sd_layout.leftEqualToView(wcl).topSpaceToView(wcl,-WYmargin).heightIs(WYmargin).widthIs([wcl getLabelW:Font18 text:wcl.text]+WYmargin);
    
    //添加参与人数
    UILabel *cyrs = [[UILabel alloc]init];
    [centreView addSubview:cyrs];
    cyrs.textColor = [UIColor colorWithHexString:@"717171"];
    cyrs.font =Font18;
    cyrs.text = [NSString stringWithFormat:@"参与人数: %@",@"380人"];
    cyrs.sd_layout.leftSpaceToView(progressView,WYmargin*2).topSpaceToView(wcl,0).widthIs([cyrs getLabelW:Font18 text:cyrs.text]).heightIs(labelW);
    UILabel *bottoCyrs = [[UILabel alloc]init];
    bottoCyrs.textColor = [UIColor colorWithHexString:@"717171"];
    bottoCyrs.font =Font18;
    bottoCyrs.text = @"...............................";
    [centreView addSubview:bottoCyrs];
    bottoCyrs.sd_layout.leftEqualToView(cyrs).topSpaceToView(cyrs,-WYmargin).heightIs(WYmargin).widthIs([cyrs getLabelW:Font18 text:cyrs.text]+WYmargin);
    //底部的view
    
    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self.scrollView addSubview:_bottomView];
    _bottomView.sd_layout.leftEqualToView(letBut).topSpaceToView(centreView,WYmargin/4).rightSpaceToView(self.scrollView,WYmargin/4);
    // 设置圆角
    _bottomView.layer.cornerRadius = 5;
    [_bottomView.layer setMasksToBounds:YES];
    CGFloat butW = ScreenWidth/5;
    //创建三个按钮
    for (int i = 0; i <3; i++) {
        WyBut *but = [[WyBut alloc]init];
        but.titleLabel.font = Font16;
        [but setTitleColor:[UIColor colorWithHexString:@"696969"] forState:UIControlStateNormal];
        // 设置圆角
        but.layer.cornerRadius = WYmargin*1.5;
        [but.layer setMasksToBounds:YES];
        but.frame = CGRectMake(7+((butW +7)*i), 14.5, butW, 30);
        [_bottomView addSubview:but];
        but.tag = i;
        if (i == 0) {
            but.selected = YES;
            self.wyBut = but;
            but.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
            [but setTitle:@"项目介绍" forState:UIControlStateNormal];
        }else if (i == 1){
            [but setTitle:@"基本信息" forState:UIControlStateNormal];
        }else if (i == 2){
            [but setTitle:@"团队介绍" forState:UIControlStateNormal];
        }
        [but addTarget:self action:@selector(bottomViewButClick:) forControlEvents:UIControlEventTouchUpInside];
     
    }
    
    _bottomViewLabel = [[UILabel alloc]init];
    [_bottomView addSubview:_bottomViewLabel];
    _bottomViewLabel.font = Font14;
    _bottomViewLabel.textColor = [UIColor colorWithHexString:@"5d5d5d"];
    _bottomViewLabel.text = @"经营文化：健康与养生、产品展示与交流、资源整合与落地。具体讲就是创建“三个平台一个生态平台：某某山庄坐落在交通便利，闹中取静的深圳北站西侧300米处，占地面积200余亩，集的休闲、垂钓、餐饮、水果采摘、蔬菜种植为一体的原生态场所。一个展示平台：会员企业的展示与传播，体验与项目的发布、为会员免费提供培训讲座会展、沙龙聚会。通过定期的活动，成为创业者文化交流前沿阵地。一个社交平台：剩男剩女聚会、小资休闲交际、行业人脉拓展、人才资源整合。比如建立茶艺圈、白领圈、企业家圈、互联网圈，融资圈，财务圈或者英语圈等，如有创业者需要资金，项目，需要找到志同道合的人，需要人脉，能力提升等，我们将为其专门开一个资源整合的交流会，协助其实现创意或项目落地。经营理念： 享受生活，顺便赚钱，合作共赢，兼顾公益。";
#pragma warning 获取最大label的高度
     _bottomViewLabel.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [_bottomViewLabel sizeThatFits:CGSizeMake(_bottomViewLabel.frame.size.width, MAXFLOAT)];
    
    _bottomViewLabel.sd_layout.leftSpaceToView(_bottomView,WYmargin+7).topSpaceToView(_bottomView,30+14.5+WYmargin*2).rightSpaceToView(_bottomView,WYmargin+7).heightIs(size.height).autoHeightRatio(0);
    
      [_bottomView setupAutoHeightWithBottomView:_bottomViewLabel bottomMargin:WYmargin];

    
}
#pragma mark --------代理方法
-(void)LivetTopView:(LivetTopView *)LivetTopView returnButClick:(UIButton *)but{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ------创建3个按钮
- (WyBut *)addBut:(NSString *)imageView tag:(NSInteger)tag{
    WyBut *but = [[WyBut alloc]init];
    but.tag = tag;
    [but addTarget:self action:@selector(topButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:but];
    but.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [but setImage:[UIImage imageNamed:imageView] forState:UIControlStateNormal];
    // 设置圆角
    but.layer.cornerRadius = 5;
    [but.layer setMasksToBounds:YES];
    
    return but;
}
#pragma mark --------顶部左边三个按钮点击
- (void)topButClick:(WyBut*)but{
    
    switch (but.tag) {
        case 0:{
            [self ShowComplitedHUDWith:@"点赞功能开发中"];
        } break;
        case 1:{
            [self ShowComplitedHUDWith:@"发表话题功能开发中"];
        } break;
        case 2:{
            [self ShowComplitedHUDWith:@"分享功能开发中"];
        } break;
        default:
            break;
    }
}
#pragma mark --------我要投资按钮点击
- (void)wytzButClick:(WyBut *)but{
    [self ShowComplitedHUDWith:@"我要投资功能开发中"];
}
#pragma mark --------底部按钮点击的方法
- (void)bottomViewButClick:(WyBut*)but{
    
    self.wyBut.selected = NO;
    if (but.selected == YES) {
        self.wyBut.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    }else{
        self.wyBut.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    }
    
    but.selected = YES;
    self.wyBut = but;
    
    if (but.selected == YES) {
         but.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    }else{
        but.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    }
    
    if (but.tag == 0) {
  _bottomViewLabel.text = @"经营文化：健康与养生、产品展示与交流、资源整合与落地。具体讲就是创建“三个平台一个生态平台：某某山庄坐落在交通便利，闹中取静的深圳北站西侧300米处，占地面积200余亩，集的休闲、垂钓、餐饮、水果采摘、蔬菜种植为一体的原生态场所。一个展示平台：会员企业的展示与传播，体验与项目的发布、为会员免费提供培训讲座会展、沙龙聚会。通过定期的活动，成为创业者文化交流前沿阵地。一个社交平台：剩男剩女聚会、小资休闲交际、行业人脉拓展、人才资源整合。比如建立茶艺圈、白领圈、企业家圈、互联网圈，融资圈，财务圈或者英语圈等，如有创业者需要资金，项目，需要找到志同道合的人，需要人脉，能力提升等，我们将为其专门开一个资源整合的交流会，协助其实现创意或项目落地。经营理念： 享受生活，顺便赚钱，合作共赢，兼顾公益。";
    }else if (but.tag == 1){
    _bottomViewLabel.text = @"众筹股东（除主营业者）放弃对于某某山庄的经营管理、投票等权利。但您可以提供自有的资源参与到建设当中，比如说提供合格的安全食材、设计装修等，也可以提供开分店的信息。总之，权利不大、责任不小，大家服务大家。 2、股东具有知情权、监督权、建议权。股东每两周会收到营业报告，并可提出个人意见作为参考。股东如发现任何人（股东、主营业者、员工）有：收取回扣、贪污等损公肥私行为，应即时告知全部股东，查实事情。如事情属实，则取消涉事人员职位；如是员工，则解除合同；如是股东，则取消股东资格，按原投资额退还本金；如是主营业者，则取消股东资格的同时，送交司法机关处理。同时对涉事人员处以其收取好处金额的10倍罚款。";
    }else if (but.tag == 2){
        _bottomViewLabel.text = @"青橘众筹是最专业的创意众筹平台。在这里你能找到最天才的设计、最聪明的思路、最匪夷所思的产品正在募集资金和支持者。这里是属于中国青年创业者的融资梦想家园。我们为项目发起人提供一站式项目筹资、产品运营发布、意见反馈、投资孵化等服务。自平台上线以来,已与多家企业达成开放平台的合作意向，目前已经上线起点圆梦众筹开放平台。团队成员在网站及移动互联网产品运作方面有着丰富的行业经验,对科技和文化艺术有着炽热的感情。我们希望通过我们的努力,为中国式创新创造历史,让每个人都可以用自己的梦想激励自己的人生,获得成就和人生经验。";
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_bottomView.frame));
}

@end
