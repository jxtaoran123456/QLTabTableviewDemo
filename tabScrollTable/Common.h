
#define iPhoneX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

// iPhoneX顶部偏移和底部偏移
#define iPhoneX_Top_Offset     (iPhoneX ? 24 : 0)
#define iPhoneX_Bottom_Offset  (iPhoneX ? 34 : 0)


#define tabBtSelectColor [UIColor colorWithHex:0x0f3f51 alpha:1.0]
#define tabBtUnSelectColor [UIColor colorWithHex:0x2c282b alpha:1.0]
#define titleColor [UIColor orangeColor]
