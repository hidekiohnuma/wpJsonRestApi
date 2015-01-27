//
//  BlogViewController.m
//  wpTest
//
//  Created by 大沼英喜 on 2015/01/27.
//  Copyright (c) 2015年 大沼英喜. All rights reserved.
//

#import "BlogViewController.h"

@interface BlogViewController ()

@end


@implementation BlogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.webView.isLoading) {
        // blog URL
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_blogName]];
        
        [request setHTTPMethod:@"GET"];
        request.timeoutInterval = 20;
        [_webView loadRequest:request];
    }
}

@end
