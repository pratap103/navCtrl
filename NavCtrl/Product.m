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
        _name = [name retain];
        _productURL = [productURL retain];                           //self.productURL = productURL
        _productImageURL = [productImageURL retain];
       
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString * imageName = [NSString stringWithFormat:@"%@.png", self.name ];
        NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
//        NSLog(@"%@", imagePath);
        
        if ([fileManager fileExistsAtPath:imagePath] == NO) {
            
            
            NSURL *url = [NSURL URLWithString:self.productImageURL];
            
            // 2
            NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]
                                                           downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                               NSError *err = nil;
                                                               if ([fileManager fileExistsAtPath:imagePath] == NO) {
//                                                                   NSLog(@"ABSOLUTE STRING: %@", location.path);
                                                                   [fileManager copyItemAtPath:[location path] toPath:imagePath error:&err];
                                                                   if (err) {
                                                                       NSLog(@"%@", err.localizedDescription);
                                                                   }
                                                               }
                                                               
                                                                                                                         }];
            // 4
            [downloadPhotoTask resume];

      
        
        
        
        
        
        
        
        }

        
    }
    
    return self;
}


@end
