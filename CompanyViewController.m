//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "NavControllerAppDelegate.h"
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
    
    
    
    if ([[DataAccessObject sharedDataAccessObject] coreDataIsEmpty] == YES) {
        
        self.companies = [[DataAccessObject sharedDataAccessObject] createData];
        
    }
    
    if ([[DataAccessObject sharedDataAccessObject] coreDataIsEmpty] == NO) {
        self.companies = [[DataAccessObject sharedDataAccessObject] refreshData];
    }
    
//    static NSString* const hasRunAppOnceKey = @"hasRunAppOnceKey";
//    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
//    if ([defaults boolForKey:hasRunAppOnceKey] == NO)
//    {
//        
//        self.companies = [[DataAccessObject sharedDataAccessObject] createData];
//        
//        [defaults setBool:YES forKey:hasRunAppOnceKey];
//    }

    
    
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
   
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    
    UIBarButtonItem *undoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(undoButton)];
    
    UIBarButtonItem *redoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:self action:@selector(redoButton)];
    
    UIBarButtonItem *flexibleSpaceButtonItem = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                target:nil action:nil];
    
    self.toolbarItems = [NSArray arrayWithObjects:redoButton, flexibleSpaceButtonItem, undoButton, nil];

    
    
    
    self.title = @"Stock Tracker";
    
    
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    if (self.navigationController.toolbarHidden == NO) {
        self.navigationController.toolbarHidden = YES;
        self.tableView.editing = NO;
        
    }
    
    else if (self.navigationController.toolbarHidden == YES) {
        self.navigationController.toolbarHidden = NO;
        self.tableView.editing = YES;
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
   
    
    if ([[DataAccessObject sharedDataAccessObject] getStockDataArray]!= nil) {
        [[DataAccessObject sharedDataAccessObject] getStockDataArray];
    }
//    
    [[DataAccessObject sharedDataAccessObject] stockData];
//    NSLog(@"stock prices are %@", self.stockPriceArray);
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStockData)
                                                 name:@"stockDataDidDownload"
                                               object:nil];
    
        
    self.companies = [[DataAccessObject sharedDataAccessObject] refreshData];
    
    if (self.tableView.editing == YES) {
        
        self.navigationController.toolbarHidden = NO;
    }
    


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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString * name = [[self.companies objectAtIndex:[indexPath row]] name];
    NSString * imageName = [NSString stringWithFormat:@"%@.png", name ];
    NSString *imagePath = [self.documentsDirectory stringByAppendingPathComponent:imageName];
    cell.textLabel.text = name;
    if (self.stockPriceArray.count == self.companies.count) {
        cell.detailTextLabel.text = [self.stockPriceArray objectAtIndex:[indexPath row]];
    }
   

    cell.imageView.image = [UIImage imageWithContentsOfFile:imagePath];

    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {                //delete cell
        [[DataAccessObject sharedDataAccessObject] companyWasDeleted:[self.companies objectAtIndex:indexPath.row]];
        [self.companies removeObjectAtIndex:indexPath.row];
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
    [[DataAccessObject sharedDataAccessObject]refreshOrder:self.companies];
    
    
}

-(void)insertNewObject{
    
     self.editViewController = [[EditViewController alloc] initWithNibName:@"EditViewController" bundle:nil];
    
    [self.navigationController
     pushViewController:self.editViewController
     animated:YES];
    
}

-(void)undoButton{
    NSLog(@"undo");
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = appDelegate.managedObjectContext;

    [moc undo];
    self.companies = [[DataAccessObject sharedDataAccessObject] refreshData];
    [self.tableView reloadData];
}


-(void)redoButton{
    
    NSLog(@"redo");
    NavControllerAppDelegate *appDelegate = (NavControllerAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = appDelegate.managedObjectContext;
    
    [moc redo];
    self.companies = [[DataAccessObject sharedDataAccessObject] refreshData];
    [self.tableView reloadData];
    
    
    
}


-(void)loadStockData{
    
    
    self.stockPriceArray = [[DataAccessObject sharedDataAccessObject] getStockDataArray];
//    NSLog(@"stock prices are:%@",self.stockPriceArray);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
    
    
    
}


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

- (void)imageDownloaded:(NSNotification *)notification{
    
    [self.tableView reloadData];
}




@end
