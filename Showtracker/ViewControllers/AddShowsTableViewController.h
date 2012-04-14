//
//  AddShowsTableViewController.h
//  Showtracker
//
//  Created by Hani Kazmi on 13/04/2012.
//  Copyright (c) 2012 Hani Kazmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddShowsTableViewController : UITableViewController{
    NSMutableData *responseData;
    NSURLConnection *conn;
}
@property (weak, nonatomic) IBOutlet UISearchBar *addShowsSearchBar;
@property (nonatomic, copy) NSArray *showsArray;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;

@end
