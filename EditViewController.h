//
//  EditViewController.h
//  NavCtrl
//
//  Created by Pratap Pandit on 8/3/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"

@interface EditViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *companyName;
@property (retain, nonatomic) IBOutlet UITextField *stockSymbol;
@property (retain, nonatomic) IBOutlet UITextField *companyURL;
@property BOOL editingCompany;
@property (retain, nonatomic) Company* company;

-(void)cancelEdit;
-(void)saveEdit;

@end
