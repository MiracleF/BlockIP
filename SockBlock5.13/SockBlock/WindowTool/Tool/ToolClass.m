//
//  ToolClass.m
//  LuaTest
//
//  Created by k on 15/4/27.
//  Copyright (c) 2015年 LuaTest. All rights reserved.
//

#import "ToolClass.h"

@implementation ToolClass


//.app下的文件
+(id)getAppResourceWith:(NSString*)name
{
    NSString *path = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:name];
    return path;
}

+(void)getGameDoc
{
    
}

+(NSString*)deviceMobileDoc
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths objectAtIndex:0];
    
    return path;
}


+(void)logTime
{
    
    NSDate *now;
    NSDateFormatter *formatter;
    NSString *dateString ;
    
    now= [NSDate date];
    formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    dateString = [formatter stringFromDate:now];
    
//    [[LogView instance] log:@"%@",dateString];

}


//+(UIImageView*)tableview_Bg_image
//{
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    CGSize size = rect.size;
//    CGFloat width = size.width;
//    CGFloat height = size.height;
//    
//    
//     UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width,2000)];
//    
//    return imageview;
//}


@end
