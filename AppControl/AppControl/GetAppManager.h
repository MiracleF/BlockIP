//
//  GetAppManager.h
//  AppControl
//
//  Created by Jay on 16/5/17.
//  Copyright © 2016年 wonderland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAppManager : NSObject

+ (GetAppManager *)shareInstance;

@property (strong, nonatomic) NSMutableArray *allApps;

- (void)upDataAppsPlist;  //获取所有应用信息

- (void)updataOneAppDataWithDic:(NSDictionary *)dic; //更新单个应用信息

- (void)setupAllApps; //刷新所有应用信息

@end
