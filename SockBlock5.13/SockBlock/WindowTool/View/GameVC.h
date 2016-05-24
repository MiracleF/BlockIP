//
//  GameVC.h
//  zhushou
//
//  Created by k on 15/5/6.
//
//

#import <UIKit/UIKit.h>

typedef void(^CloseB)(void);

@interface GameVC : UIViewController
@property(nonatomic,strong) CloseB closeb;
+(GameVC*)instance;
-(void)showAllTestView;
-(void)hiddeAllTestView;
-(void)gameEXIT:(void(^)(void))block;
@end


@interface GameNAV : UINavigationController
//+(SettingControllor*)instance;
@end