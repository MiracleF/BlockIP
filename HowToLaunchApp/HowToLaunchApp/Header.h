//
//  Header.h
//  AppControl
//
//  Created by Jay on 16/5/17.
//  Copyright © 2016年 wonderland. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define MMIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

static NSString *const kShouldKillApp = @"shouldKillApp";
static NSString *const kRebootAppTime = @"rebootAppTime";
static NSString *const kKillTime = @"killTime";
static NSString *const kShouldBlockIP = @"shouldBlockIP";
static NSString *const kShouldTap = @"shouldTap";
static NSString *const kExecutableName = @"ExecutableName";
static NSString *const kBID = @"BID";
static NSString *const kImagePath = @"imagePath";
static NSString *const kDisplayName = @"DisplayName";
static NSString *const kSafeMode = @"safeMode";

#endif /* Header_h */
