//
//  Company.h
//  NavCtrl
//
//  Created by Pratap Pandit on 7/13/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import <CoreData/CoreData.h>

@interface Company : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) NSString *myURL;
@property (nonatomic, strong) NSString *stockSymbol;
@property (nonatomic, strong) NSString *stockPrice;
@property NSInteger position;




-(id)initWithName:(NSString*)name stockSymbol:(NSString*)stockSymbol imageURL:(NSString*)URL;


@end

