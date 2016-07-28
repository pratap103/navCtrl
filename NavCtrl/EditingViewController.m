//
//  EditingViewController.m
//  NavCtrl
//
//  Created by Pratap Pandit on 7/25/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "EditingViewController.h"
#import "Company.h"
#import "DataAccessObject.h"

@interface EditingViewController ()

@end

@implementation EditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelEdit)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveEdit)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.navigationItem.title = @"Add Company";
    
        
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    
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
    
    Company *company = [[Company alloc] initWithName:self.companyName.text stockSymbol:self.stockSymbol.text imageURL:self.companyURL.text];
    
    [[DataAccessObject sharedDataAccessObject] addCompany:company];
    
    self.companyName.text = @"";
    self.companyURL.text = @"";
    self.stockSymbol.text= @"";
    
    
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
