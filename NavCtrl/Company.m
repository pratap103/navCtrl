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
        _name = [name retain];
        _stockSymbol = [stockSymbol retain];
        _myURL = [URL retain];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString * imageName = [NSString stringWithFormat:@"%@.png", self.name ];
        NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];

        
        if ([fileManager fileExistsAtPath:imagePath] == YES) {
            
        }
        
        if ([fileManager fileExistsAtPath:imagePath] == NO) {
            
            
            
            NSURL *url = [NSURL URLWithString:self.myURL];
            
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
