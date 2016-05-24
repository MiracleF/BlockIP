//
//  UIView+ExFrame.h
//  cocTweak2
//
//  Created by kaix on 15/7/15.
//
//

#import <UIKit/UIKit.h>

@interface UIView (ExFrame)


@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;
-(CGPoint) CGRectGetCenter:(CGRect )rect;
-(CGRect)CGRectMoveToCenter:(CGRect )rect center:( CGPoint) center;

@end
