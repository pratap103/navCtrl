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
-(id)initWithName:(NSString*)name productURL:(NSString*)productURL productImageURL:(NSString*)productImageURL{
    
    self = [super init];
    
    if(self) {
        self.name = name;
        self.productURL = productURL;
        self.productImageURL = productImageURL;
        
        
        if (self.productImage == nil) {
            
        
        
        NSURLSession * session = [NSURLSession sharedSession];
        NSURL * url = [NSURL URLWithString:productImageURL];
        NSURLSessionDataTask * dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                           {
                                               
                                               
                                               self.productImage = [UIImage imageWithData: data];
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                                               });
                                               
                                               
                                               
                                           }];
        
        
        
        
        [dataTask resume];         //Asychronous method
        
        }

        
    }
    
    return self;
}


@end
