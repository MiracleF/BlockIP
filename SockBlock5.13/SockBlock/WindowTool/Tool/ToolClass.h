//
//  ToolClass.h
//  LuaTest
//
//  Created by k on 15/4/27.
//  Copyright (c) 2015年 LuaTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolClass : NSObject

+(id)getAppResourceWith:(NSString*)name;

+(NSString*)deviceMobileDoc;

+(void)logTime;

//+(UIImageView*)tableview_Bg_image;

@end
