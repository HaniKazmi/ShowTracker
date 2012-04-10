//
//  ShowsTableViewController.h
//  Showtracker
//
//  Created by Hani Kazmi on 05/04/2012.
//  Copyright (c) 2012 Hani Kazmi. All rights reserved.
//

#import <UIKit/UIKit.h>

//Directory Locations
NSString const
*showsFile = @"shows.txt",
*reminderFile = @"reminder.txt",
*showsXMLDir = @"Cache/Shows",
*episodesXMLDir = @"Cache/Episodes",
*bannerDir = @"Bannar",
*episodesDir = @"Episode";

NSDictionary *showsDictionary;


@interface ShowsTableViewController : UITableViewController 
    

@end
