//
//  Main.m
//  HowToLaunchApp
//
//  Created by Jay on 16/5/13.
//
//

#import "Main.h"
#import "OpenApp.h"
#import "GetAllApps.h"

@implementation Main

static void useNewSetting(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    
    OpenApp *openAAA = [OpenApp shareInstance];
    
    [openAAA useChangeSetting];
}

static void blockOrNot(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    
    OpenApp *openAAA = [OpenApp shareInstance];
    
    [openAAA blockOrNot];
}

__attribute__((constructor)) void dylibMain()
{
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, useNewSetting, CFSTR("com.wonderland.changeset"), NULL,         CFNotificationSuspensionBehaviorCoalesce);
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, blockOrNot, CFSTR("com.wonderland.blockornot"), NULL,         CFNotificationSuspensionBehaviorCoalesce);
    
    
    NSLog(@"gitHug 测试");

}//主入口

@end
