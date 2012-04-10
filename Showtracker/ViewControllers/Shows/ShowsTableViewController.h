//
//  ShowsTableViewController.h
//  Showtracker
//
//  Created by Hani Kazmi on 05/04/2012.
//  Copyright (c) 2012 Hani Kazmi. All rights reserved.
//

#import <UIKit/UIKit.h>

NSDictionary *showsDictionary;

//Directory locations
NSString const
*showsFile = @"shows.txt",
*reminderFile = @"reminder.txt",
*showsXMLDir = @"Cache/Shows",
*episodesXMLDir = @"Cache/Episodes",
*bannerDir = @"Banner",
*episodesDir = @"Episode";

@interface ShowsTableViewController : UITableViewController 
    

@end
