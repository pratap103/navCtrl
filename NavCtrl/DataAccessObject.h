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

@interface DataAccessObject : NSObject

@property (strong, nonatomic) NSMutableArray *companiesArray;

-(NSMutableArray*)createData;

@end
