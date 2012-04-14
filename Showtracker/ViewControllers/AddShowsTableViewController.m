//
//  AddShowsTableViewController.m
//  Showtracker
//
//  Created by Hani Kazmi on 13/04/2012.
//  Copyright (c) 2012 Hani Kazmi. All rights reserved.
//

#import "AddShowsTableViewController.h"
#import "XMLReader.h"
#import "Constants.h"
#import "FileHandling.h"
#import "ShowsTableViewController.h"

@implementation AddShowsTableViewController
@synthesize addShowsSearchBar;
@synthesize showsArray;
@synthesize spinner;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];

    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setAddShowsSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return [showsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"addShow";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:8];
        cell.detailTextLabel.numberOfLines = 2;  
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    NSDictionary *currentDictionary;

    currentDictionary = [showsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [currentDictionary objectForKey:@"SeriesName"];
    cell.detailTextLabel.text = [currentDictionary objectForKey:@"Overview"];
    cell.tag = [[currentDictionary objectForKey:@"id"] intValue];
    // Configure the cell...
        
    return cell;
}


#pragma mark - Search bar delegate

- (void) extractShowData:(NSDictionary *) searchDictionary
{
    NSArray *tempArray = [searchDictionary retrieveForPath:@"Data.Series"];
    
    NSString *class = @"__NSCFDictionary";
    id testClass = NSClassFromString(class);
    
    if ([tempArray isKindOfClass:testClass]) {
        showsArray = [NSArray arrayWithObject:tempArray];
    }
    else if (tempArray) {
        showsArray = tempArray;
    }
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchtext
{
    if ([searchtext length] != 0){
        searchtext = [searchtext stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        [self.spinner startAnimating];
        NSString *urlString = [addShowsURL stringByAppendingString:searchtext];
        NSURL *urlTerm = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:urlTerm];
        [conn cancel];
        conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        }
    
    else{
        [self.spinner stopAnimating];
        [conn cancel];
        showsArray = nil;
        [self.tableView reloadData];
    }
}


- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}

#pragma mark - NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    responseData = [[NSMutableData alloc] initWithLength:0];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSDictionary *searchedShowsDictionary = [XMLReader dictionaryForXMLData:responseData];
    [self extractShowData:searchedShowsDictionary];
    [self.spinner stopAnimating];
    [self.tableView reloadData];

}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSNumber *cellTag = [NSNumber numberWithInt:[[self tableView:tableView cellForRowAtIndexPath:indexPath] tag]];
    [FileHandling saveXML:cellTag];
    shouldReloadData = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
