//
//  ProductEditingViewController.m
//  NavCtrl
//
//  Created by Pratap Pandit on 7/27/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductEditingViewController.h"
#import "Company.h"
#import "Product.h"
#import "DataAccessObject.h"
#import "ProductViewController.h"

@interface ProductEditingViewController ()

@end

@implementation ProductEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelEdit)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveEdit)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.navigationItem.title = @"Add Product";
    

}

- (void)viewWillAppear{
    
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
    
    
    
    Product *product = [[Product alloc] initWithName:self.productName.text];
    [self.company.products addObject:product];
//    [[DataAccessObject sharedDataAccessObject]addProduct:product];
    
    if (self.company.products == NULL) {
        self.company.products = [[NSMutableArray alloc] init];
        [self.company.products addObject:product];
    }
    
    self.productName.text = @"";
    self.productURL.text = @"";
    self.productImageURL.text= @"";
    
    
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
    [ProductEditingViewController release];
    [_productName release];
    [_productURL release];
    [_productImageURL release];
    [super dealloc];
}
@end
