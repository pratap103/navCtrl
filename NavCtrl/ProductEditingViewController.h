//
//  ProductEditingViewController.h
//  NavCtrl
//
//  Created by Pratap Pandit on 7/27/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"

@interface ProductEditingViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *productName;
@property (retain, nonatomic) IBOutlet UITextField *productURL;
@property (retain, nonatomic) IBOutlet UITextField *productImageURL;
@property (retain, nonatomic) Company* company;



-(void)cancelEdit;
-(void)saveEdit;

@end
