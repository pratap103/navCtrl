//
//  ProductEditingViewController.m
//  NavCtrl
//
//  Created by Pratap Pandit on 7/27/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductEditViewController.h"
#import "Company.h"
#import "Product.h"
#import "DataAccessObject.h"
#import "ProductViewController.h"

@interface ProductEditViewController ()

@end

@implementation ProductEditViewController
//
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelEdit)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveEdit)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
    
    //    else{
    //        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(editExisting)];
    //        self.navigationItem.rightBarButtonItem = saveButton;
    //
    //
    //
    //
    //    }
    
    self.navigationItem.title = @"Edit Product";
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{

    NSLog(@"Hello");
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, self.productName.frame.size.height - borderWidth, self.productName.frame.size.width, self.productName.frame.size.height);
    border.borderWidth = borderWidth;
    [self.productName.layer addSublayer:border];
    self.productName.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    border2.borderColor = [UIColor lightGrayColor].CGColor;
    border2.frame = CGRectMake(0, self.productURL.frame.size.height - borderWidth, self.productURL.frame.size.width, self.productURL.frame.size.height);
    border2.borderWidth = borderWidth;
    [self.productURL.layer addSublayer:border2];
    self.productURL.layer.masksToBounds = YES;
    
    
    
    CALayer *border3 = [CALayer layer];
    border3.borderColor = [UIColor lightGrayColor].CGColor;
    border3.frame = CGRectMake(0, self.productImageURL.frame.size.height - borderWidth, self.productImageURL.frame.size.width, self.productImageURL.frame.size.height);
    border3.borderWidth = borderWidth;
    [self.productImageURL.layer addSublayer:border3];
    self.productImageURL.layer.masksToBounds = YES;
    
    self.productName.clearsOnBeginEditing = NO;
    self.productURL.clearsOnBeginEditing = NO;
    self.productImageURL.clearsOnBeginEditing = NO;
    
    if (self.product) {
        self.productName.text = self.product.name;
        self.productURL.text = self.product.productURL;
        self.productImageURL.text = self.product.productImageURL;
    }
    
    
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)cancelEdit{
    
    [self.navigationController popViewControllerAnimated:YES];
    self.productName.text = @"";
    self.productURL.text = @"";
    self.productImageURL.text= @"";
    
    
}
-(void)saveEdit{
    
    if (self.editingProduct == NO) {
        
        
        
        Product *product = [[Product alloc] initWithName:self.productName.text productURL:self.productURL.text productImageURL:self.productImageURL.text];
        [self.company.products addObject:product];
        //    [[DataAccessObject sharedDataAccessObject]addProduct:product];
        
//        NSURL *url = [NSURL URLWithString:self.productImageURL.text];
//        
//        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
//        
//        UIImage *tmpImage = [[UIImage alloc] initWithData:data];
//        
//        product.productImage = tmpImage;
//        
        
        if (self.company.products == NULL) {
            self.company.products = [[NSMutableArray alloc] init];
            [self.company.products addObject:product];
        }
        
        
        self.productName.text = @"";
        self.productURL.text = @"";
        self.productImageURL.text= @"";
        
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    else if (self.editingProduct == YES) {
        
        if (self.product.name != self.productName.text) {
            
            self.product.name = self.productName.text;
            self.product.productImageURL = self.productImageURL.text;
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString * imageName = [NSString stringWithFormat:@"%@.png", self.product.name ];
            NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
            NSLog(@"%@", imagePath);
            
            //            if ([fileManager fileExistsAtPath:imagePath] == YES) {
            //                NSLog(@"file exists");
            
            [fileManager removeItemAtPath:imagePath error:nil];
            
            NSURL *url = [NSURL URLWithString:self.product.productImageURL];
            
            // 2
            NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]
                                                           downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                               NSError *err = nil;
                                                               if ([fileManager fileExistsAtPath:imagePath] == NO) {
                                                                   //                                                                   NSLog(@"ABSOLUTE STRING: %@", location.path);
                                                                   [fileManager copyItemAtPath:[location path] toPath:imagePath error:&err];
                                                                   NSLog(@"entered cpy");
                                                                   if (err) {
                                                                       NSLog(@"%@", err.localizedDescription);
                                                                       
                                                                   }
                                                               }
                                                               
//                                                               // 3
//                                                               UIImage *downloadedImage = [UIImage imageWithData: [NSData dataWithContentsOfURL:location]];
                                                           }];
            // 4
            [downloadPhotoTask resume];
            
            
            
        }
        

        
        
        self.product.name = self.productName.text;
        self.product.productURL = self.productURL.text;
        
        
        if
            (self.product.productImageURL == self.productImageURL.text){
                
                self.product.productImageURL = self.productImageURL.text;
                
            }
        
        else{
            
            self.product.productImageURL = self.productImageURL.text;
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString * imageName = [NSString stringWithFormat:@"%@.png", self.product.name ];
            NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
            NSLog(@"%@", imagePath);
            
            if ([fileManager fileExistsAtPath:imagePath] == YES) {
                NSLog(@"file exists");
                
                [fileManager removeItemAtPath:imagePath error:nil];
                
                NSURL *url = [NSURL URLWithString:self.product.productImageURL];
                
                // 2
                NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]
                                                               downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                                   NSError *err = nil;
                                                                   if ([fileManager fileExistsAtPath:imagePath] == NO) {
                                                                       //                                                                   NSLog(@"ABSOLUTE STRING: %@", location.path);
                                                                       [fileManager copyItemAtPath:[location path] toPath:imagePath error:&err];
                                                                       NSLog(@"entered cpy");
                                                                       if (err) {
                                                                           NSLog(@"%@", err.localizedDescription);
                                                                           
                                                                       }
                                                                   }
                                                                   
                                                        }];
                // 4
                [downloadPhotoTask resume];
                
            }
            
        }

        
  
        
        NSArray *array = [self.navigationController viewControllers];
        
        [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
    }
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)dealloc {
    [ProductEditViewController release];
    [_productName release];
    [_productURL release];
    [_productImageURL release];
    [super dealloc];
}
@end
