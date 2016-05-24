//
//  GameVC.m
//  zhushou
//
//  Created by k on 15/5/6.
//
//
#import "GameVC.h"

#import "WXMarco.h"


@interface GameVC () <UIGestureRecognizerDelegate,UITextFieldDelegate>
@property(nonatomic,assign)int module_base;

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

@property(nonatomic,strong)NSThread *luaThread;


//@property(nonatomic,assign)BOOL isShouldAutorotate;

@end

static BOOL isShouldAutorotate=NO;


static GameVC*instance;
@implementation GameVC


+(GameVC*)instance
{
    if (!instance) {
        
        instance=[[GameVC alloc]init];
    }
    return instance;
}
- (void)viewDidLayoutSubviews
{
   }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;
}

-(void) viewTransform
{
 
}

-(instancetype)init
{
    if (self=[super init])
    {
        
        self.view.backgroundColor=[UIColor clearColor];
        //        self.view.alpha=0.4f;K
        
        UITapGestureRecognizer* tapRecon = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignFirst)];
        tapRecon.numberOfTapsRequired = 1;
        tapRecon.delegate=self;
        [self.view addGestureRecognizer:tapRecon];
        
//        
         _log=[LogView instance];
        [self.view addSubview:_log];
//          _log.hidden=YES;
    
    
        
        
        [self addToolView];
        [self addTestButton];
        [self addSettingView];
        
        
    }
    return self;
}

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
  
    
    
    
}


-(void)func2
{
 
}

-(void)func3
{
 
}

-(void)func4

{
    //    [TouchTool touch:1000 Y:700 time:1];
    
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

-(void)gameEXIT:(void(^)(void))block
{
    _closeb=block;
   
}
-(void)gameEXIT
{
    if (_closeb)
    {
        _closeb();
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([_elixirField isFirstResponder])
    {
        [_elixirField resignFirstResponder];
    }
    
    if ([_goldField isFirstResponder])
    {
        [_goldField resignFirstResponder];
    }
    
    if ([touch.view isKindOfClass:[UIButton class]])
    {
        return YES;
    }
    
    return NO;
    
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
    [self.view addSubview:_testView];
    
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
    [testBut setTitle:@"暂停" forState:UIControlStateNormal];
    [testBut setFont:[UIFont systemFontOfSize:13]];
    testBut.tag = 0;
    testBut.layer.cornerRadius = 8;
    [testBut addTarget:self action:@selector(func2) forControlEvents:UIControlEventTouchUpInside];
    [_testView addSubview:testBut];
    
    
    UIButton*btn = [[UIButton alloc] initWithFrame:CGRectMake( 5*2  +  btnH, 5, btnW,btnH )];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"func3" forState:UIControlStateNormal];
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

-(void)addSettingView
{
    _settingView=[[UIButton alloc]initWithFrame:CGRectMake(230, 20, 180, 150)];
    [_settingView setDragEnable:YES];
    [_settingView setAdsorbEnable:YES];
    _settingView.layer.cornerRadius = 8;
    _settingView.backgroundColor=[UIColor lightGrayColor];
    _settingView.alpha=0.8;
    [self.view addSubview:_settingView];
    _settingView.hidden=YES;
    
    UILabel*sanLabel;
    
    sanLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    sanLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    [sanLabel setText:@"X"];
    [sanLabel setTextColor:[UIColor redColor]];
    [_settingView addSubview:sanLabel];
    
    _goldField=[[UITextField alloc]initWithFrame:CGRectMake(50, 0, 90, 30)];
    [_settingView addSubview:_goldField];
    _goldField.delegate=self;
    _goldField.keyboardType=UIKeyboardTypeNumberPad;
    [_goldField setText:@""];
    [_goldField setBackgroundColor:[UIColor whiteColor]];
    
    
    
    sanLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 90, 30)];
    [sanLabel setText:@"Y"];
    [sanLabel setTextColor:[UIColor redColor]];
    [_settingView addSubview:sanLabel];
    
    _elixirField=[[UITextField alloc]initWithFrame:CGRectMake(50, 50, 90, 30)];
    [_settingView addSubview:_elixirField];
    _elixirField.delegate=self;
    _elixirField.keyboardType=UIKeyboardTypeNumberPad;
    [_elixirField setText:@""];
    [_elixirField setBackgroundColor:[UIColor whiteColor]];
    
    
    UIButton*checkColor;
    checkColor = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 90, 40)];
    checkColor.backgroundColor = [UIColor redColor];
    [checkColor setTitle:@"check" forState:UIControlStateNormal];
    checkColor.layer.cornerRadius = 8;
    [checkColor addTarget:self action:@selector(checkColor) forControlEvents:UIControlEventTouchUpInside];
    [_settingView addSubview:checkColor];
    
    
}


