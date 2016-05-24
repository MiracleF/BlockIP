//
//  OpenApp.m
//  KillAndLaunch
//
//  Created by Jay on 16/5/13.
//  Copyright © 2016年 wonderland. All rights reserved.
//

#import "OpenApp.h"
#import <UIKit/UIKit.h>
#import "GetAllApps.h"
#import "Header.h"
#import <notify.h>


@implementation OpenApp

+ (OpenApp *)shareInstance {
    
    static OpenApp *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[OpenApp alloc] init];
    });
    
    return instance;
}

//- (void)openOtherAppWithName:(NSString *)name {
//    
//    NSLog(@"openOtherAppWithName");
//    
//    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"qbq.u.lobby:"]];
//    //    [[UIApplication sharedApplication]  ];
//    
//    [[UIApplication sharedApplication] performSelector:@selector(launchApplicationWithIdentifier:suspended:) withObject:@"qbq.u.lobby" withObject:NO];
//}

- (void)blockOrNot {
    
    NSArray *appDatas = [[GetAllApps shareInstance] getAppsDataForFile];

    for (NSDictionary *data in appDatas) {
        
        if ([data[kBID] isEqualToString:[[UIPasteboard generalPasteboard] string]]) {
            
            if (data[kSafeMode] && [data[kSafeMode] boolValue]) {
                
                NSString *postString = [[[UIPasteboard generalPasteboard] string] stringByAppendingString:@"safaModel"];
                
                const char *postChar = [postString cStringUsingEncoding:NSUTF8StringEncoding];
                
                notify_post(postChar);
                
            } else {
                
                if (data[kShouldBlockIP]) {
                    
                    if ([data[kShouldBlockIP] boolValue]) {
                        
                        NSString *postString = [[[UIPasteboard generalPasteboard] string] stringByAppendingString:@"block"];
                        
                        const char *postChar = [postString cStringUsingEncoding:NSUTF8StringEncoding];
                        
                        notify_post(postChar);
                    }
                }
            }

            break;
        }
    }
}

- (void)useChangeSetting {
    
    NSArray *appDatas = [[GetAllApps shareInstance] getAppsDataForFile];
    
    for (NSDictionary *data in appDatas) {
        
        if (data[kShouldKillApp]) {
            
            if ([data[kShouldKillApp] boolValue]) {
                
                NSString *killAfterTime = data[kKillTime];
                
                int killTime = [killAfterTime intValue] * 60;
                
                NSString *rebootAfterTime = data[kRebootAppTime];
                
                int rebootTime = [rebootAfterTime intValue] * 60;
                
                NSString *executableName = data[kExecutableName];
                
                NSString *appBID = data[kBID];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(killTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    NSString *systemString = [[NSString alloc] initWithFormat:@"killall -9 %@", executableName];
                    
                    const char *systemChar = [systemString cStringUsingEncoding:NSUTF8StringEncoding];
                    
                    system(systemChar);
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(rebootTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                        [[UIApplication sharedApplication] performSelector:@selector(launchApplicationWithIdentifier:suspended:) withObject:appBID withObject:NO];
                    });
                    
                });
            }
        }
    }
}

@end
