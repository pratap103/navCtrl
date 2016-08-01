//
//  Company.m
//  NavCtrl
//
//  Created by Pratap Pandit on 7/13/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"


@implementation Company


-(id)initWithName:(NSString*)name stockSymbol:(NSString*)stockSymbol imageURL:(NSString*)URL{
    
    
    self = [super init];
    
    if(self) {
        self.name = name;
        self.stockSymbol = stockSymbol;
        self.myURL = URL;
        NSURL *myURL = [NSURL URLWithString:URL];
        NSData *data = [NSData dataWithContentsOfURL : myURL];
        self.logoImage = [UIImage imageWithData: data];
        
        
        

        
    }
    
    return self;
}




@end
