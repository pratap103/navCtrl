//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Pratap Pandit on 7/19/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "NavControllerAppDelegate.h"
#import "CompanyViewController.h"
#import "ProductEditViewController.h"
#import "ProductViewController.h"
#import "DataAccessObject.h"
#import "Product.h"
#import "Company.h"
#import <CoreData/CoreData.h>
#import "CompanyMO.h"
#import "ProductMO.h"




@interface DataAccessObject ()

@property(nonatomic, retain) NSMutableArray *managedCompaniesArray;

@end


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
    
    
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = appDelegate.managedObjectContext;
    
    
    
    NSError *mocSaveError = nil;
    
    if (![moc save:&mocSaveError])
    {
        NSLog(@"Save did not complete successfully. Error: %@",
              [mocSaveError localizedDescription]);
    }

    
    
    self.pos = 0;
    self.companiesArray = [NSMutableArray arrayWithObjects: companyApple, companySamsung, companyBlackberry, companyNexus, nil];
    [companyApple release];
    [companySamsung release];
    [companyBlackberry release];
    [companyNexus release];
    
    
    for(Company *company in self.companiesArray){
        NSNumber *y = [NSNumber numberWithInteger:self.pos];
        CompanyMO *newCompany = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyMO" inManagedObjectContext:moc];
        [newCompany setName:company.name];
        [newCompany setStockSymbol:company.stockSymbol];
        [newCompany setMyURL:company.myURL];
        [newCompany setPosition:y];
        self.pos++;
        
        
        
        for(Product *product in company.products){
            ProductMO *newProduct = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:moc];
            [newProduct setName:product.name];
            [newProduct setProductURL:product.productURL];
            [newProduct setProductImageURL:product.productImageURL];
            [newProduct setCompany:newCompany];
        }
        
        [moc save:NULL];   
        
    }
    
    
    return self.companiesArray;
}





+(DataAccessObject*)sharedDataAccessObject{
    
    
    @synchronized ([DataAccessObject class]) {
        if (!_sharedDataAccessObject)
            _sharedDataAccessObject = [[DataAccessObject alloc]init];

        
            return _sharedDataAccessObject;
        
        
        
    }
    return nil;
    
}

+(id) alloc{
    
    @synchronized([DataAccessObject class])
    {
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
    
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = appDelegate.managedObjectContext;

    [self.companiesArray addObject:company];
        
    NSInteger x = [self.companiesArray indexOfObject:company];
    
    NSNumber *y = [NSNumber numberWithInteger:x];
    CompanyMO *newCompany = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyMO" inManagedObjectContext:moc];
    [newCompany setName:company.name];
    [newCompany setStockSymbol:company.stockSymbol];
    [newCompany setMyURL:company.myURL];
    [newCompany setPosition:y];
   

}

-(void)companyWasEdited:(Company*)company{
    
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = appDelegate.managedObjectContext;
    

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"CompanyMO" inManagedObjectContext:moc]];
   
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", company.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    CompanyMO *editedCompany = [results objectAtIndex:0];
    editedCompany.name = company.name;
    editedCompany.stockSymbol = company.stockSymbol;
    editedCompany.myURL = company.myURL;
    
    
}

-(void)companyWasDeleted:(Company*)company{
    
    [self.companiesArray removeObject:company];
    
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"CompanyMO" inManagedObjectContext:moc]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", company.name];
    [request setPredicate:predicate];

    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    [moc deleteObject:[results objectAtIndex:0]];
    [request release];
   
    
    
}

-(void)addProduct:(Product*)product forCompany:(Company*)company{
    
    
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"CompanyMO" inManagedObjectContext:moc]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", company.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    ProductMO *newProduct = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:moc];
    [newProduct setName:product.name];
    [newProduct setProductURL:product.productURL];
    [newProduct setProductImageURL:product.productImageURL];
    [newProduct setCompany:[results objectAtIndex:0]];
    [moc save:NULL];
    
    

    
}

-(void)productWasDeleted:(Product*)product{
    
    
    
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"ProductMO" inManagedObjectContext:moc]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", product.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    [moc deleteObject:[results objectAtIndex:0]];
    [moc save:NULL];
    
    
    
}

-(void)productWasEdited:(Product *)product{
    
    
    
    
}

