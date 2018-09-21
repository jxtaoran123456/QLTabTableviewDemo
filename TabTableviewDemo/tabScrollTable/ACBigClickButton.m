//
//  ACBigClickButton.m
//  MyComic
//
//  Created by clareychen on 16/03/11.
//  Copyright (c) 2016年 ellentao. All rights reserved.
//

#import "ACBigClickButton.h"
#import "UIColor+Hex.h"

#define defaultExpandMargins 10.f

@implementation ACBigClickButton


-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)])
    {

    }
    return self;
    
}


-(void)setExpandMargins:(float)expandMargins
{
    _expandMargins = expandMargins;

}


-(void)showRangeView:(BOOL)show
{
    if(show == YES)
    {
        if(self.rangeView == nil)
        {
            CGFloat expandS = 0.f;
            self.rangeView = [[UIView alloc]initWithFrame:CGRectMake(-1*expandS, -1*expandS, self.frame.size.width, self.frame.size.height)];
            if(self.expandMarginsWidth > 0.f)
            {
                self.rangeView.frame = CGRectMake(-1*self.expandMarginsWidth, -1*self.expandMarginsHeight, self.frame.size.width+2*self.expandMarginsWidth, self.frame.size.height+2*self.expandMarginsHeight);
            }
            else
            {
                if(self.expandMargins > 0.f)
                {
                    expandS = self.expandMargins;
                }
                else
                {
                    expandS = defaultExpandMargins;
                }
                self.rangeView.frame = CGRectMake(-1*expandS, -1*expandS, self.frame.size.width+2*expandS, self.frame.size.height+2*expandS);
            }
            self.rangeView.userInteractionEnabled = NO;
            [self addSubview:self.rangeView];
        }
        self.rangeView.backgroundColor = [UIColor redColor];
        self.rangeView.alpha = 0.3f;
    }
    else
    {
        [self.rangeView removeFromSuperview];
        self.rangeView = nil;
        self.oriBackGroundColor = self.backgroundColor;
        self.backgroundColor = self.oriBackGroundColor;
    }
    
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if(self.expandMarginsWidth > 0.f)
    {
        CGRect bounds = self.bounds;
        bounds = CGRectInset(bounds, -1.f*self.expandMarginsWidth, -1.f*self.expandMarginsHeight);	//注意这里是负数，扩大了之前的bounds的范围
        return CGRectContainsPoint(bounds, point);
    }
    else
    {
        CGFloat expandS = 0.f;
        if(self.expandMargins > 0.f)
        {
            expandS = self.expandMargins;
        }
        else
        {
            expandS = defaultExpandMargins;
        }
        
        CGRect bounds = self.bounds;
        bounds = CGRectInset(bounds, -1.f*expandS, -1.f*expandS);	//注意这里是负数，扩大了之前的bounds的范围
        return CGRectContainsPoint(bounds, point);
    }
    
}



@end
