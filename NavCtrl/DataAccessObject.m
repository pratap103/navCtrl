//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Pratap Pandit on 7/19/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductEditViewController.h"
#import "ProductViewController.h"
#import "DataAccessObject.h"
#import "Product.h"
#import "Company.h"

@implementation DataAccessObject
static DataAccessObject* _sharedDataAccessObject = nil;




-(NSMutableArray*)createData{
    
    Company *companyApple = [[Company alloc] initWithName:@"Apple mobile devices" stockSymbol:@"AAPL" imageURL:@"http://thebrainfever.com/images/apple-logos/Silhouette.png"];
    Product *iPad = [[Product alloc] initWithName:@"iPad" productURL:@"http://www.apple.com/ipad/" productImageURL:@"https://support.apple.com/content/dam/edam/applecare/images/en_US/ipad/featured-content-ipad-icon_2x.png"];
    Product *iPodTouch = [[Product alloc] initWithName:@"iPod Touch" productURL:@"http://www.apple.com/ipod/" productImageURL:@"http://store.storeimages.cdn-apple.com/4973/as-images.apple.com/is/image/AppleInc/aos/published/images/i/po/ipod/touch/ipod-touch-product-initial-2015?wid=900&hei=900&fmt=png-alpha&qlt=80&.v=O4ykj1" ];             //apple products
    Product *iPhone = [[Product alloc] initWithName:@"iPhone" productURL:@"http://www.apple.com/iphone/" productImageURL:@"https://support.apple.com/content/dam/edam/applecare/images/en_US/iphone/featured-content-iphone-transfer-content-icon_2x.png"];
    companyApple.products = [NSMutableArray arrayWithObjects:iPad, iPodTouch, iPhone, nil];
    
    Company *companySamsung = [[Company alloc] initWithName:@"Samsung mobile devices" stockSymbol:@"SSNLF" imageURL:@"http://www.brandsoftheworld.com/sites/default/files/styles/logo-thumbnail/public/0019/9958/brand.gif?itok=_aI8_zLB"];
    Product *galaxyS7 = [[Product alloc] initWithName:@"Galaxy S7" productURL:@"http://www.samsung.com/us/mobile/galaxy-tab/" productImageURL:@"http://www.samsung.com/us/explore/galaxy-s7-features-and-specs/dist/assets/img/module1/desktop/intro.jpg"];
    Product *galaxyNote = [[Product alloc] initWithName:@"Galaxy Note" productURL:@"http://www.samsung.com/us/mobile/galaxy-note/" productImageURL:@"http://www.samsung.com/global/galaxy/galaxy-note5/images/galaxy-note5_gallery_right-perspective_pinkgold_s3.png"];            //samsung products
    Product *galaxyTab = [[Product alloc] initWithName:@"Galaxy Tab" productURL:@"http://www.samsung.com/us/explore/galaxy-s7-features-and-specs/" productImageURL:@"http://www.samsung.com/global/galaxy/galaxy-tab-s2/images/galaxy-tab-s2_gallery_front_black.png"];
    companySamsung.products = [NSMutableArray arrayWithObjects:galaxyS7, galaxyNote, galaxyTab, nil];
    
    Company *companyBlackberry = [[Company alloc] initWithName:@"Blackberry mobile devices" stockSymbol:@"BBRY" imageURL: @"http://dolphinradio.org/wp-content/uploads/2014/07/BlackBerry-Logo.png"];
    Product *classic = [[Product alloc] initWithName:@"Classic" productURL:@"http://us.blackberry.com/smartphones/blackberry-classic/overview.html" productImageURL:@"http://us.blackberry.com/content/dam/blackberry-com/images/smartphones/2016_Classic_Overview/classic-colour-variations_black.png"];
    Product *leap = [[Product alloc] initWithName:@"Leap" productURL:@"http://us.blackberry.com/smartphones/blackberry-leap/overview.html" productImageURL:@"https://crackberry.com/sites/crackberry.com/files/styles/large/public/article_images/2015/03/blackberry-leap-back-hand-hero.jpg?itok=zpPbqOvJ"];                         //blackberry products
    Product *passport = [[Product alloc] initWithName:@"Passport" productURL:@"http://us.blackberry.com/smartphones/blackberry-passport/overview.html" productImageURL:@"http://us.blackberry.com/content/dam/blackberry-com/images/smartphones/2016_Passport_Overview/passport-colours-silver.png/jcr:content/renditions/original"];
    companyBlackberry.products =  [NSMutableArray arrayWithObjects:classic, leap, passport, nil];
    
    Company *companyNexus = [[Company alloc] initWithName:@"Nexus mobile devices" stockSymbol:@"GOOG" imageURL:@"https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/X_from_Nexus_logo.svg/120px-X_from_Nexus_logo.svg.png"];
    Product *n5X = [[Product alloc] initWithName:@"5X" productURL:@"https://www.google.com/nexus/5x/" productImageURL:@"https://lh3.googleusercontent.com/P1_mBNk543linbcL0AtazL5Kr9Te0v7egH-uxhWoddVuSFeH-jfAt9dYB4ELnElYNw"];
    Product *n6P = [[Product alloc] initWithName:@"6P" productURL:@"https://store.google.com/product/nexus_6p" productImageURL:@"https://lh3.googleusercontent.com/IW5kkESaYgPvqetsNKtwq_0HZdVJRjWwC5BXeAi_1zPoFmXD8PmkmK7jDH_ZDgaytSqo"];                            //nexus products
    Product *n9 = [[Product alloc] initWithName:@"9" productURL:@"https://www.google.com/nexus/9/" productImageURL:@"http://cdn.arstechnica.net/wp-content/uploads/2014/10/nexus9-640x470.jpg"];
    companyNexus.products = [NSMutableArray arrayWithObjects:n5X, n6P, n9, nil];
    
    
    

    
    

    self.companiesArray = [NSMutableArray arrayWithObjects: companyApple, companySamsung, companyBlackberry, companyNexus, nil];

    return self.companiesArray;
}





+(DataAccessObject*)sharedDataAccessObject{
    
    
    @synchronized ([DataAccessObject class]) {
        if (!_sharedDataAccessObject)
            _sharedDataAccessObject = [[DataAccessObject alloc]init];
//            [_sharedDataAccessObject createData];
        
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

-(void)addCompany:(Company*)company{
    
    [self.companiesArray addObject:company];
    
//    NSLog(@"%@", self.companiesArray);
//
}








-(NSMutableArray*)refreshData{
    

    return self.companiesArray;
}



@end
