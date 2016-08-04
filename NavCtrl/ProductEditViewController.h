//
//  ProductEditViewController.h
//  NavCtrl
//
//  Created by Pratap Pandit on 8/3/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "Product.h"

@class ProductViewController;
@interface ProductEditViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *productName;
@property (retain, nonatomic) IBOutlet UITextField *productURL;
@property (retain, nonatomic) IBOutlet UITextField *productImageURL;

@property (retain, nonatomic) Company* company;
@property (retain, nonatomic) Product* product;
@property BOOL editingProduct;
@property (nonatomic, strong) NSIndexPath* productIndex;
@property (nonatomic, retain) ProductViewController * productViewController;



-(void)cancelEdit;
-(void)saveEdit;
//-(void)editExisting;

@end



