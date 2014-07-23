//
//  MeBarView.m
//  MyDiary
//
//  Created by zhongwu on 14-7-17.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import "MeBarView.h"
#import "AboutMeViewController.h"
#define buttonTagStart 100

@implementation MeBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setLineOffsetWithPage:(float)page andRatio:(float)ratio
{
    CGRect lineRC  = [self viewWithTag:page + buttonTagStart].frame;
    
    CGRect lineRC2  = [self viewWithTag:page + 1 + buttonTagStart].frame;
    
    NSLog(@"%f",page + buttonTagStart);
    
    float width = lineRC2.size.width;
    if (lineRC2.size.width < lineRC.size.width)
    {
        width =  lineRC.size.width - (lineRC.size.width-lineRC2.size.width)*ratio;
        
    }
    else if(lineRC2.size.width > lineRC.size.width)
    {
        width =  lineRC.size.width + (lineRC2.size.width-lineRC.size.width)*ratio;
    }
    float x = lineRC.origin.x + (lineRC2.origin.x - lineRC.origin.x)*ratio;
    
    
    self.lineView.frame = CGRectMake(x,  self.frame.size.height - 2,width,   2);
}

- (id)initWithFrame:(CGRect)frame andItems:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedIndex = 0;
        int width = 0;
        self.buttonArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < titleArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor clearColor];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            NSString *title = [titleArray objectAtIndex:i];
            [button setTitle:title forState:UIControlStateNormal];
            button.tag = buttonTagStart + i;
            CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 25) lineBreakMode:NSLineBreakByWordWrapping];
            
        //    button.frame = CGRectMake(width, 0, size.width, 25);
            button.frame = CGRectMake(width, 0, 320/3, 25);
            [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [self.buttonArray addObject:button];
          //  width += size.width + 20;
            width += 320/3 +20;
        }
      //  self.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
        self.contentSize = CGSizeMake(width, 25);
        self.showsHorizontalScrollIndicator = NO;
    
        CGRect rc = [self viewWithTag:self.selectedIndex + buttonTagStart].frame;
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(rc.origin.x, self.frame.size.height - 2, rc.size.width, 2)];
        self.lineView.backgroundColor = RGBCOLOR(190, 2, 1);
        [self addSubview:self.lineView];
    }
    return self;
}

-(void)onClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (self.selectedIndex != btn.tag - buttonTagStart) {
        [self selectIndex:(int)(btn.tag - buttonTagStart)];
    }
}

-(void)selectIndex:(int)index
{
    if (self.selectedIndex != index) {
        self.selectedIndex = index;
        
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:0.2];
        CGRect lineRc = [self viewWithTag:self.selectedIndex + buttonTagStart].frame;
        self.lineView.frame = CGRectMake(lineRc.origin.x, self.frame.size.height - 2, lineRc.size.width, 2);
        [UIView commitAnimations];
        
        if (self.clickDelegate != nil && [self.clickDelegate respondsToSelector:@selector(barSelectedIndexChanged:)]) {
            [self.clickDelegate barSelectedIndexChanged:self.selectedIndex];
        }
        
        if (lineRc.origin.x - self.contentOffset.x > 320 * 2  / 3)
        {
            int index = self.selectedIndex;
            if (self.selectedIndex + 2 < self.buttonArray.count)
            {
                index = self.selectedIndex + 2;
            }
            else if (self.selectedIndex + 1 < self.buttonArray.count)
            {
                index = self.selectedIndex + 1;
            }
            CGRect rc = [self viewWithTag:index +buttonTagStart].frame;
            [self scrollRectToVisible:rc animated:YES];
        }
        else if ( lineRc.origin.x - self.contentOffset.x < 320 / 3)
        {
            int index = self.selectedIndex;
            if (self.selectedIndex - 2 >= 0)
            {
                index = self.selectedIndex - 2;
            }
            else if (self.selectedIndex - 1 >= 0)
            {
                index = self.selectedIndex - 1;
            }
            CGRect rc = [self viewWithTag:index +buttonTagStart].frame;
            [self scrollRectToVisible:rc animated:YES];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
