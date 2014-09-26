//
//  DiaryListTableViewCell.m
//  MyDiary
//
//  Created by zhongwu on 14-7-7.
//  Copyright (c) 2014年 刘铭. All rights reserved.
//

#import "DiaryListTableViewCell.h"
static CGFloat const kBounceValue = 20.0f;
@interface DiaryListTableViewCell ()
<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic) CGPoint panStartPoint;
@property (nonatomic) CGFloat startingRightLayoutContraintConstant;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewRightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewLeftContraint;

@end
@implementation DiaryListTableViewCell

//- (void)setName:(NSString *)name
//{
//    if (![name isEqualToString:_name]) {
//        _name = [name copy];
//        _nameValue.text = _name;
//    }
//}
//
//- (void)setColor:(NSString *)color
//{
//    if (![color isEqualToString:_color]) {
//        _color = [color copy];
//        _colorValue.text = _color;
//    }
//}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThisCell:)];
    self.panRecognizer.delegate = self;
    [self.myContentView addGestureRecognizer:self.panRecognizer];
}

- (CGFloat)buttonTotalWidth
{
//    NSLog(@"self.frame is %f,self.button2.frame is %f",CGRectGetWidth(self.frame),CGRectGetMinX(self.button2.frame));
   // return 92.0f;
    return CGRectGetWidth(self.frame) - CGRectGetMinX(self.button2.frame);
}

- (void)resetConstraintContstantsToZero:(BOOL)animated notifyDelegateDidClose:(BOOL)endEditing
{
    if (self.startingRightLayoutContraintConstant == 0 && self.contentViewRightContraint.constant == 0) {
        return;
    }
    
    self.contentViewRightContraint.constant = -kBounceValue;
    self.contentViewLeftContraint.constant = kBounceValue;
    
    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished){
        self.contentViewRightContraint.constant = 0;
        self.contentViewLeftContraint.constant = 0;
        
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished){
            self.startingRightLayoutContraintConstant = self.contentViewRightContraint.constant;
        }];
    }];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self resetConstraintContstantsToZero:NO notifyDelegateDidClose:NO];
}

- (void)setContraintsToShowAllButtons:(BOOL)animated notifyDelegateDidOpen:(BOOL)notifyDelegate
{
    if (self.startingRightLayoutContraintConstant == [self buttonTotalWidth] && self.contentViewRightContraint.constant == [self buttonTotalWidth]) {
        return;
    }
    
    self.contentViewLeftContraint.constant = -[self buttonTotalWidth] - kBounceValue;
    self.contentViewRightContraint.constant = [self buttonTotalWidth] + kBounceValue;
    
    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished){
        self.contentViewLeftContraint.constant = -[self buttonTotalWidth];
        self.contentViewRightContraint.constant = [self buttonTotalWidth];
        
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished){
            self.startingRightLayoutContraintConstant = self.contentViewRightContraint.constant;
        }];
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)panThisCell:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.panStartPoint = [recognizer translationInView:self.myContentView];
          //  NSLog(@"start point is %f",self.panStartPoint.x);
            self.startingRightLayoutContraintConstant = self.contentViewRightContraint.constant;
            NSLog(@"pan began at %@",NSStringFromCGPoint(self.panStartPoint));
            break;
        case UIGestureRecognizerStateChanged:{
            CGPoint currentPoint = [recognizer translationInView:self.myContentView];
            NSLog(@"start point is %f",currentPoint.x);
            CGFloat deltaX = currentPoint.x - self.panStartPoint.x;
            BOOL panningLeft = NO;
            if (currentPoint.x < self.panStartPoint.x) {
                panningLeft = YES;
            }
            if (self.startingRightLayoutContraintConstant == 0) {
                if (!panningLeft) {
//                    CGFloat constant = MAX(-deltaX, 0);
//                    if (constant == 0) {
//                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO];
//                    }
//                    else
//                    {
//                        self.contentViewRightContraint.constant = constant;
//                    }
                }else
                {
                    CGFloat constant = MIN(-deltaX, [self buttonTotalWidth]);
                    if (constant == [self buttonTotalWidth]) {
                        [self setContraintsToShowAllButtons:YES notifyDelegateDidOpen:NO];
                    }
                    else
                    {
                        self.contentViewRightContraint.constant = constant;//让mycontentview滑动
                    }
                }
            }
            else
            {
                CGFloat adjustment = self.startingRightLayoutContraintConstant - deltaX;
                if (!panningLeft) {
                    CGFloat constant = MAX(adjustment, 0);
                    if (constant == 0) {
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO];
                    }
                    else
                    {
                        self.contentViewRightContraint.constant = constant;
                    }
                }
                else
                {
//                    CGFloat constant = MIN(adjustment, [self buttonTotalWidth]);
//                    if (constant == [self buttonTotalWidth]) {
//                        [self setContraintsToShowAllButtons:YES notifyDelegateDidOpen:NO];
//                    }
//                    else
//                    {
//                        self.contentViewRightContraint.constant = constant;
//                    }
                }
            }
            self.contentViewLeftContraint.constant = -self.contentViewRightContraint.constant;  //mycontentview左边也做相应的滑动
            NSLog(@"pan moved %f",deltaX);
        }
            break;
        case UIGestureRecognizerStateEnded:
            if (self.startingRightLayoutContraintConstant == 0) { //1
                //Cell was opening
                CGFloat halfOfButtonOne = CGRectGetWidth(self.button1.frame) / 2; //2
                if (self.contentViewRightContraint.constant >= halfOfButtonOne) { //3
                    //Open all the way
                    [self setContraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                } else {
                    //Re-close
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                }
            } else {
                //Cell was closing
                CGFloat buttonOnePlusHalfOfButton2 = CGRectGetWidth(self.button1.frame) + (CGRectGetWidth(self.button2.frame) / 2); //4
                if (self.contentViewRightContraint.constant >= buttonOnePlusHalfOfButton2) { //5
                    //Re-open all the way
                    [self setContraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                } else {
                    //Close
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                }
            }
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"pan cancelled");
            if (self.startingRightLayoutContraintConstant == 0) {
                [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
            }
            else
            {
                [self setContraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
            }
            break;
        default:
            break;
    }
}

- (void)updateConstraintsIfNeeded:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    float duration = 0;
    if (animated) {
        duration = 0.1;
    }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    }completion:completion];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonClicked:(UIButton *)sender {
    if (sender == self.button1) {
        NSLog(@"clicked button 1");
        [self.delegate buttonOneActionForItemText:@"1"];
    }else if (sender == self.button2){
        NSLog(@"clicked button 2");
        [self.delegate buttonTwoActionForItemText:@"2"];
    }else{
        NSLog(@"clicked unkown button");
    }
}
@end
