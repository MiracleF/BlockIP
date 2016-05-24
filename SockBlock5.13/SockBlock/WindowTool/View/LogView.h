//
//  LogView.h
//  PiQu
//
//  Created by kaix on 15-3-16.
//  Copyright (c) 2015年 Jagie. All rights reserved.
//

#import <UIKit/UIKit.h>
#define logView(string,...) [[LogView instance]log:string, ##__VA_ARGS__]

@interface LogView : UIView

@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,assign)CGFloat currentFontSize;
+(LogView*)instance;
- (void)log:(NSString *)format, ...;
-(void)clear;
@end
