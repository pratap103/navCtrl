//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "Company.h"
#import "Product.h"
#import "DataAccessObject.h"

#import "EditViewController.h"

@interface CompanyViewController ()
@property (nonatomic, strong) DataAccessObject *dao;
@property (nonatomic, strong) NSMutableArray *companies;
@end

@implementation CompanyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.companies = [[DataAccessObject sharedDataAccessObject] createData];
    [self.tableView reloadData];
    
//    self.dao = [DataAccessObject sharedDataAccessObject];
//    self.companies = self.dao.companiesArray;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.documentsDirectory = [paths objectAtIndex:0];
    
    
    self.tableView.allowsSelection = YES
    ;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.leftBarButtonItem = addButton;
    

    self.tableView.allowsSelectionDuringEditing = YES;
    
    
    
    
    

    // Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    self.title = @"Mobile device makers";
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    

    [self.tableView reloadData];
    
    
}

-(void) viewDidAppear:(BOOL)animated{
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.companies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString * name = [[self.companies objectAtIndex:[indexPath row]] name];
    NSString * imageName = [NSString stringWithFormat:@"%@.png", name ];
    NSString *imagePath = [self.documentsDirectory stringByAppendingPathComponent:imageName];
    cell.textLabel.text = name;
    cell.imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    NSLog(@"image loaded");

//    NSString* imageURL = [[self.companies objectAtIndex:[indexPath row]] myURL];
    // no image is set, set the default image
    
    //move this to dao, when you create the companies
//    NSURLSession * session = [NSURLSession sharedSession];
//    NSURL * url = [NSURL URLWithString: imageURL];
//    NSURLSessionDataTask * dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
//                                       {
//                                           
//                                           
//                                           UIImage *image = [UIImage imageWithData:data];
//                                           dispatch_async(dispatch_get_main_queue(), ^{
//                                               cell.imageView.image = image;
//                                               [self.tableView reloadData];
//                                           });
//                                           
//
//                                           
//                                       }];
//    
//    
//
//    
//    [dataTask resume];         //Asychronous method
//
    
//    NSString *imageURL = [[self.companies objectAtIndex:[indexPath row]] myURL];
//    
//    NSURL * url = [NSURL URLWithString:imageURL];
//    
    

    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {                //delete cell
        [self.companies removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        [[DataAccessObject sharedDataAccessObject]updateCompaniesArray:self.companyList];
    }
    else if
        (editingStyle == UITableViewCellEditingStyleInsert){
           
        }
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    Company *companyToMove = self.companies[sourceIndexPath.row];
    [self.companies removeObjectAtIndex:sourceIndexPath.row];
    [self.companies insertObject:companyToMove atIndex:destinationIndexPath.row];
    
}

-(void)insertNewObject{
    
     self.editViewController = [[EditViewController alloc] initWithNibName:@"EditViewController" bundle:nil];
    
    [self.navigationController
     pushViewController:self.editViewController
     animated:YES];
    
}


//-(void)tableView:(UITableView *)tableView insertRowsAtIndexPath:(NSIndexPath *)lastRow{
//    
//    NSString *stringToAdd = @"Nikon";
//    [self.companyList insertObject:stringToAdd atIndex:lastRow.row];
//    
//    
//    
//}


// Override to support conditional editing of the table view.


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (tableView.editing == YES) {
        
        self.editViewController = [[EditViewController alloc] initWithNibName:@"EditViewController" bundle:nil];
        
        self.editViewController.company = [self.companies objectAtIndex:[indexPath row]];
        self.editViewController.editingCompany = YES;
        
        
        
        [self.navigationController
         pushViewController:self.editViewController
         animated:YES];

    }
    if (tableView.editing == NO) {
    
        self.editViewController = [[EditViewController alloc] initWithNibName:@"EditViewController" bundle:nil];
    
        self.productViewController.title = [[self.companies objectAtIndex:[indexPath row]] name];
        self.productViewController.company = [self.companies objectAtIndex:[indexPath row]];
        self.editViewController.editingCompany = NO;
    
    
        [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
    
    }
    
}

- (void) imageDownloaded:(NSNotification *)notification{
    
    [self.tableView reloadData];
}

//- (void)navigationController:(UINavigationController *)navigationController
//      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [self viewWillAppear:animated];
//}
//

@end
