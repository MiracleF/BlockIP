//
//  GameWin.m
//  zhushou
//
//  Created by k on 15/5/6.
//
//

#import "GameWin.h"
#import "GameVC.h"
#import "WXMarco.h"
//#import "ZViewController.h"

#import <dlfcn.h>
#import <spawn.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import "TheMain.h"
static GameWin *instance=nil;


@interface GameWin ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)  UIButton *btn;

@property(nonatomic,strong)UIButton*toolView;
@property(nonatomic,strong)UIButton*testView;

@property(nonatomic,strong)UIButton*exitBtn;
@property(nonatomic,strong)UIButton*showLogBtn;
@property(nonatomic,strong)LogView*log;


@property(nonatomic,strong)UIButton*settingView;
@property(nonatomic,strong)UITextField*goldField;
@property(nonatomic,strong)UITextField*elixirField;
@property(nonatomic,strong)UISwitch *sanSwitchView;
@property(nonatomic,strong)UISwitch *autoSearch;


@property(nonatomic,strong)UIView*m_big_view;


@end


@implementation GameWin
+(GameWin*)instance
{
    if (!instance) {
        instance=[[GameWin alloc]init];
    }
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
     
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [UIColor clearColor];
        
        self.windowLevel = UIWindowLevelStatusBar;
        self.tag=1000;
 
        [self makeKeyAndVisible];
        

       
        UITapGestureRecognizer* tapRecon = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignFirst)];
        tapRecon.numberOfTapsRequired = 1;
        tapRecon.delegate=self;
        [self addGestureRecognizer:tapRecon];
        
        [self addTool];
       
//        _ipDic=[NSMutableDictionary dictionary];
//      _openHook=YES;
        
    }
    return self;
}


-(void) addTool
{
 
    
    _log=[LogView instance];
    [self addSubview:_log];

    [self addTestButton];
    //------------------------------------------
    
    
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, 50,50 )];
    
    _btn.backgroundColor = [UIColor greenColor];
    _btn.tag = 0;
    _btn.layer.cornerRadius = 8;
    [_btn setTitle:@"X" forState:UIControlStateNormal];
    [_btn setDragEnable:YES];
    [_btn setAdsorbEnable:YES];
    
  
    [_btn addTarget:self action:@selector(showWindow) forControlEvents:UIControlEventTouchUpInside];
    
    [[UIApplication sharedApplication].windows[0] addSubview:_btn];
 
}




-(void)show:(BOOL)y
{
    self.hidden=!y;
}

-(void)showWindow
{

    if (self.alpha==1) {
        self.alpha=0;
        [self resignKeyWindow];
    }
    else
    {
        self.alpha=1;
        [self makeKeyAndVisible];
        
    }
}

-(void)dismissWindow
{
    self.alpha=0;
    [self resignKeyWindow];
    
//    if (!_btn.superview)
//    {
//        [[[UIApplication sharedApplication]keyWindow] addSubview:_btn];
//
//    }
}


#pragma mark -

-(void)showScreenMessage
{
    
}

- (void)runThread
{
    
}

-(void)startLUA
{
    
}

-(void)func1
{
 
//    [TheMain instance].openHook=![TheMain instance].openHook;
//    
//    logView(@" openHook %d ",[TheMain instance].openHook);
}


-(void)func2
{
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    docDir=[docDir stringByAppendingString:@"/ip.plist"];
    
    
    
//    if ([[TheMain instance].ipDic writeToFile:docDir atomically:YES]) {
//        logView(@"ip.plist 创建成功 %@",docDir);
//    }
    
}

-(void)func3
{
    [LogView instance].textView.text=@"";
}

-(void)func4
{
    exit(0);
}
#pragma mark - 隐藏view

-(void)showAllTestView
{
    _log.hidden=NO;
    _testView.hidden=NO;
    _settingView.hidden=NO;
}
-(void)hiddeAllTestView
{
    _log.hidden=YES;
    _testView.hidden=YES;
    _settingView.hidden=YES;
}


-(void)showLog
{
    
    if (_log.hidden)
    {
        _log.hidden=NO;
    }
    else{
        _log.hidden=YES;
    }
}


-(void)showTestBtn
{
    if (_testView.hidden)
    {
        _testView.hidden=NO;
    }
    else{
        _testView.hidden=YES;
    }
}

-(void)showTextFile
{
    
    if (_settingView.hidden)
    {
        _settingView.hidden=NO;
    }
    else{
        _settingView.hidden=YES;
    }
}

-(void)checkColor
{
    
    
}

-(void)clear
{
    [[LogView instance]clear];
}

-(UIView*)addTestButton
{
    
    
    int btnW=70;
    int btnH=70;
    
    int x=200;
    if (IsPad)
    {
        x=500;
    }
    else{
        btnW=40;
        btnH=40;
    }
    
    //    long decivce= [DeviceUtil hardware];
    //
    //    if (decivce < IPHONE_5)
    //    {
    //        btnW=40;
    //        btnH=40;
    //    }
    
    _testView=[[UIButton alloc ]initWithFrame:CGRectMake(x, 20, btnW*2 +10, btnH*3)];
    [_testView setBackgroundColor:[UIColor grayColor]];
    _testView.layer.cornerRadius = 8;
    _testView.alpha=0.8;
    [_testView setDragEnable:YES];
    [_testView setAdsorbEnable:YES];
    [self addSubview:_testView];
    
    UIButton*testBut = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, btnW,btnH )];
    testBut.backgroundColor = [UIColor redColor];
    [testBut setTitle:@"开始" forState:UIControlStateNormal];
    [testBut setFont:[UIFont systemFontOfSize:13]];
    testBut.tag = 0;
    testBut.layer.cornerRadius = 8;
    [testBut addTarget:self action:@selector(func1) forControlEvents:UIControlEventTouchUpInside];
    [_testView addSubview:testBut];
    
    testBut = [[UIButton alloc] initWithFrame:CGRectMake(5,  btnH +10,  btnW,btnH )];
    testBut.backgroundColor = [UIColor redColor];
    [testBut setTitle:@"写" forState:UIControlStateNormal];
    [testBut setFont:[UIFont systemFontOfSize:13]];
    testBut.tag = 0;
    testBut.layer.cornerRadius = 8;
    [testBut addTarget:self action:@selector(func2) forControlEvents:UIControlEventTouchUpInside];
    [_testView addSubview:testBut];
    
    
    UIButton*btn = [[UIButton alloc] initWithFrame:CGRectMake( 5*2  +  btnH, 5, btnW,btnH )];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"清屏" forState:UIControlStateNormal];
    btn.tag = 0;
    btn.layer.cornerRadius = 8;
    [btn addTarget:self action:@selector(func3) forControlEvents:UIControlEventTouchUpInside];
    [_testView addSubview:btn];
    
    btn = [[UIButton alloc] initWithFrame:CGRectMake( 5*2  +  btnH, btnH +10, btnW,btnH )];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"func4" forState:UIControlStateNormal];
    btn.tag = 0;
    btn.layer.cornerRadius = 8;
    [btn addTarget:self action:@selector(func4) forControlEvents:UIControlEventTouchUpInside];
    [_testView addSubview:btn];
    
    
    return _testView;
}



-(void)eixtt{
    exit(0);
}

-(void)resignFirst
{
    [self dismissWindow];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //如果点到的是按钮，则不屏蔽点击事件
    if ([touch.view isKindOfClass:[UIWindow class]])
    {
        return YES;
    }
    
    return NO;
}

@end

