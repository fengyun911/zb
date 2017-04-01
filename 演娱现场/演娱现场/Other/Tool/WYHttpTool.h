#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface WYHttpTool : NSObject
#define kTimeOutInterval 10 // 请求超时的时间
typedef void (^SuccessBlock)(NSDictionary *dict, BOOL success); // 访问成功block
typedef void (^AFNErrorBlock)(NSError *error); // 访问失败block
+(AFHTTPSessionManager *)manager;
+ (void)getHttps:(NSString *)url param:(NSDictionary *)param  Success:(SuccessBlock)success fail:(AFNErrorBlock)fail;
/**post网络请求*/
+ (void)postHttps:(NSString *)url param:(NSDictionary *)param  Success:(SuccessBlock)success fail:(AFNErrorBlock)fail;
@end
