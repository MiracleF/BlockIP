//
//  TheMain.m
//  SockBlock
//
//  Created by Jay1990 on 15/9/5.
//
//

#import "TheMain.h"
#include <mach/mach.h>
#include <mach-o/dyld.h>
#import <substrate.h>
#import <limits.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import <dlfcn.h>
#import "fishhook.h"
#import <netdb.h>
#import <string.h>
#import  <CFNetwork/CFHost.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "GameWin.h"
#import "LogView.h"
#import "HookTool.h"
#import "ShowWindow.h"
#import "IPTableViewController.h"
#import "Data.h"
#import <notify.h>
//#include <cstring>

#define host127 @"127.0.0.1"
#define hosthttp127 @"http://127.0.0.1"

static void starBlockIP(CFNotificationCenterRef center, void *observer, CFStringRef name, const         void *object, CFDictionaryRef userInfo) {
    
    [TheMain instance].openHook = YES;
}

static void safeMode(CFNotificationCenterRef center, void *observer, CFStringRef name, const         void *object, CFDictionaryRef userInfo) {
    
    [TheMain instance].safeMode = YES;
}

void hookOrNotHook() {
    
    NSString *bid = [[[NSBundle mainBundle] bundleIdentifier] stringByAppendingString:@"block"];
    
    NSString *bid2 = [[[NSBundle mainBundle] bundleIdentifier] stringByAppendingString:@"safaModel"];
    
    CFStringRef aCFString = (__bridge CFStringRef)bid;
    
    CFStringRef aCFString2 = (__bridge CFStringRef)bid2;
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, starBlockIP, aCFString, NULL,         CFNotificationSuspensionBehaviorCoalesce);
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, safeMode, aCFString2, NULL,         CFNotificationSuspensionBehaviorCoalesce);
    
    [UIPasteboard generalPasteboard].string = [[NSBundle mainBundle] bundleIdentifier];
    
    notify_post("com.wonderland.blockornot");
}

@implementation TheMain


+ (instancetype)instance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //        _openHook=YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidAdd) name:UIWindowDidBecomeKeyNotification object:nil];
        
    }
    return self;
}

- (void)windowDidAdd {
    
    hookOrNotHook();
}

@end

NSMutableArray *ipArray = nil;

static ssize_t (*oldSendto)(int, const void *, size_t,
                            int, const struct sockaddr *, socklen_t);

static int	(*orig_connect)(int, const struct sockaddr *, socklen_t);

static CFHostRef
(*orig_CFHostCreateWithName)(CFAllocatorRef allocator, CFStringRef hostname);

static CFHTTPMessageRef
(*orig_CFHTTPMessageCreateRequest)(CFAllocatorRef alloc, CFStringRef requestMethod, CFURLRef url, CFStringRef httpVersion);

static CFURLRef (*orig_CFURLCreateWithString)(CFAllocatorRef allocator, CFStringRef URLString, CFURLRef baseURL);



void save_original_symbols() {
    
    oldSendto = dlsym(RTLD_DEFAULT, "sendto");
    orig_connect = dlsym(RTLD_DEFAULT, "connect");
    orig_CFHostCreateWithName = dlsym(RTLD_DEFAULT, "CFHostCreateWithName");
    //    NSLog(@"orig_CFHostCreateWithName %p %p", orig_CFHostCreateWithName, &CFHostCreateWithName);
    orig_CFHTTPMessageCreateRequest = dlsym(RTLD_DEFAULT, "CFHTTPMessageCreateRequest");
    //    NSLog(@"orig_CFHTTPMessageCreateRequest %p", orig_CFHTTPMessageCreateRequest);
    
    orig_CFURLCreateWithString = dlsym(RTLD_DEFAULT, "CFURLCreateWithString");
    
    
}

ssize_t my_sendto(int arg1, const void *arg2, size_t arg3,
                  int arg4, struct sockaddr * arg5, socklen_t arg6)
{
    return oldSendto(arg1,arg2,arg3,arg4,arg5,arg6);
    
    //    return 0;
}

