//
//  SeasonListTableViewController.m
//  Showtracker
//
//  Created by Hani Kazmi on 11/04/2012.
//  Copyright (c) 2012 Hani Kazmi. All rights reserved.
//

#import "SeasonListTableViewController.h"
#import "EpisodeListTableViewController.h"
#import "XMLReader.h"
#import "Constants.h"

@implementation SeasonListTableViewController

@synthesize showID;
@synthesize showName;

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
    //Set Navigation bar title
    self.title = showName;

    //Create path to [episodeID].txt
    NSString *showIDString = [NSString stringWithFormat:@"%d", showID];
    NSString *path = [docsDir stringByAppendingPathComponent:episodesDir];
    path = [path stringByAppendingPathComponent:showIDString];  
    path = [path stringByAppendingPathExtension:@"txt"];
    
    //Parse XML
    NSData *xmlData = [NSData dataWithContentsOfFile:path];
    seasonDictionary = [XMLReader dictionaryForXMLData:xmlData];
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [[seasonDictionary retrieveForPath:@"Data"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    static NSString *CellIdentifier = @"Season";
    
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
    cell.textLabel.text=[NSString stringWithFormat:@"Season %d", (indexPath.row + 1)];
    
    //Create Identifier
    cell.tag = (indexPath.row + 1);
    
    return cell;
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
    
    EpisodeListTableViewController *vc = segue.destinationViewController;
    vc.showID = [sender tag];
    vc.seasonName = [[sender textLabel] text];
    vc.episodeDictionary = [[seasonDictionary retrieveForPath:@"Data"] objectForKey:[NSString stringWithFormat:@"Season_%d.Episode", [sender tag]]];
    vc.episodeDictionary = [seasonDictionary retrieveForPath:[NSString stringWithFormat:@"Data.Season_%d.Episode", [sender tag]]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{  
    //Load next view
    [self performSegueWithIdentifier:@"EpisodeListPush" sender:[self tableView:tableView cellForRowAtIndexPath:indexPath]];
}

@end