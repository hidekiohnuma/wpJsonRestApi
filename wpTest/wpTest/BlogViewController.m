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
    // webveiwキャッシュオフ
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    
    if (!self.webView.isLoading) {
        // blog URL
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_blogName]];
                
        [request setHTTPMethod:@"GET"];
        request.timeoutInterval = 10;
        [_webView loadRequest:request];
    }
}

-(void)webViewDidStartLoad:(UIWebView *)_webView{
}
//webview読み込まれた後
- (void)webViewDidFinishLoad:(UIWebView *)_webView {
    NSString *css = @"div#text-5{visibility:hidden;}";
    
    NSMutableString *javascript = [NSMutableString string];
    [javascript appendString:@"var style = document.createElement('style');"];
    [javascript appendString:@"style.type = 'text/css';"];
    [javascript appendFormat:@"var cssContent = document.createTextNode('%@');", css];
    [javascript appendString:@"style.appendChild(cssContent);"];
    [javascript appendString:@"document.body.appendChild(style);"];
    
    [_webView stringByEvaluatingJavaScriptFromString:javascript];
}


@end
