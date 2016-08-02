//
//  WebKitViewController.h
//  NavCtrl
//
//  Created by Pratap Pandit on 7/12/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductEditingViewController;
@interface WebKitViewController : UIViewController

@property (retain, nonatomic) IBOutlet ProductEditingViewController *productEditingViewController;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* productURL;
@property (nonatomic, strong) NSString* productImageURL;


@end
