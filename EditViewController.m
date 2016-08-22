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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [cancelButton release];
    [saveButton release];
    [tap release];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
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
        [company release];
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
//            NSLog(@"%@", imagePath);
            
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
            [[DataAccessObject sharedDataAccessObject] companyWasEdited:self.company];
}
        self.company.stockSymbol = self.stockSymbol.text;
        
        if
            (self.company.myURL == self.companyURL.text){
                
                self.company.name = self.companyName.text;
                self.company.myURL = self.companyURL.text;
                [[DataAccessObject sharedDataAccessObject] companyWasEdited:self.company];
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
        
        
    if (self.editingCompany == YES) {
        [[DataAccessObject sharedDataAccessObject] companyWasEdited:self.company];
    }

    
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    
    [self.company release];
    }

-(void)dismissKeyboard {
    [self.companyName resignFirstResponder];
    [self.companyURL resignFirstResponder];
    [self.stockSymbol resignFirstResponder];
    
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
    if ([sender isEqual:self.companyName]||[sender isEqual:self.companyURL]||[sender isEqual:self.stockSymbol])
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
    [_companyName release];
    [_stockSymbol release];
    [_companyURL release];
    [super dealloc];
}
@end