int	my_connect(int arg1, const struct sockaddr * arg2, socklen_t arg3) {
    
    //    if ([TheMain instance].openHook)
    //    {
    //        struct sockaddr_in* sin;
    //
    //        memcpy(&sin, &arg2, sizeof(sin));
    //
    //        if (sin != 0) {
    //
    //            NSString *ipString = [NSString stringWithFormat:@"%s", inet_ntoa((*sin).sin_addr)];
    //
    //            if ([ipString isEqualToString:@"localhost"] ||
    //                [ipString isEqualToString:@"11.0.0.0"]  ||
    //                [ipString isEqualToString:@"3.0.0.0"]   ||
    //                [ipString isEqualToString:@"8.0.0.0"]   ||
    //                [ipString isEqualToString:@"7.0.0.0"]   ||
    //                [ipString isEqualToString:@"5.0.0.0"]   ||
    //                [ipString isEqualToString:@"127.0.0.1"]
    //
    //                )
    //            {
    //
    //                return orig_connect(arg1, arg2, arg3);
    //
    //            }
    //            else
    //            {
    //还没加进去的
    //                if (![Data shareInstance].unSelectIPDic[ipString])
    //                {
    //                    in_port_t port =  ((*sin).sin_port);
    //
    ////                    logView(@"新 socka——ip > %s:%d", inet_ntoa((*sin).sin_addr),port);
    //
    //                    [[Data shareInstance].unSelectIPDic setObject:@(port) forKey:ipString];
    //                }
    //
    //                NSString * host = @"127.0.0.1";
    //                struct hostent * remoteHostEnt = gethostbyname([host UTF8String]);
    //                struct in_addr * remoteInAddr = (struct in_addr *)remoteHostEnt->h_addr_list[0];
    //
    //
    //                (*sin).sin_addr = *remoteInAddr;
    //
    //                return orig_connect(arg1, (struct sockaddr *) &sin, arg3);
    //
    //            }
    //        }
    //    }
    //
    //    else{
    
    
    if ([TheMain instance].safeMode) {
        
        return orig_connect(arg1, arg2, arg3);
    }
    
    struct sockaddr_in* sin;
    
    memcpy(&sin, &arg2, sizeof(sin));
    
    if (sin != 0)
    {
        
        NSString *ipString = [NSString stringWithFormat:@"%s", inet_ntoa((*sin).sin_addr)];
        
        if ([ipString isEqualToString:@"localhost"] ||
            [ipString isEqualToString:@"11.0.0.0"]  ||
            [ipString isEqualToString:@"3.0.0.0"]   ||
            [ipString isEqualToString:@"8.0.0.0"]   ||
            [ipString isEqualToString:@"7.0.0.0"]   ||
            [ipString isEqualToString:@"5.0.0.0"]   ||
            [ipString isEqualToString:@"127.0.0.1"]
            
            )
        {
            
        } else {
            

            
            if (![Data shareInstance].unSelectIPDic[ipString])
            {
                
                if (![Data shareInstance].selectIPDic[ipString]) {
                    
                    in_port_t port =  ((*sin).sin_port);
                    
                    
                    
                    if ([TheMain instance].openHook) {
                        
                        [[Data shareInstance].selectIPDic setObject:@(port) forKey:ipString];
                        
                        NSString * host = @"127.0.0.1";
                        struct hostent * remoteHostEnt = gethostbyname([host UTF8String]);
                        struct in_addr * remoteInAddr = (struct in_addr *)remoteHostEnt->h_addr_list[0];
                        
                        
                        (*sin).sin_addr = *remoteInAddr;
                        
                        return orig_connect(arg1, (struct sockaddr *) &sin, arg3);
                    }
                    
                    [[Data shareInstance].unSelectIPDic setObject:@(port) forKey:ipString];
                    
                } else {
                    
                    NSString * host = @"127.0.0.1";
                    struct hostent * remoteHostEnt = gethostbyname([host UTF8String]);
                    struct in_addr * remoteInAddr = (struct in_addr *)remoteHostEnt->h_addr_list[0];
                    
                    
                    (*sin).sin_addr = *remoteInAddr;
                    
                    return orig_connect(arg1, (struct sockaddr *) &sin, arg3);
                }
            }
        }
    }
    //    }
    
    return orig_connect(arg1, arg2, arg3);
}

CFHostRef
my_CFHostCreateWithName(CFAllocatorRef allocator, CFStringRef hostname) {
    
    return orig_CFHostCreateWithName(allocator, hostname);
}

CFHTTPMessageRef
my_CFHTTPMessageCreateRequest(CFAllocatorRef alloc, CFStringRef requestMethod, CFURLRef url, CFStringRef httpVersion) {
    
    return orig_CFHTTPMessageCreateRequest(alloc,requestMethod,url,httpVersion);
}

