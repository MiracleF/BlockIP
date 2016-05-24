//
//  IPTableViewController.m
//  SockBlock
//
//  Created by Jay on 16/5/13.
//
//

#import "IPTableViewController.h"
#import "TheMain.h"
#import "ShowWindow.h"
#import "Data.h"
#import "WXMarco.h"
#include <notify.h>

@interface IPTableViewController ()

@property (strong, nonatomic) UIButton *updataBtn, *hideBtn;

@end

@implementation IPTableViewController

+ (IPTableViewController *)shareInstance {
    
    static IPTableViewController *IPVC = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        IPVC = [[IPTableViewController alloc] init];
        
    });
    
    return IPVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavBar];
    
//    [self addObserver:self forKeyPath:@"IPArray.lastObject" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
        

    }
    
//    if (!_updataBtn) {
//        
//        _updataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        _updataBtn.backgroundColor = [UIColor redColor];
//        
//        _updataBtn.frame = CGRectMake(50, 100, 200, 200);
//        
//        [_updataBtn addTarget:self action:@selector(didTapOnUpdataBtn:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self.view addSubview:_updataBtn];
//    }
//    
//    if (!_hideBtn) {
//        
//        _hideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        _hideBtn.backgroundColor = [UIColor greenColor];
//        
//        _hideBtn.frame = CGRectMake(600, 100, 200, 200);
//        
//        [_hideBtn addTarget:self action:@selector(didTapOnHideBtn:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self.view addSubview:_hideBtn];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 添加导航栏
- (void)setupNavBar {
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    
    //    navBar.backgroundColor = [UIColor whiteColor];
    
    navBar.barStyle = UIBarStyleBlackTranslucent;
    
    navBar.barTintColor = [UIColor blackColor];
    
    //    navBar.tintColor = [UIColor redColor];
    //    navBar.tintColor = [UIColor colorWithRed:50/255.0 green:138/255.0 blue:233/255.0 alpha:1.0];//改变navigation的背景颜色
    
    //    navBar.translucent = NO;
    
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"域名"];
    
    //    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppleID_title"]];
    //    titleImageView.frame = CGRectMake(0, 0, 320, 64);
    //
    //    navItem.titleView = titleImageView;
    
    //    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didTapOnLeftBtn:)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(didTapOnHideBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:@"返回" forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0, 0, 60, 44);
    
    UIBarButtonItem *leftBtn =[[UIBarButtonItem alloc] initWithCustomView:button];
    
    navItem.leftBarButtonItem = leftBtn;
    
    
    
    UIButton *rigButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rigButton addTarget:self action:@selector(didTapOnUpdataBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [rigButton setTitle:@"上传" forState:UIControlStateNormal];
    
    rigButton.frame = CGRectMake(0, 0, 60, 44);
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:rigButton];
    
    navItem.rightBarButtonItem = rightBtn;
    
    [navBar pushNavigationItem:navItem animated:NO];
    
    [navBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
    [self.view addSubview:navBar];
    
}


#pragma mark - button action
- (void)didTapOnUpdataBtn:(UIButton *)btn {

//    notify_post("com.wonderland.rootdaemon.killapp");
}

- (void)didTapOnHideBtn:(UIButton *)btn {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideWindowNotification" object:nil];
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return [[Data shareInstance].unSelectIPDic count];
        
    } else {
        
        return [[Data shareInstance].selectIPDic count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString *unSelectString = @"unSelCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unSelectString];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:unSelectString];
        }
        
        NSArray *ipArray = [[Data shareInstance].unSelectIPDic allKeys];
        
        cell.textLabel.text = ipArray[indexPath.row];
        
        return cell;
        
    } else {
        
        static NSString *selectString = @"selCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectString];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectString];
        }
        
        NSArray *ipArray = [[Data shareInstance].selectIPDic allKeys];
        
        cell.textLabel.text = ipArray[indexPath.row];
        
        return cell;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return @"未屏蔽";
        
    } else {
        
        return @"已经屏蔽";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        NSString *key = [[Data shareInstance].unSelectIPDic allKeys][indexPath.row];

        [[Data shareInstance].selectIPDic setValue:[Data shareInstance].unSelectIPDic[key] forKey:key];
        
        [[Data shareInstance].unSelectIPDic removeObjectForKey:key];
        
    } else {
        
        NSString *key = [[Data shareInstance].selectIPDic allKeys][indexPath.row];
        
        [[Data shareInstance].unSelectIPDic setValue:[Data shareInstance].selectIPDic[key] forKey:key];
        
        [[Data shareInstance].selectIPDic removeObjectForKey:key];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[Data shareInstance].unSelectIPDic, kUnSelect, [Data shareInstance].selectIPDic, kSelect, nil];
        
        [[NSUserDefaults standardUserDefaults] setValue:dic forKey:kIpSelectDic];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    
    [tableView reloadData];
}


#pragma mark - 是否可以旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

- (BOOL)prefersStatusBarHidden {
    return [[UIApplication sharedApplication] isStatusBarHidden];
}

@end
