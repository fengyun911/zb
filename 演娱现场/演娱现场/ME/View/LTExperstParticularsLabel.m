//
//  LTExperstParticularsLabel.m
//  folk
//
//  Created by 汪洋 on 15/9/17.
//  Copyright (c) 2015年 luoteng. All rights reserved.
//

#import "LTExperstParticularsLabel.h"
@interface LTExperstParticularsLabel()
@property(nonatomic,weak)UIView *bread;
@end
@implementation LTExperstParticularsLabel
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
//        self.font = [UIFont systemFontOfSize:19];
        self.userInteractionEnabled = YES;
        self.scale = 0.0;
    }
    return self;
}

//- (void)setScale:(CGFloat)scale{
//    _scale = scale;
//    //颜色渐变
//    self.textColor = WYRGb(scale *200+231, scale *200+161, scale *200+157);
//    
//    //大小渐变
//    CGFloat minWhScale = 0.85;
//    CGFloat whScale =  minWhScale +scale * (1 -minWhScale);
//    self.transform = CGAffineTransformMakeScale(whScale, whScale);
//    
//}
@end
