//
//  Data.m
//  SockBlock
//
//  Created by Jay on 16/5/16.
//
//

#import "Data.h"
#import "WXMarco.h"


@implementation Data

+ (Data *)shareInstance {
    
    static Data *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[Data alloc] init];
        
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kIpSelectDic];  //读取数据
        
        _unSelectIPDic = [[NSMutableDictionary alloc] initWithDictionary:dic[kUnSelect]];
        
        _selectIPDic = [[NSMutableDictionary alloc] initWithDictionary:dic[kSelect]];
    }
    return self;
}

@end
