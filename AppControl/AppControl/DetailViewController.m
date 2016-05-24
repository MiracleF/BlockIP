//
//  DetailViewController.m
//  AppControl
//
//  Created by Jay on 16/5/17.
//  Copyright © 2016年 wonderland. All rights reserved.
//

#import "DetailViewController.h"
#import "GetAppManager.h"
#import "Header.h"

@interface DetailViewController () <UITextFieldDelegate>

@property (strong, nonatomic) NSMutableDictionary *myNewDic;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    [self addObserver:self forKeyPath:@"appDetailDic" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
    
    [self resetView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetView {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (_appDetailDic[kShouldKillApp]) {
            
            if ([_appDetailDic[kShouldKillApp] boolValue]) {
                
                [_killAppSwitch setOn:YES animated:NO];
                
            } else {
                
                [_killAppSwitch setOn:NO animated:NO];
                
            }
            
        } else {
            
            [_killAppSwitch setOn:NO animated:NO];
        }
        
        
        if (_appDetailDic[kRebootAppTime]) {
            
            _rebootAppTF.text = _appDetailDic[kRebootAppTime];
            
        } else {
            
            _rebootAppTF.text = @"";
        }
        
        
        if (_appDetailDic[kKillTime]) {
            
            _killTF.text = _appDetailDic[kKillTime];
            
        } else {
            
            _killTF.text = @"";
        }
        
        
        if (_appDetailDic[kShouldBlockIP]) {
            
            if ([_appDetailDic[kShouldBlockIP] boolValue]) {
                
                [_blockIpSwitch setOn:YES animated:NO];
                
            } else {
                
                [_blockIpSwitch setOn:NO animated:NO];
                
            }
            
        } else {
            
            [_blockIpSwitch setOn:NO animated:NO];
        }
        
        
        if (_appDetailDic[kShouldTap]) {
            
            if ([_appDetailDic[kShouldTap] boolValue]) {
                
                [_tapSwitch setOn:YES animated:NO];
                
            } else {
                
                [_tapSwitch setOn:NO animated:NO];
                
            }
            
        } else {
            
            [_tapSwitch setOn:NO animated:NO];
        }
        
        
        if (_appDetailDic[kSafeMode]) {
            
            if ([_appDetailDic[kSafeMode] boolValue]) {
                
                [_safeModel setOn:YES animated:NO];
                
            } else {
                
                [_safeModel setOn:NO animated:NO];
                
            }
            
        } else {
            
            [_safeModel setOn:NO animated:NO];
        }
        
        NSString *filePath = @"/Library/MobileSubstrate/DynamicLibraries/SockBlock.plist";
        
        NSDictionary *rootDic = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        
        NSArray *Bundles = rootDic[@"Filter"][@"Bundles"];
        
        for (NSString *bundleID in Bundles) {
            
            if ([bundleID isEqualToString:_appDetailDic[kBID]]) {
                
                [_hookApp setOn:YES animated:NO];
                
                break;
            }
        }
        
        _myNewDic = [[NSMutableDictionary alloc] initWithDictionary:_appDetailDic];
        
    });
}

- (IBAction)killSwitchChange:(UISwitch *)sender {

//    [_delegate shouldKillAppWithBool:sender.isOn];

    [_myNewDic setValue:[NSNumber numberWithBool:sender.isOn] forKey:kShouldKillApp];
    
    if (sender.isOn) {
        
        if ([_rebootAppTF.text isEqualToString:@""]) {
            
            [_myNewDic setValue:_rebootAppTF.placeholder forKey:kRebootAppTime];
            
        } else {
            
            [_myNewDic setValue:_rebootAppTF.text forKey:kRebootAppTime];
        }
        
        if ([_killTF.text isEqualToString:@""]) {
            
            [_myNewDic setValue:_killTF.placeholder forKey:kKillTime];
            
        } else {
            
            [_myNewDic setValue:_killTF.text forKey:kKillTime];
        }
    }
    
    [[GetAppManager shareInstance] updataOneAppDataWithDic:_myNewDic];
}

- (IBAction)blockIPSwitchChange:(UISwitch *)sender {
    
    [_myNewDic setValue:[NSNumber numberWithBool:sender.isOn] forKey:kShouldBlockIP];
    
    [[GetAppManager shareInstance] updataOneAppDataWithDic:_myNewDic];
}

- (IBAction)tapSwitchChange:(UISwitch *)sender {

    [_myNewDic setValue:[NSNumber numberWithBool:sender.isOn] forKey:kShouldTap];
    
    [[GetAppManager shareInstance] updataOneAppDataWithDic:_myNewDic];
}

- (IBAction)hookTheApp:(UISwitch *)sender {
    
    NSString *filePath = @"/Library/MobileSubstrate/DynamicLibraries/SockBlock.plist";
    
    NSDictionary *rootDic = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    
    NSArray *Bundles = rootDic[@"Filter"][@"Bundles"];
    
    NSMutableArray *mutableBundles = [[NSMutableArray alloc] initWithArray:Bundles];
    
    NSString *appBID = _myNewDic[kBID];
    
    if (sender.isOn) {
        
        [mutableBundles addObject:appBID];
        
    } else {
        
        for (int i = 0 ; i < [mutableBundles count]; i ++) {
            
            if ([appBID isEqualToString:mutableBundles[i]]) {
                
                [mutableBundles removeObjectAtIndex:i];
                
                
                
                break;
            }
        }
    }
    
    NSDictionary *filter = [[NSDictionary alloc] initWithObjectsAndKeys:mutableBundles, @"Bundles", nil];
    
    NSDictionary *root = [[NSDictionary alloc] initWithObjectsAndKeys:filter, @"Filter", nil];
    
    [root writeToFile:filePath atomically:YES];
}

- (IBAction)NotBlockForSafe:(UISwitch *)sender {
    
    [_myNewDic setValue:[NSNumber numberWithBool:sender.isOn] forKey:kSafeMode];
    
    [[GetAppManager shareInstance] updataOneAppDataWithDic:_myNewDic];
}


#pragma mark - textfield delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([_rebootAppTF.text isEqualToString:@""]) {
        
        [_myNewDic setValue:_rebootAppTF.placeholder forKey:kRebootAppTime];
        
    } else {
        
        [_myNewDic setValue:_rebootAppTF.text forKey:kRebootAppTime];
    }
    
    if ([_killTF.text isEqualToString:@""]) {
        
        [_myNewDic setValue:_killTF.placeholder forKey:kKillTime];
        
    } else {
        
        [_myNewDic setValue:_killTF.text forKey:kKillTime];
    }
    
    [[GetAppManager shareInstance] updataOneAppDataWithDic:_myNewDic];
}




@end
