#import <UIKit/UIKit.h>

@interface UIImage (Extendtion)
+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**保持高宽比设置图片在多大区域显示*/
- (UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
/**指定宽度按比例缩放*/
- (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
/**修改按钮image的大小*/
- (UIImage*)scaleToSize:(CGSize)size;
@end
