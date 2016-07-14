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

@interface CompanyViewController ()

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

    

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.companyList = [NSMutableArray arrayWithObjects:companyApple, companySamsung, companyBlackberry, companyNexus, nil];
    
    self.imageNameList = @[@"apple.gif", @"samsung.png", @"BlackBerry.png", @"nexus.png"];
    
    self.title = @"Mobile device makers";
    
    
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
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [[self.companyList objectAtIndex:[indexPath row]] name];
    cell.imageView.image = [UIImage imageNamed:[self.imageNameList objectAtIndex:[indexPath row]]];
    


    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {                //delete cell
        [self.companyList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if
        (editingStyle == UITableViewCellEditingStyleInsert){
            
        }
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = self.companyList[sourceIndexPath.row];
    [self.companyList removeObjectAtIndex:sourceIndexPath.row];
    [self.companyList insertObject:stringToMove atIndex:destinationIndexPath.row];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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

    
    self.productViewController.title = [[self.companyList objectAtIndex:[indexPath row]] name];
    self.productViewController.company = [self.companyList objectAtIndex:[indexPath row]];
    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
    

}
 


@end
