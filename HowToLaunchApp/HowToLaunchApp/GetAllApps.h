//
//  GetAllApps.h
//  HowToLaunchApp
//
//  Created by Jay on 16/5/17.
//
//

#import <Foundation/Foundation.h>

@interface GetAllApps : NSObject

+ (GetAllApps *)shareInstance;

@property (strong, nonatomic) NSArray *allApps;

- (NSArray *)getAppsDataForFile;

@end
