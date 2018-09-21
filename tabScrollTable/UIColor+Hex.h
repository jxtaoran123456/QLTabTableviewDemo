
#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

+ (UIColor *)colorWithHexString:(NSString *)hexColorString;
+ (UIColor *)colorWithHexString:(NSString *)hexColorString alpha:(float)opacity;

@end
