//
//  LogView.m
//  PiQu
//
//  Created by kaix on 15-3-16.
//  Copyright (c) 2015年 Jagie. All rights reserved.
//

#import "LogView.h"
#define Char_To_NSString(s) [NSString stringWithCString:s encoding:NSUTF8StringEncoding]

#define NSString_To_Char(s) [s UTF8String]

//
//#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
//
//#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)



#define SCREEN_Scale [UIScreen mainScreen].scale

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width ) //* SCREEN_Scale

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height) // * SCREEN_Scale

#define kSCREEN_WIDTH [GameInfo instance].screen_width
#define kSCREEN_HEIGHT [GameInfo instance].screen_height

#define kSCREEN_WIDTH_Scale kSCREEN_WIDTH * SCREEN_Scale
#define kSCREEN_HEIGHT_Scale kSCREEN_HEIGHT * SCREEN_Scale

#define StringFormat(string,...) [NSString stringWithFormat:string, ##__VA_ARGS__]


#define logView(string,...) [[LogView instance]log:string, ##__VA_ARGS__]


#define Char_To_NSString(s) [NSString stringWithCString:s encoding:NSUTF8StringEncoding]

#define NSString_To_Char(s) [s UTF8String]

#define IsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IOS_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define IOS_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IOS_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IOS_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


static CGFloat const kMALoggingViewDefaultFontSize = 14;
static CGFloat const kMALoggingViewMinFontSize = 10;
static CGFloat const kMALoggingViewMaxFontSize = 25;

static NSString * const kMALoggingViewDefaultFont = @"Courier-Bold";
static LogView*instance=nil;


@implementation LogView

+(LogView*)instance
{
    if (!instance) {
        instance=[[LogView alloc]init];
    }
    return instance;
}

- (instancetype)init
{
    
    if (self = [super init])
    {
              
        if (IsPad )
        {
            self.frame=CGRectMake(0, 20,380, 610);
            _currentFontSize = kMALoggingViewDefaultFontSize;
        }
        else
        {
            self.frame=CGRectMake(0, 20,280, 310);
            
            _currentFontSize = kMALoggingViewMinFontSize;
            
        }
        
        
//        B051CB7A11884AF4ADD13ACE4BE2D87F
        
        // generate the view, add it to the frame, make it resize according
        // to rotation, disable editing, make it look pretty, and add it as a subview
        _textView = [[UITextView alloc] initWithFrame:self.frame];
        _textView.backgroundColor = [UIColor blueColor];
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth + UIViewAutoresizingFlexibleHeight;
        _textView.editable = NO;
        _textView.font = [UIFont fontWithName:kMALoggingViewDefaultFont size:_currentFontSize];
        _textView.textColor = [UIColor whiteColor];
        [self addSubview:_textView];
        

        
        //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Shrink Font" style:UIBarButtonItemStylePlain target:self action:@selector(decreaseFontSize)];
        //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Grow Font" style:UIBarButtonItemStylePlain target:self action:@selector(increaseFontSize)];
        
        
    }
    
    return self;
}
- (void)log:(NSString *)format, ... {
    // if we weren't provided any data, bail
    if (!format) {
        return;
    }
    
//    [[WinButton instance]showSetting];
    
    // get the format and the args
    va_list args, args_copy;
    va_start(args, format);
    va_copy(args_copy, args);
    va_end(args);
    
    // create the log text from the format and args
    NSString *logText = [[NSString alloc] initWithFormat:format arguments:args_copy];
    
    // get the timestamp
//    NSDate *now = [NSDate date];
//    NSDateFormatter *formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
//    NSString *dateString = [formatter stringFromDate:now];
    
    // make sure any UI stuff is done on the main thread!
    dispatch_async(dispatch_get_main_queue(), ^{
        // append the timestamp and log text just like NSLog would
        //        _textView.text = [_textView.text stringByAppendingFormat:@"%@ %@\n", dateString, logText];
        _textView.text = [_textView.text stringByAppendingFormat:@"%@ \n \n", logText];
        
        // scroll the view down
        [self scrollToBottom];
    });
    
    // log the text to the console normally
    NSLog(@"%@", logText);
    
    va_end(args_copy);
}

- (void)scrollToBottom {
    // TODO: find a less hacky way of scrolling to the bottom
    [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 0)];
//    [_textView setScrollEnabled:NO];
    [_textView setScrollEnabled:YES];
}



-(void)clear
{
    _textView.text=@"";
}

#pragma mark - Navigation button actions

- (void)increaseFontSize {
    // increase the font size as long as we're not at the max
    if (_currentFontSize >= kMALoggingViewMaxFontSize) {
        return;
    }
    
    _currentFontSize++;
    _textView.font = [UIFont fontWithName:kMALoggingViewDefaultFont size:_currentFontSize];
}

- (void)decreaseFontSize {
    // decrease the font size as long as we're not at the min
    if (_currentFontSize <= kMALoggingViewMinFontSize) {
        return;
    }
    
    _currentFontSize--;
    _textView.font = [UIFont fontWithName:kMALoggingViewDefaultFont size:_currentFontSize];
}


 

@end
