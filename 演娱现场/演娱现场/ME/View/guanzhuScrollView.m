//
//  guanzhuScrollView.m
//  创美
//
//  Created by 汪洋 on 16/5/8.
//  Copyright © 2016年 chuangmei. All rights reserved.
//

#import "guanzhuScrollView.h"
@interface guanzhuScrollView()<UIGestureRecognizerDelegate>
@end
@implementation guanzhuScrollView
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer.state != 0) {
        return YES;
    } else {
        return NO;
    }
}

@end
