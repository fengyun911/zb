

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString*)hihaImage{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:hihaImage] forState:UIControlStateHighlighted];
    
    button.size = button.currentBackgroundImage.size;
    
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    return bar;
    

}

@end
