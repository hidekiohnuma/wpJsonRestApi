//
//  BlogViewController.h
//  wpTest
//
//  Created by 大沼英喜 on 2015/01/27.
//  Copyright (c) 2015年 大沼英喜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlogViewController : UIViewController

@property NSString *blogName;
@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end