-(void)addToolView
{

    int btnW=50;
    int btnH=50;
    
    int x=200;
    
    btnW=40;
    btnH=40;
    

    _toolView=[[UIButton alloc]initWithFrame:CGRectMake( 0,300, btnW*6, btnH)];
    [_toolView setDragEnable:YES];
    [_toolView setAdsorbEnable:YES];
    _toolView.backgroundColor=[UIColor whiteColor];
    _toolView.alpha=0.8;
    [self.view addSubview:_toolView];
    
    
    UIButton*testBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnW,btnH )];
    testBut.backgroundColor = [UIColor redColor];
    [testBut setTitle:@"清除" forState:UIControlStateNormal];
    testBut.tag = 0;
    testBut.layer.cornerRadius = 8;
    [testBut addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:testBut];
    
    
    _showLogBtn = [[UIButton alloc] initWithFrame:CGRectMake(10+btnW*1 ,0 ,  btnW,btnH )];
    _showLogBtn.backgroundColor = [UIColor redColor];
    [_showLogBtn setTitle:@"LOG" forState:UIControlStateNormal];
    _showLogBtn.tag = 0;
    _showLogBtn.layer.cornerRadius = 8;
    [_showLogBtn addTarget:self action:@selector(showLog) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:_showLogBtn];
    
    
    
    
    UIButton*showTestBtn;
    showTestBtn = [[UIButton alloc] initWithFrame:CGRectMake(10+btnW*2 ,0 , btnW,btnH )];
    showTestBtn.backgroundColor = [UIColor redColor];
    [showTestBtn setTitle:@"test" forState:UIControlStateNormal];
    showTestBtn.layer.cornerRadius = 8;
    [showTestBtn addTarget:self action:@selector(showTestBtn) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:showTestBtn];
    
    
    UIButton*showTextFile;
    showTextFile = [[UIButton alloc] initWithFrame:CGRectMake(10+btnW*3 , 0 ,  btnW,btnH )];
    showTextFile.backgroundColor = [UIColor redColor];
    [showTextFile setTitle:@"输入" forState:UIControlStateNormal];
    showTextFile.layer.cornerRadius = 8;
    [showTextFile addTarget:self action:@selector(showTextFile) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:showTextFile];
    
    
    _exitBtn = [[UIButton alloc] initWithFrame:CGRectMake(10+btnW*4 , 0 ,  btnW,btnH )];
    _exitBtn.backgroundColor = [UIColor redColor];
    [_exitBtn setTitle:@"EXIT" forState:UIControlStateNormal];
    _exitBtn.tag = 0;
    _exitBtn.layer.cornerRadius = 8;
    [_exitBtn addTarget:self action:@selector(gameEXIT) forControlEvents:UIControlEventTouchUpInside];
    [_toolView addSubview:_exitBtn];
    
}


@end



@implementation GameNAV


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController])
    {
        self.navigationBarHidden=YES;
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotate
{
    isShouldAutorotate=YES;
//    logView(@"---shouldAutorotate--");
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
//    logView(@"2 supportedInterfaceOrientations");
    
    //    return [GameInfo instance].orientation;
//    
//    if ([GameInfo instance].orientation == UIDeviceOrientationLandscapeRight  ||
//        [GameInfo instance].orientation == UIDeviceOrientationLandscapeLeft   )
//    {
//        logView(@"-- UIInterfaceOrientationMaskLandscape -- ");
//
//        return UIInterfaceOrientationMaskLandscape;
//  
//    }
    return UIInterfaceOrientationMaskAll;
}




//-(NSUInteger)supportedInterfaceOrientations
//{
//    return self.topMostViewController.supportedInterfaceOrientations;
//}
//-(BOOL)shouldAutorotate
//{
//    return [self.topMostViewController shouldAutorotate];
//}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return [self.topMostViewController preferredInterfaceOrientationForPresentation];
//}
//-(UIViewController*)topMostViewController
//{
//    //找到当前正在显示的viewController并返回.
//    return [GameVC instance];
//}


@end

