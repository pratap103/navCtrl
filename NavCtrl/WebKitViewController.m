//
//  WebKitViewController.m
//  NavCtrl
//
//  Created by Pratap Pandit on 7/12/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "WebKitViewController.h"
#import "ProductViewController.h"

@import WebKit;


@interface WebKitViewController () <WKNavigationDelegate>

@end

@implementation WebKitViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Uncomment the following line to preserve selection between presentations.
//    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

}

-(void) viewWillAppear:(BOOL)animated{
    
   
    
    [super viewWillAppear:animated];
    
    
    if ([self.title isEqualToString:@"iPad" ]) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        webView.navigationDelegate = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:@"http://www.apple.com/ipad/"];

        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSURLRequest *nsrequest =[NSURLRequest requestWithURL:url];
            [webView loadRequest:nsrequest];
            
            
        }];
        
        [dataTask resume];
        [self.view addSubview:webView];
    }
    
    if ([self.title isEqualToString:@"iPod Touch" ]) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        webView.navigationDelegate = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:@"http://www.apple.com/ipod-touch/"];
        
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSURLRequest *nsrequest =[NSURLRequest requestWithURL:url];
            [webView loadRequest:nsrequest];
            
            
        }];
        
        [dataTask resume];
        [self.view addSubview:webView];
    }
    
    if ([self.title isEqualToString:@"iPhone" ]) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        webView.navigationDelegate = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:@"http://www.apple.com/iphone/"];
        
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSURLRequest *nsrequest =[NSURLRequest requestWithURL:url];
            [webView loadRequest:nsrequest];
            
            
        }];
        
        [dataTask resume];
        [self.view addSubview:webView];
    }
    
    if ([self.title isEqualToString:@"Galaxy Tab" ]) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        webView.navigationDelegate = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:@"http://www.samsung.com/us/mobile/galaxy-tab/"];
        
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSURLRequest *nsrequest =[NSURLRequest requestWithURL:url];
            [webView loadRequest:nsrequest];
            
            
        }];
        
        [dataTask resume];
        [self.view addSubview:webView];
    }

    if ([self.title isEqualToString:@"Galaxy Note" ]) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        webView.navigationDelegate = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:@"http://www.samsung.com/us/mobile/galaxy-note/"];
        
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSURLRequest *nsrequest =[NSURLRequest requestWithURL:url];
            [webView loadRequest:nsrequest];
            
            
        }];
        
        [dataTask resume];
        [self.view addSubview:webView];
    }
    
    if ([self.title isEqualToString:@"Galaxy S7" ]) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        webView.navigationDelegate = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:@"http://www.samsung.com/us/explore/galaxy-s7-features-and-specs/"];
        
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSURLRequest *nsrequest =[NSURLRequest requestWithURL:url];
            [webView loadRequest:nsrequest];
            
            
        }];
        
        [dataTask resume];
        [self.view addSubview:webView];
    }

    if ([self.title isEqualToString:@"Classic" ]) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        webView.navigationDelegate = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:@"http://us.blackberry.com/smartphones/blackberry-classic/overview.html"];
        
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSURLRequest *nsrequest =[NSURLRequest requestWithURL:url];
            [webView loadRequest:nsrequest];
            
            
        }];
        
        [dataTask resume];
        [self.view addSubview:webView];
    }
    
    if ([self.title isEqualToString:@"Leap" ]) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        webView.navigationDelegate = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:@"http://us.blackberry.com/smartphones/blackberry-leap/overview.html"];
        
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSURLRequest *nsrequest =[NSURLRequest requestWithURL:url];
            [webView loadRequest:nsrequest];
            
            
        }];
        
        [dataTask resume];
        [self.view addSubview:webView];
    }
    
    if ([self.title isEqualToString:@"Passport" ]) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        webView.navigationDelegate = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:@"http://us.blackberry.com/smartphones/blackberry-passport/overview.html"];
        
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSURLRequest *nsrequest =[NSURLRequest requestWithURL:url];
            [webView loadRequest:nsrequest];
            
            
        }];
        
        [dataTask resume];
        [self.view addSubview:webView];
    }

    if ([self.title isEqualToString:@"5X" ]) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        webView.navigationDelegate = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:@"https://www.google.com/nexus/5x/"];
        
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSURLRequest *nsrequest =[NSURLRequest requestWithURL:url];
            [webView loadRequest:nsrequest];
            
            
        }];
        
        [dataTask resume];
        [self.view addSubview:webView];
    }
    
    if ([self.title isEqualToString:@"6P" ]) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        webView.navigationDelegate = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:@"https://store.google.com/product/nexus_6p"];
        
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSURLRequest *nsrequest =[NSURLRequest requestWithURL:url];
            [webView loadRequest:nsrequest];
            
            
        }];
        
        [dataTask resume];
        [self.view addSubview:webView];
    }

    if ([self.title isEqualToString:@"9" ]) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        webView.navigationDelegate = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:@"https://www.google.com/nexus/9/"];
        
        
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSURLRequest *nsrequest =[NSURLRequest requestWithURL:url];
            [webView loadRequest:nsrequest];
            
            
        }];
        
        [dataTask resume];
        [self.view addSubview:webView];
    }


    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
