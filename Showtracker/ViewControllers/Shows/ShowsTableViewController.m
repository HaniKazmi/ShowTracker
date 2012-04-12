//
//  ShowsTableViewController.m
//  Showtracker
//
//  Created by Hani Kazmi on 05/04/2012.
//  Copyright (c) 2012 Hani Kazmi. All rights reserved.
//

#import "ShowsTableViewController.h"
#import "FileHandling.h"
#import "XMLReader.h"
#import "SeasonListTableViewController.h"
#import "Constants.h"


@implementation ShowsTableViewController

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

- (void)viewDidLoad //Any additional setup after loading view
{
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Determine Documents Directory location
    [FileHandling docsLocation];
    
    //Create initial directories
    [FileHandling createDirs:showsXMLDir];
    [FileHandling createDirs:episodesXMLDir];
    [FileHandling createDirs:bannerDir];
    [FileHandling createDirs:episodesDir];
    
    //Create initial files
    [FileHandling createFiles:showsFile];
    [FileHandling createFiles:reminderFile];
    
    //Parse shows.txt
    NSString *path = [docsDir stringByAppendingPathComponent:showsFile];
    NSData *xmlData = [NSData dataWithContentsOfFile:path];
    showsDictionary = [XMLReader dictionaryForXMLData:xmlData];
    	
    
    //Determine Number of letters for index
    NSDictionary *childShowsDictionary;
    lettersinDictionary = [[NSMutableArray alloc] init];
    numberOfEachLetter = [[NSMutableArray alloc] init];
    rowIndexOfeachLetter = [[NSMutableArray alloc] init];
    int currentCountofLetter = 1;
    int rowOfCurrentLetter = 0;
    
    
    NSString *seriesName;
    //Loop through and extract series names
    for (int i = 0; i < [[showsDictionary retrieveForPath:@"Data.Show"] count]; i++) {
        
        childShowsDictionary = [showsDictionary retrieveForPath:[NSString stringWithFormat:@"Data.Show.%i",i]];
        seriesName = [childShowsDictionary objectForKey:@"SeriesName"];
        //Extract first character from name
        seriesName =[seriesName substringToIndex:1];
        
        //Check if letter is in array
        if (![lettersinDictionary containsObject:seriesName]) {
            
            
            //If not in array, add letter and set the number of letters to one
            [lettersinDictionary addObject: seriesName];
            
            //Skip above process on first loop, as letters haven't finished counting
            if (i != 0) {
                NSNumber *numberOfEachLetterWrapper = [NSNumber numberWithInteger:currentCountofLetter];
                [numberOfEachLetter addObject:numberOfEachLetterWrapper];
                currentCountofLetter = 1;
            }
            
            //Keep count of position of first occurence of the letter
            NSNumber *rowIndexOfEachLetterWrapper = [NSNumber numberWithInteger:rowOfCurrentLetter];
            [rowIndexOfeachLetter addObject:rowIndexOfEachLetterWrapper];
            rowOfCurrentLetter ++;
        }
        
        //Increment counters if new letter not found
        else {
            currentCountofLetter ++; 
            rowOfCurrentLetter ++;
        }
    }
    
    //As i = 0 was skipped, fill in the last elemt of the array
    NSNumber *numberOfEachLetterWrapper = [NSNumber numberWithInteger:currentCountofLetter];
    [numberOfEachLetter addObject:numberOfEachLetterWrapper];
    currentCountofLetter = 1;
    
    //Populate table
    [self.tableView reloadData];
    
    [super viewDidLoad];    
}		

- (void)viewDidUnload
{

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
    return YES; //(interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [lettersinDictionary count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[numberOfEachLetter objectAtIndex:section] intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Calculate next label to add
    int rowNumber =  ([[rowIndexOfeachLetter objectAtIndex:indexPath.section] intValue] + indexPath.row);
    NSDictionary *show = [showsDictionary retrieveForPath:[NSString stringWithFormat:@"Data.Show.%d",rowNumber]];
    
    static NSString *CellIdentifier = @"show";
    
    //Cell settings
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
        cell.textLabel.numberOfLines = 2;  
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    
    // Populate cell	
    cell.textLabel.text=[show objectForKey:@"SeriesName"];
    
    //Create Identifier
    cell.tag = [[show objectForKey:@"id"] intValue];
    
    return cell;
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView{
    //Return headers for the index
    return lettersinDictionary;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //Return header for each section
    return [lettersinDictionary objectAtIndex:section];
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{  
    //Send show id
    showID = ([tableView cellForRowAtIndexPath:indexPath].tag);
    showName = ([tableView cellForRowAtIndexPath:indexPath].textLabel.text);
    
    //Load next view
    [self performSegueWithIdentifier:@"seasonPush" sender:indexPath];
}

@end
