//
//  Product.h
//  NavCtrl
//
//  Created by Pratap Pandit on 7/13/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"

@interface Product : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *productURL;
//@property (nonatomic, strong) Company *company;



-(id)initWithName:(NSString*)name;


@end