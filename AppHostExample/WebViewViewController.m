//
//  WebViewViewController.m
//  AppHostExample
//
//  Created by liang on 2019/4/16.
//  Copyright © 2019 liang. All rights reserved.
//

#import "WebViewViewController.h"
#import <BMBridgeDebug/BMBridgeDebug.h>

@interface WebViewViewController () <WKUIDelegate, WKNavigationDelegate,BMBridgeDebugCenterProtocol>
@property (nonatomic, strong) WKWebView* webView;
@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWebview];
    // Do any additional setup after loading the view.
}

-(void)initWebview{
    WKWebViewConfiguration *wkConfig = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:wkConfig];
    //使用单例 解决locastorge 储存问题
    
    [self.view insertSubview:_webView atIndex:0];
    _webView.frame = CGRectMake(0, 0, BD_SCREEN_WIDTH, BD_SCREEN_HEIGHT);
    _webView.UIDelegate = self;
    _webView.scrollView.bounces = NO;
    _webView.navigationDelegate = self;
    [_webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    self.bridgeCenter = [BMBridgeCenter new];
    self.bridgeCenter.vc = self;
    self.bridgeCenter.webView = _webView;
    [self.bridgeCenter injectScriptsToUserContent:_webView.configuration.userContentController];


}
@synthesize bridgeCenter;

@end
