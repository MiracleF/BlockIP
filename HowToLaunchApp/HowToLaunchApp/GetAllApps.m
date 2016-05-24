//
//  GetAllApps.m
//  HowToLaunchApp
//
//  Created by Jay on 16/5/17.
//
//

#import "GetAllApps.h"
#import "Header.h"
#include <notify.h>
#import "dlfcn.h"
#import <objc/message.h>

#define MobileInstallation "/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation"
#define MobileCoreServices "/System/Library/Frameworks/MobileCoreServices.framework/MobileCoreServices"

typedef void (*pfnCLClientShutdownDaemon)(void);
pfnCLClientShutdownDaemon CLClientShutdownDaemon;

@implementation GetAllApps

+ (GetAllApps *)shareInstance {
    
    static GetAllApps *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[GetAllApps alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        [self setupAllApps];
    }
    return self;
}

- (NSArray *)getAppsDataForFile {
    
    NSString *homeDir = NSHomeDirectory();
    
    NSString *plistPath = [homeDir stringByAppendingString:@"/apps.plist"];
    
    NSArray *appsData = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    return appsData;
}


/*
- (void)setupAllApps {
    
    if (_allApps == nil) {
        
        _allApps = [self getAllAppData];

        NSString *homeDir = NSHomeDirectory();
        
        NSString *plistPath = [homeDir stringByAppendingString:@"/apps.plist"];
        
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        
        if (![fileMgr fileExistsAtPath:plistPath]) {
            
            [fileMgr createFileAtPath:plistPath contents:nil attributes:nil];
        }

        [_allApps writeToFile:plistPath atomically:YES];
    }
}

- (NSArray *)getAllAppData {
    
    return [[NSArray alloc] initWithArray:[self scanApps]];
}



- (NSMutableArray *)scanApps
{
    NSString *pathOfApplications;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        pathOfApplications = @"/var/mobile/Containers/Bundle/Application";
    else
        pathOfApplications = @"/var/mobile/Applications";
    
    NSLog(@"scan begin");
    
    // all applications

    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    

    [mutableArray addObjectsFromArray:[self getAppDataWithPath:pathOfApplications]];

    pathOfApplications = @"/Applications";
    
    [mutableArray addObjectsFromArray:[self getJailBreakAppDataWithPath:pathOfApplications]];
    
    return mutableArray;
}

- (NSArray *)getAppDataWithPath:(NSString *)pathOfApplications{
    
    NSArray *arrayOfApplications = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathOfApplications error:nil];
    
    NSLog(@"arrayOfApplications %@", arrayOfApplications);
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
    for (NSString *applicationDir in arrayOfApplications) {
        // path of an application
        NSString *pathOfApplication = [pathOfApplications stringByAppendingPathComponent:applicationDir];
        NSArray *arrayOfSubApplication = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathOfApplication error:nil];

        // seek for *.app
        for (NSString *applicationSubDir in arrayOfSubApplication) {
            if ([applicationSubDir hasSuffix:@".app"]) {// *.app

                NSString *path = [pathOfApplication stringByAppendingPathComponent:applicationSubDir];
                NSString *imagePath = [pathOfApplication stringByAppendingPathComponent:applicationSubDir];
                path = [path stringByAppendingPathComponent:@"Info.plist"];
                
                
                // so you get the Info.plist in the dict
                NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
                
                if([[dict allKeys] containsObject:@"CFBundleIdentifier"] && [[dict allKeys] containsObject:@"CFBundleExecutable"]){
                    
                    NSArray *values = [dict allValues];
                    
                    NSString *icon;
                    
                    for (id value in values) {
                        
                        icon = [self getIcon:value withPath:imagePath];
                        
                        if (![icon isEqualToString:@""]) {
                            
                            imagePath = [imagePath stringByAppendingPathComponent:icon];
                            
                            break;
                            
                        } else {
                            
//                            imagePath = @"";
                        }
                    }
                    
                    NSString *bid = dict[@"CFBundleIdentifier"];
                    
                    if (!bid) {
                        
                        bid = @"";
                    }
                    
                    NSString *executable = dict[@"CFBundleExecutable"];
                    
                    if (!executable) {
                        
                        executable = @"";
                    }
                    
                    NSString *displayName = dict[@"CFBundleDisplayName"];
                    
                    if (!displayName) {
                        
                        displayName = @"";
                    }
                    
                    NSDictionary *appDic = [[NSDictionary alloc] initWithObjectsAndKeys:bid, kBID, executable, kExecutableName, imagePath, kImagePath, displayName, kDisplayName, nil];
                    
                    [mutableArray addObject:appDic];
                    
                }
            }
        }
    }
    
    return mutableArray;
}

- (NSArray *)getJailBreakAppDataWithPath:(NSString *)pathOfApplications{
    
    NSArray *arrayOfApplications = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathOfApplications error:nil];
    
    NSLog(@"arrayOfApplications %@", arrayOfApplications);
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
        // seek for *.app
        for (NSString *applicationSubDir in arrayOfApplications) {
            if ([applicationSubDir hasSuffix:@".app"]) {// *.app
                
                NSString *path = [pathOfApplications stringByAppendingPathComponent:applicationSubDir];
                NSString *imagePath = [pathOfApplications stringByAppendingPathComponent:applicationSubDir];
                path = [path stringByAppendingPathComponent:@"Info.plist"];
                
                
                // so you get the Info.plist in the dict
                NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
                
                if([[dict allKeys] containsObject:@"CFBundleIdentifier"] && [[dict allKeys] containsObject:@"CFBundleExecutable"]){
                    
                    NSArray *values = [dict allValues];
                    
                    NSString *icon;
                    
                    for (id value in values) {
                        
                        icon = [self getIcon:value withPath:imagePath];
                        
                        if (![icon isEqualToString:@""]) {
                            
                            imagePath = [imagePath stringByAppendingPathComponent:icon];
                            
                            break;
                            
                        }
                    }
                    
                    NSString *bid = dict[@"CFBundleIdentifier"];
                    
                    if (!bid) {
                        
                        bid = @"";
                    }
                    
                    NSString *executable = dict[@"CFBundleExecutable"];
                    
                    if (!executable) {
                        
                        executable = @"";
                    }
                    
                    NSString *displayName = dict[@"CFBundleDisplayName"];
                    
                    if (!displayName) {
                        
                        displayName = @"";
                        
                        continue;
                    }
                    
                    if (![imagePath hasSuffix:@"png"]) {
                        
                        continue;
                    }
                    
                    NSDictionary *appDic = [[NSDictionary alloc] initWithObjectsAndKeys:bid, kBID, executable, kExecutableName, imagePath, kImagePath, displayName, kDisplayName, nil];
                    
                    [mutableArray addObject:appDic];
                    
                }
            }
        }
    
    return mutableArray;
}


- (NSString *)getIcon:(id)value withPath:(NSString *)imagePath
{
    
    if([value isKindOfClass:[NSString class]]) {
        NSRange range = [value rangeOfString:@"png"];
        NSRange iconRange = [value rangeOfString:@"icon"];
        NSRange IconRange = [value rangeOfString:@"Icon"];
        if (range.length > 0){
            NSString *path = [imagePath stringByAppendingPathComponent:value];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            if (image != nil) {
                
                return value;
            }
        }
        else if(iconRange.length > 0){
            
            return [self findoutIconNameWithValue:value andImagePath:imagePath];

        }
        else if(IconRange.length > 0){
            
            return [self findoutIconNameWithValue:value andImagePath:imagePath];

        }
    }
    else if([value isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = (NSDictionary *)value;
        for (id subValue in [dict allValues]) {
            NSString *str = [self getIcon:subValue withPath:imagePath];
            if (![str isEqualToString:@""]) {
                return str;
            }
        }
    }
    else if([value isKindOfClass:[NSArray class]]){
        for (id subValue in value) {
            NSString *str = [self getIcon:subValue withPath:imagePath];
            if (![str isEqualToString:@""]) {
                return str;
            }
        }
    }
    return @"";
}

- (NSString *)findoutIconNameWithValue:(NSString *)value andImagePath:(NSString *)imagePath {
    
    NSString *imgUrl;
    
    for (int i = 1; i < 4; i ++) {
        
        if (i == 1) {
            
            if (MMIsPad) {
                imgUrl = [NSString stringWithFormat:@"%@~ipad.png",value];
            } else {
                imgUrl = [NSString stringWithFormat:@"%@.png",value];
            }
        } else {
            
            if (MMIsPad) {
                imgUrl = [NSString stringWithFormat:@"%@@%dx~ipad.png",value, i];
            } else {
                imgUrl = [NSString stringWithFormat:@"%@@%dx.png",value, i];
            }
        }
        
        NSString *path = [imagePath stringByAppendingPathComponent:imgUrl];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        if (image != nil) {
            
            return imgUrl;
            
        }
    }
    
    return @"";
}
*/

@end