CFURLRef my_CFURLCreateWithString(CFAllocatorRef allocator, CFStringRef URLString, CFURLRef baseURL) {
    
    if ([TheMain instance].safeMode) {
        
        return orig_CFURLCreateWithString(allocator, URLString, baseURL);
    }
    
    NSString *urlString;
    urlString = (__bridge NSString *)URLString;
    
    
    CFURLRef tempURL = orig_CFURLCreateWithString(allocator, URLString, baseURL);
    NSString *host;
    host = (__bridge NSString *)CFURLCopyHostName(tempURL);
    
    
    
    if (![urlString hasPrefix:@"file:"]) {
        
        
        if (tempURL)
        {
            
            //                logView(@"1->%@ \n 2->%@ ", urlString,(__bridge NSString *)CFURLGetString(tempURL));
            
            //                CFURLRef CFURLCopyAbsoluteURL(CFURLRef relativeURL);
            //
            //                /* Returns the URL's string. */
            //                CF_EXPORT
            //                CFStringRef CFURLGetString(CFURLRef anURL);
            //
            //                /* Returns the base URL if it exists */
            //                CF_EXPORT
            //                CFURLRef CFURLGetBaseURL(CFURLRef anURL);
            
            //                if (![host isEqualToString:host127])
            //                {
            //
            //                  //还没加进去的
            //                  if (![Data shareInstance].unSelectIPDic[urlString])
            //                  {
            //                      [[Data shareInstance].unSelectIPDic setObject:host forKey:urlString];
            //
            //
            //                  }
            //
            ////                    不是127 替换
            //                    urlString=[urlString stringByReplacingOccurrencesOfString:host withString:host127];
            //                    URLString=(__bridge CFStringRef)(urlString);
            //
            //
            //
            //                }
            //            }
            //
            //            else{
            //
            //            }
            //        }
            //        else
            //        {
            if (![host isEqualToString:host127])
            {
                //还没加进去的
                if (![Data shareInstance].unSelectIPDic[host])
                {
                    
                    if (![Data shareInstance].selectIPDic[host]) {
                        
                        if ([TheMain instance].openHook) {
                            
                            [[Data shareInstance].selectIPDic setObject:urlString forKey:host];
                            
                            urlString=[urlString stringByReplacingOccurrencesOfString:host withString:host127];
                            
                            URLString=(__bridge CFStringRef)(urlString);
                        } else {
                            
                            [[Data shareInstance].unSelectIPDic setObject:urlString forKey:host];
                        }
                        
                    } else {
                        
                        urlString=[urlString stringByReplacingOccurrencesOfString:host withString:host127];
                        
                        URLString=(__bridge CFStringRef)(urlString);
                    }
                }
            }
        }
    }
    
    return orig_CFURLCreateWithString(allocator, URLString, baseURL);
}


static id (*old_URLWithString)(id self, SEL _cmd,id a1 );
static id new_URLWithString(id self, SEL _cmd,id a1 )
{
    return old_URLWithString(  self,   _cmd,  a1 );
}

static id (*old_URLWithString_relativeToURL)(id self, SEL _cmd,id a1 ,id a2 );
static id new_URLWithString_relativeToURL(id self, SEL _cmd,id a1 ,id a2 )
{
    return old_URLWithString_relativeToURL(  self,   _cmd,  a1 ,  a2 );
}


// 类方法

// Original implementation of the methods we swizzle
static id (*oldclass_URLWithString)(id self, SEL _cmd,id a1  )= NULL;

// Swizzled method implementations
static id newclass_URLWithString(id self, SEL _cmd,id a1  )
{
    return (*oldclass_URLWithString)(  self,   _cmd,  a1  );
}

__attribute__((constructor)) int main(int argc, char * argv[])
{
    @autoreleasepool {
        
        NSString *appID = [[NSBundle mainBundle] bundleIdentifier];
        
        if (![appID hasPrefix:@"com.apple"]) {
            
            [TheMain instance];
            
            save_original_symbols();
            
            rebind_symbols((struct rebinding[5]){{"__sendto",my_sendto},
                {"CFURLCreateWithString", my_CFURLCreateWithString},
                {"CFHostCreateWithName", my_CFHostCreateWithName},
                {"CFHTTPMessageCreateRequest", my_CFHTTPMessageCreateRequest},
                {"connect", my_connect}}, 5);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                           {
                               //                               [GameWin instance];

                               [ShowWindow shareInstance];

                           });
        }
        
        return 0;
    }
}
