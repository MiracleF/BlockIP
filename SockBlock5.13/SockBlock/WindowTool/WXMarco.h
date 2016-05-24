//
//  WXMarco.h
//  cocTweak2
//
//  Created by kaix on 15/7/15.
//
//




#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "LogView.h"
#import "UIButton+NMCategory.h"
#endif






#ifndef cocTweak2_WXMarco_h
#define cocTweak2_WXMarco_h

#define Char_To_NSString(s) [NSString stringWithCString:s encoding:NSUTF8StringEncoding]

#define NSString_To_Char(s) [s UTF8String]

//
//#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
//
//#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)



#define SCREEN_Scale [UIScreen mainScreen].scale

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width ) //* SCREEN_Scale

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height) // * SCREEN_Scale

#define kSCREEN_WIDTH [GameInfo instance].screen_width
#define kSCREEN_HEIGHT [GameInfo instance].screen_height

#define kSCREEN_WIDTH_Scale kSCREEN_WIDTH * SCREEN_Scale
#define kSCREEN_HEIGHT_Scale kSCREEN_HEIGHT * SCREEN_Scale

#define StringFormat(string,...) [NSString stringWithFormat:string, ##__VA_ARGS__]


#define logView(string,...) [[LogView instance]log:string, ##__VA_ARGS__]


#define Char_To_NSString(s) [NSString stringWithCString:s encoding:NSUTF8StringEncoding]

#define NSString_To_Char(s) [s UTF8String]

#define IsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IOS_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define IOS_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IOS_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IOS_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


static NSString * const Png_Path =      @"//png/" ;
static NSString * const sChat_Bg =      @"Chat_Bg@2x.png" ;
static NSString * const sCommon_Bg =    @"Common_Bg@2x.png" ;
static NSString * const sNav =          @"Nav@2x.png" ;
static NSString * const sSection_Bg =   @"Section_Bg@2x.png" ;

static NSString * const sTabber =       @"Tabber@2x.png" ;
static NSString * const sTabber_1 =     @"Tabber_1@2x.png" ;
static NSString * const sTabber_2 =     @"Tabber_2@2x.png" ;
static NSString * const sTabber_3 =     @"Tabber_3@2x.png" ;
static NSString * const sTabber_4 =     @"Tabber_4@2x.png" ;


static NSString * const kIpSelectDic = @"ipSelectDic";
static NSString * const kUnSelect = @"unSelect";
static NSString * const kSelect = @"select";



//[UIImage imageWithContentsOfFile:@"//png/nav.png"]
//[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@",Png_Path]]



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



#define kNav_Image [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",Png_Path,sNav]]


#define kControllor_Image [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",Png_Path,sCommon_Bg]] 

#define kTabBar_Image [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",Png_Path,sTabber]]

#define kSection_Bg [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",Png_Path,sSection_Bg]]

#define kTabBar_Icon1 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",Png_Path,sTabber_1]]

#define kTabBar_Icon2 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",Png_Path,sTabber_2]]  

#define kTabBar_Icon3 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",Png_Path,sTabber_3]]

#define kTabBar_Icon4 [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",Png_Path,sTabber_4]]

#define lBlue_Down_Image [Blue_Down_Image resizableImageWithCapInsets:UIEdgeInsetsMake(10,10,10,10) resizingMode:UIImageResizingModeStretch]

#define kCell_Select_Color [UIColor greenColor]

#define kCell_Text_color [UIColor blackColor]

#define kClearColor [UIColor clearColor]

#define kOrangeColor  [UIColor orangeColor]
#define kPinkColor UIColorFromRGB(0xffc5d3)
#endif
