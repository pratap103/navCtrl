//
//  EditingViewController.h
//  NavCtrl
//
//  Created by Pratap Pandit on 7/25/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CompanyViewController;
@interface EditingViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *companyName;
@property (retain, nonatomic) IBOutlet UITextField *stockSymbol;
@property (retain, nonatomic) IBOutlet UITextField *companyURL;

-(void)cancelEdit;
-(void)saveEdit;

@end
