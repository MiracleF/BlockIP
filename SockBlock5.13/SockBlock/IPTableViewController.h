//
//  IPTableViewController.h
//  SockBlock
//
//  Created by Jay on 16/5/13.
//
//

#import <UIKit/UIKit.h>

@interface IPTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

+ (IPTableViewController *)shareInstance;

@property (strong, nonatomic) UITableView *tableView;



@end
