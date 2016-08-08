//
//  DataAccessObject.h
//  NavCtrl
//
//  Created by Pratap Pandit on 7/19/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"
#import "CompanyViewController.h"

@interface DataAccessObject : NSObject





@property (strong, nonatomic) NSMutableArray *companiesArray;
@property (strong, nonatomic) NSMutableArray *stockDataArray;
@property (nonatomic, retain) NSMutableArray * stockArray;



-(NSMutableArray*)createData;
+(DataAccessObject*)sharedDataAccessObject;
-(void)addCompany:(Company*)company;
-(NSMutableArray*)refreshData;
-(void)stockData;
-(NSMutableArray*)getStockDataArray;


@end
