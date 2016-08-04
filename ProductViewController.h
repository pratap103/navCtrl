//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "EditViewController.h"

@class WebKitViewController;
@class ProductEditViewController;

@interface ProductViewController : UITableViewController

@property (nonatomic, retain) Company * company;

@property (retain, nonatomic) IBOutlet WebKitViewController *webKitViewController;
@property (retain, nonatomic) ProductEditViewController *productEditViewController;
@property (nonatomic, retain) NSString * documentsDirectory;

-(void)backToProducts;


@end
