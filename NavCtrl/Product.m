//
//  Product.m
//  NavCtrl
//
//  Created by Pratap Pandit on 7/13/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"
#import "Company.h"
@implementation Product

//-(id)initWithName:(NSString*)name productURL:(NSString*)productURL productImageURL:(NSString*)productImageURL{
-(id)initWithName:(NSString*)name{
    
    self = [super init];
    
    if(self) {
        self.name = name;
//        self.productURL = productURL;
//        self.productImageURL = productImageURL;
        
    }
    
    return self;
}


@end
