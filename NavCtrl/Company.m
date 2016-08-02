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
        
        
        if (self.logoImage == nil) {
            
       
        
            NSURLSession * session = [NSURLSession sharedSession];
            NSURL * url = [NSURL URLWithString:URL];
            NSURLSessionDataTask * dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                               {
        
                                                   self.logoImage = [UIImage imageWithData: data];
                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                       

                                                   });
        
        
        
                                               }];
        
        
        
        
            [dataTask resume];         //Asychronous method
        
       
        
        }
        
    }
    
    return self;
}




@end
