//
//  DetailViewController.h
//  AppControl
//
//  Created by Jay on 16/5/17.
//  Copyright © 2016年 wonderland. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol DetailViewChangeDelegate <NSObject>
//
//@required
//- (void)shouldKillAppWithBool:(BOOL)kill;
//
//@end

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *hookApp;
@property (weak, nonatomic) IBOutlet UISwitch *killAppSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *blockIpSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *tapSwitch;
@property (weak, nonatomic) IBOutlet UITextField *rebootAppTF;  //多少分钟后杀死程序
@property (weak, nonatomic) IBOutlet UITextField *killTF;  //多少分钟后重启程序
@property (weak, nonatomic) IBOutlet UISwitch *safeModel;

@property (strong, nonatomic) NSDictionary *appDetailDic; //应用信息

//@property (weak, nonatomic) id<DetailViewChangeDelegate> delegate;

- (IBAction)killSwitchChange:(UISwitch *)sender;
- (IBAction)blockIPSwitchChange:(UISwitch *)sender; //自动屏蔽域名
- (IBAction)tapSwitchChange:(UISwitch *)sender;     //自动全屏点击
- (IBAction)hookTheApp:(UISwitch *)sender;          //是否挂勾应用
- (IBAction)NotBlockForSafe:(UISwitch *)sender; //安全模式


@end

