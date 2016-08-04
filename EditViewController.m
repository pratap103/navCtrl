//
//  EditViewController.m
//  NavCtrl
//
//  Created by Pratap Pandit on 8/3/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "EditViewController.h"
#import "Company.h"
#import "DataAccessObject.h"
#import "CompanyViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelEdit)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveEdit)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"%@", self.company.name);
    NSLog(@"%@", self.company.stockSymbol);
    
    
    
    if (self.editingCompany == YES ) {
        self.navigationItem.title = @"Edit Company";
        self.companyName.text = self.company.name;
        self.stockSymbol.text = self.company.stockSymbol;
        self.companyURL.text = self.company.myURL;
        NSLog(@"Hello");
    }
    
    else{
        
        self.navigationItem.title = @"Add Company";
        self.companyName.text = @"";
        self.stockSymbol.text = @"";
        self.companyURL.text = @"";

    }
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, self.companyName.frame.size.height - borderWidth, self.companyName.frame.size.width, self.companyName.frame.size.height);
    border.borderWidth = borderWidth;
    [self.companyName.layer addSublayer:border];
    self.companyName.layer.masksToBounds = YES;
    
    CALayer *border2 = [CALayer layer];
    border2.borderColor = [UIColor lightGrayColor].CGColor;
    border2.frame = CGRectMake(0, self.stockSymbol.frame.size.height - borderWidth, self.stockSymbol.frame.size.width, self.stockSymbol.frame.size.height);
    border2.borderWidth = borderWidth;
    [self.stockSymbol.layer addSublayer:border2];
    self.stockSymbol.layer.masksToBounds = YES;
    
    
    
    CALayer *border3 = [CALayer layer];
    border3.borderColor = [UIColor lightGrayColor].CGColor;
    border3.frame = CGRectMake(0, self.companyURL.frame.size.height - borderWidth, self.companyURL.frame.size.width, self.companyURL.frame.size.height);
    border3.borderWidth = borderWidth;
    [self.companyURL.layer addSublayer:border3];
    self.companyURL.layer.masksToBounds = YES;
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)cancelEdit{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    self.companyName.text = @"";
    self.companyURL.text = @"";
    self.stockSymbol.text= @"";
}

-(void)saveEdit{
    
    
    if (self.editingCompany == NO) {
        
        
        Company *company = [[Company alloc] initWithName:self.companyName.text stockSymbol:self.stockSymbol.text imageURL:self.companyURL.text];
        
        
        [[DataAccessObject sharedDataAccessObject] addCompany:company];
        
        self.companyName.text = @"";
        self.companyURL.text = @"";
        self.stockSymbol.text= @"";
        
        //    [CompanyViewController.tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    else if (self.editingCompany == YES){
        
        if (self.company.name != self.companyName.text) {
            
            self.company.name = self.companyName.text;
            self.company.myURL = self.companyURL.text;
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString * imageName = [NSString stringWithFormat:@"%@.png", self.company.name ];
            NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
            NSLog(@"%@", imagePath);
            
//            if ([fileManager fileExistsAtPath:imagePath] == YES) {
//                NSLog(@"file exists");
            
                [fileManager removeItemAtPath:imagePath error:nil];
                
                NSURL *url = [NSURL URLWithString:self.company.myURL];
                
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
        
        
        
        NSLog(@"HELLO");
        
        
        self.company.stockSymbol = self.stockSymbol.text;
        
        if
            (self.company.myURL == self.companyURL.text){
                
                self.company.name = self.companyName.text;
                self.company.myURL = self.companyURL.text;
                NSLog(@"URL unchanged");
            }
        
        else{
            
            self.company.myURL = self.companyURL.text;
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString * imageName = [NSString stringWithFormat:@"%@.png", self.company.name ];
            NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
            NSLog(@"%@", imagePath);
            
            if ([fileManager fileExistsAtPath:imagePath] == YES) {
                NSLog(@"file exists");
                
                [fileManager removeItemAtPath:imagePath error:nil];
                
                NSURL *url = [NSURL URLWithString:self.company.myURL];
                
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
        
        
        

    
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
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
    [_companyName release];
    [_stockSymbol release];
    [_companyURL release];
    [super dealloc];
}
@end
