//
//  userModel.h
//  创美
//
//  Created by 汪洋 on 16/6/4.
//  Copyright © 2016年 chuangmei. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface userModel : NSObject
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *loginAccount;
/**真是姓名*/
@property(nonatomic,strong)NSString *realName;
/**风险偏好*/
//riskLevel 分为，1,2,3级，分别对应 低，中，高
@property(nonatomic,strong)NSString *riskLevel;
/**个人介绍*/
@property(nonatomic,strong)NSString *brief;
/**可用资金*/
@property(nonatomic,strong)NSString *totalAssets;
@end
