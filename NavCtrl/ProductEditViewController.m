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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelEdit)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveEdit)];
    self.navigationItem.rightBarButtonItem = saveButton;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.navigationItem.title = @"Edit Product";
    
    [cancelButton release];
    [saveButton release];
    [tap release];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
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
    
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
   
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
        [[DataAccessObject sharedDataAccessObject] addProduct:product forCompany:self.company];
        [self.company.products addObject:product];
        
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
-(void)dismissKeyboard {
    [self.productName resignFirstResponder];
    [self.productURL resignFirstResponder];
    [self.productImageURL resignFirstResponder];
}

#define kOFFSET_FOR_KEYBOARD 50.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:self.productName]||[sender isEqual:self.productURL]||[sender isEqual:self.productImageURL])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


- (void)dealloc {
    [ProductEditViewController release];
    [_productName release];
    [_productURL release];
    [_productImageURL release];
    [super dealloc];
}
@end
