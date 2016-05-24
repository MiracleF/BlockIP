//
//  ShowWindow.m
//  SockBlock
//
//  Created by Jay on 16/5/13.
//
//

#import "ShowWindow.h"
#import "UIButton+NMCategory.h"
#import "IPTableViewController.h"
#import "TheMain.h"
#import <notify.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define MMIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

static ShowWindow *window = nil;

@interface ShowWindow () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIButton *btn;

@end



@implementation ShowWindow

+ (ShowWindow *)shareInstance {
    
    
    if (window == nil) {
        
        window = [[ShowWindow alloc] init];
    }

    return window;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [UIColor redColor];
        
        self.windowLevel = UIWindowLevelStatusBar;
        self.tag=1000;
        
//        if (!MMIsPad) {
//            self.frame = [UIScreen mainScreen].bounds;
//        } else {
//            if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
//                self.frame = [UIScreen mainScreen].bounds;
//            } else {
//                if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
//                    self.frame = CGRectMake(0, 0, 1024, 768);
//                } else {
//                    self.frame = CGRectMake(0, 0, 768, 1024);
//                }
//            }
//        }
        
//        [self makeKeyAndVisible];

//        self.hidden = NO;
        
//        UITapGestureRecognizer* tapRecon = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignFirst)];
//        
//        tapRecon.numberOfTapsRequired = 1;
//        
//        tapRecon.delegate = self;
//        
//        [self addGestureRecognizer:tapRecon];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissWindow) name:@"hideWindowNotification" object:nil];
        
        [self addTool];
        
    }
    return self;
}

- (void)resignFirst
{
    [self dismissWindow];
}

- (void)dismissWindow
{
    self.alpha=0;
    
    [self resignKeyWindow];
    
    [self removeFromSuperview];
}

- (void)addTool {
    
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, 100, 100)];
    
    _btn.backgroundColor = [UIColor greenColor];
    _btn.tag = 0;
    _btn.layer.cornerRadius = 8;
    [_btn setTitle:@"X" forState:UIControlStateNormal];
    [_btn setDragEnable:YES];
    [_btn setAdsorbEnable:YES];
    
    [_btn addTarget:self action:@selector(showWindow) forControlEvents:UIControlEventTouchUpInside];
    
    [[UIApplication sharedApplication].windows[0] addSubview:_btn];
    
    
    IPTableViewController *ipVC = [IPTableViewController shareInstance];
    
    [self setRootViewController:ipVC];
}

- (void)showWindow
{
    if (self.alpha==1) {
        
        self.alpha=0;
        
        [self resignKeyWindow];
        
        
    }
    else
    {
        self.alpha=1;
        
        [self makeKeyAndVisible];
        
        [[IPTableViewController shareInstance].tableView reloadData];

    }
}



@end
