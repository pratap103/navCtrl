//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Pratap Pandit on 7/19/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"
#import "Product.h"
#import "Company.h"

@implementation DataAccessObject
static DataAccessObject* _sharedDataAccessObject = nil;


-(NSMutableArray*)createData{
    
    Company *companyApple = [[Company alloc] initWithName:@"Apple mobile devices"];
    Product *iPad = [[Product alloc] initWithName:@"iPad" ];
    Product *iPodTouch = [[Product alloc] initWithName:@"iPod Touch" ];             //apple products
    Product *iPhone = [[Product alloc] initWithName:@"iPhone"];
    companyApple.products = [NSMutableArray arrayWithObjects:iPad, iPodTouch, iPhone, nil];
    
    Company *companySamsung = [[Company alloc] initWithName:@"Samsung mobile devices"];
    Product *galaxyS7 = [[Product alloc] initWithName:@"Galaxy S7" ];
    Product *galaxyNote = [[Product alloc] initWithName:@"Galaxy Note"];            //samsung products
    Product *galaxyTab = [[Product alloc] initWithName:@"Galaxy Tab"];
    companySamsung.products = [NSMutableArray arrayWithObjects:galaxyS7, galaxyNote, galaxyTab, nil];
    
    Company *companyBlackberry = [[Company alloc] initWithName:@"Blackberry mobile devices"];
    Product *classic = [[Product alloc] initWithName:@"Classic"];
    Product *leap = [[Product alloc] initWithName:@"Leap"];                         //blackberry products
    Product *passport = [[Product alloc] initWithName:@"Passport"];
    companyBlackberry.products =  [NSMutableArray arrayWithObjects:classic, leap, passport, nil];
    
    Company *companyNexus = [[Company alloc] initWithName:@"Nexus mobile devices"];
    Product *n5X = [[Product alloc] initWithName:@"5X"];
    Product *n6P = [[Product alloc] initWithName:@"6P"];                            //nexus products
    Product *n9 = [[Product alloc] initWithName:@"9"];
    companyNexus.products = [NSMutableArray arrayWithObjects:n5X, n6P, n9, nil];
    
    

    
    

    self.companiesArray = [NSMutableArray arrayWithObjects: companyApple, companySamsung, companyBlackberry, companyNexus, nil];
    
    return self.companiesArray;
}

+(DataAccessObject*)sharedDataAccessObject{
    
    
    @synchronized ([DataAccessObject class]) {
        if (!_sharedDataAccessObject)
            [[self alloc]init];
            
            return _sharedDataAccessObject;
        
        
        
    }
    return nil;
    
}

+(id) alloc{
    
    @synchronized([DataAccessObject class])
    {
//        NSAssert(_sharedDataAccessObject == nil, @"Attempted to allocate a second instance of a singleton.");     //Crashes app if an instance already exists.
        
//        NSLog(@"Tried to create another instance of a singleton");      //Prints to log instead
       
        _sharedDataAccessObject = [super alloc];
        return _sharedDataAccessObject;
    }
    
    return nil;
}

+(id) init{
    
    self = [super init];
    if (self != nil) {
       
    }
    
    return self;
    
    
    
}



@end
