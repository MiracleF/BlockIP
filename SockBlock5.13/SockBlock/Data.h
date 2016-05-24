//
//  Data.h
//  SockBlock
//
//  Created by Jay on 16/5/16.
//
//

#import <Foundation/Foundation.h>

@interface Data : NSObject

+ (Data *)shareInstance;

@property (strong, nonatomic) NSMutableDictionary *selectIPDic; //禁用的IP

@property (strong ,nonatomic) NSMutableDictionary *unSelectIPDic; //没有禁用的IP

@end
