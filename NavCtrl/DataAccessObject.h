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
#import <CoreData/CoreData.h>
#import "CompanyMO.h"

@interface DataAccessObject : NSObject






@property (strong, nonatomic) NSMutableArray<Company*> *companiesArray;
@property (strong, nonatomic) NSMutableArray *stockDataArray;
@property (nonatomic, retain) NSMutableArray * stockArray;
@property int pos;



-(NSMutableArray*)createData;
+(DataAccessObject*)sharedDataAccessObject;
-(void)refreshOrder:(NSMutableArray*)companiesArray;
-(void)addCompany:(Company*)company;
-(void)companyWasEdited:(Company*)company;
-(void)companyWasDeleted:(Company*)company;
-(void)addProduct:(Product*)product forCompany:(Company*)company;
-(void)productWasDeleted:(Product*)product;
-(void)productWasEdited:(Product*)product;
-(void)refreshData;
-(void)stockData;
-(NSMutableArray*)getStockDataArray;
-(BOOL)coreDataIsEmpty;


@end
