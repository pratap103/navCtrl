//
//  WebKitViewController.m
//  NavCtrl
//
//  Created by Pratap Pandit on 7/12/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "WebKitViewController.h"
#import "ProductViewController.h"
#import "ProductEditViewController.h"

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
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editProduct)];
    self.navigationItem.rightBarButtonItem = editButton;
    

}

-(void) viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    NSLog(@"%@", self.product.productURL);
    
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKWebView* webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        webView.navigationDelegate = self;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL* url = [NSURL URLWithString:self.product.productURL];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSURLRequest *nsrequest =[NSURLRequest requestWithURL:url];
            [webView loadRequest:nsrequest];
            [configuration release];
            
        }];
        
    [dataTask resume];
    [self.view addSubview:webView];
}

-(void) editProduct{
    
    self.productEditViewController = [[ProductEditViewController alloc] initWithNibName:@"ProductEditViewController" bundle:nil];
    self.productEditViewController.company = self.company;
    self.productEditViewController.product = self.product;
    self.productEditViewController.productIndex= self.productIndex;
    self.productEditViewController.editingProduct = YES;
    self.productEditViewController.productName.text = self.product.name;
    self.productEditViewController.productURL.text = self.product.productURL;
    self.productEditViewController.productImageURL.text = self.product.productImageURL;
    
    [self.navigationController
     pushViewController:self.productEditViewController
     animated:YES];
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
