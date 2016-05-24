//
//  OpenApp.h
//  KillAndLaunch
//
//  Created by Jay on 16/5/13.
//  Copyright © 2016年 wonderland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenApp : NSObject

+ (OpenApp *)shareInstance;

//- (void)openOtherAppWithName:(NSString *)name;

- (void)blockOrNot;  //是否自动屏蔽

- (void)useChangeSetting; //使用新设置

@end
