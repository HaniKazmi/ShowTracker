//
//  EpisodeListTableViewController.h
//  Showtracker
//
//  Created by Hani Kazmi on 12/04/2012.
//  Copyright (c) 2012 Hani Kazmi. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface EpisodeListTableViewController : UITableViewController

@property (nonatomic) int showID;
@property (nonatomic, copy) NSString *seasonName;
@property (nonatomic, copy) NSArray *episodeDictionary;

@end
