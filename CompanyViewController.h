//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccessObject.h"
#import "Company.h"

@class ProductViewController;
@class EditingViewController;

@interface CompanyViewController : UITableViewController

//@property (nonatomic, retain) NSMutableArray *companyList;


@property (nonatomic, retain) IBOutlet  ProductViewController * productViewController;
@property (nonatomic, retain) IBOutlet EditingViewController * editingViewController;


-(void)insertNewObject;

@end