-(void)stockData{
    
    self.stockArray = [[NSMutableArray alloc] init];
    self.stockDataArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.companiesArray.count; i++) {
        self.stockArray[i] = [[self.companiesArray objectAtIndex:i] stockSymbol];
    }

    NSString * stockString = [self.stockArray componentsJoinedByString:@","];
    [self.stockArray release];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=sl1d1t1c1ohgv&e=.csv",stockString]];
    NSURLSessionDownloadTask *downloadStockData = [[NSURLSession sharedSession]
                                                   downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                       NSError *err = nil;
                                                       if (err) {
                                                           NSLog(@"%@", err.localizedDescription);
                                                       }
    
                                                            if(error == nil)
                                                            {
                                                                
                                                                NSError* error;
                                                                
                                                                NSString* fileContents = [NSString stringWithContentsOfURL:url usedEncoding:nil error:&error];
                                                                
                                                                    NSArray *stockInfo = [[NSArray alloc] init];
                                                                stockInfo = [fileContents componentsSeparatedByString:@","];
                                                                
                                                                
                                                                int k = 0;
                                                                for (int i = 1; i < [stockInfo count]; i+=8) {
                                                                    
                                                                    self.stockDataArray[k]=stockInfo[i];
                                                                    k++;
                                                                }
                                                                
                                                                NSLog(@"%@", self.stockDataArray);
                                                                dispatch_sync(dispatch_get_main_queue(), ^{

                                                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"stockDataDidDownload" object:nil];
                                                                    [self.stockDataArray release];
                                                                
                                                                 });
                                                                
                                                            }
                                                   
                                                            
                                                        }];
    [downloadStockData resume];
}




-(NSMutableArray*)getStockDataArray{
    
    return self.stockDataArray;
    
    
}
                                                   



-(void)refreshData{
    
    
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = appDelegate.managedObjectContext;

    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CompanyMO"];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"position"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Company objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    self.managedCompaniesArray = [NSMutableArray arrayWithArray:results];
    self.companiesArray = [[NSMutableArray alloc] init];
    
    for (CompanyMO *companyMO in self.managedCompaniesArray){
        Company *company = [[Company alloc] initWithName:companyMO.name stockSymbol:companyMO.stockSymbol imageURL:companyMO.myURL];
        company.products = [[NSMutableArray alloc] init];
        for (ProductMO *productMO in companyMO.products) {
            Product *product = [[Product alloc] initWithName:productMO.name productURL:productMO.productURL productImageURL:productMO.productImageURL];
            
            [company.products addObject:product];
            [product release];
        }
        [self.companiesArray addObject:company];
        [company release];
    
        [company.products release];
    }
    //Memory management debbuging, this method is not 100% accurate on count
//
//    NSLog(@"request %lu", (unsigned long)[request retainCount]);
//    NSLog(@"managed companies %lu", (unsigned long)[self.managedCompaniesArray retainCount]);
//    NSLog(@"sort %lu", (unsigned long)[sortDescriptor retainCount]);
//    NSLog(@"sort array %lu", (unsigned long)[sortDescriptors retainCount]);
//
    [self.managedCompaniesArray release];
    [sortDescriptor release];
    [sortDescriptors release];
    [self.companiesArray release];
//        
//    NSLog(@"request %lu", (unsigned long)[request retainCount]);
//    NSLog(@"managed companies %lu", (unsigned long)[self.managedCompaniesArray retainCount]);
//    NSLog(@"sort %lu", (unsigned long)[sortDescriptor retainCount]);
//    NSLog(@"sort array %lu", (unsigned long)[sortDescriptors retainCount]);
}


-(BOOL)coreDataIsEmpty{
    
    
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = appDelegate.managedObjectContext;
    
//    NSManagedObjectContext *moc =[self managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CompanyMO"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (results.count == 0) {
        NSLog(@"CoreData is Empty");
        return YES;
    }
    
    else return NO;
    
    
}


-(void)refreshOrder:(NSMutableArray*)companiesArray{
    
    for (int i = 0; i < companiesArray.count; i++) {
        
        
        NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* moc = appDelegate.managedObjectContext;
        

        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"CompanyMO" inManagedObjectContext:moc]];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", [[companiesArray objectAtIndex:i]name]];
        [request setPredicate:predicate];
        
        NSError *error = nil;
        NSArray *results = [moc executeFetchRequest:request error:&error];

        CompanyMO *orderedCompany = [results objectAtIndex:0];
        NSNumber *y = [NSNumber numberWithInteger:i];
        orderedCompany.position = y;


    }
    
    
}





@end
