//
//  WebKitViewController.h
//  NavCtrl
//
//  Created by Pratap Pandit on 7/12/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "ProductEditViewController.h"

@interface WebKitViewController : UIViewController

@property (retain, nonatomic) ProductEditViewController *productEditViewController;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* productURL;
@property (nonatomic, strong) NSString* productImageURL;
@property (nonatomic, strong) NSIndexPath* productIndex;
@property (retain, nonatomic) Company* company;
@property (retain, nonatomic) Product* product;

-(void)editProduct;

@end
