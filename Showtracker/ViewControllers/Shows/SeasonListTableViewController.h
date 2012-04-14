//
//  SeasonListTableViewController.h
//  Showtracker
//
//  Created by Hani Kazmi on 11/04/2012.
//  Copyright (c) 2012 Hani Kazmi. All rights reserved.
//

#import <UIKit/UIKit.h>

NSDictionary *seasonDictionary;


@interface SeasonListTableViewController : UITableViewController

@property (nonatomic) int showID;
@property (nonatomic, copy) NSString *showName;

@end
