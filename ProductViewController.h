//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebKitViewController;

@interface ProductViewController : UITableViewController



@property (nonatomic, retain) NSMutableArray *appleProducts;

@property (nonatomic, retain) NSMutableArray *samsungProducts;

@property (nonatomic, retain) NSMutableArray *blackberryProducts;

@property (nonatomic, retain) NSMutableArray *nexusProducts;


@property (retain, nonatomic) IBOutlet WebKitViewController *webKitViewController;


@end
