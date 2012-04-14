//
//  Constants.m
//  Showtracker
//
//  Created by Hani Kazmi on 12/04/2012.
//  Copyright (c) 2012 Hani Kazmi. All rights reserved.
//

#import "Constants.h"
#define BASE_SHOWS_URL @"http://www.thetvdb.com/api/"

@implementation Constants

NSString * const TheTVDBKey = @"77C92201A92620E4";

NSString * const showsFile = @"shows.txt";
NSString * const reminderFile = @"reminder.txt";
NSString * const showsXMLDir = @"Cache/Shows";
NSString * const episodesXMLDir = @"Cache/Episodes";
NSString * const bannerDir = @"Banner";
NSString * const episodesDir = @"Episode";

NSString * const addShowsURL = BASE_SHOWS_URL @"GetSeries.php?seriesname=";
NSString * const showRecordURL= BASE_SHOWS_URL @"%@/series/%@/all/en.xml";

@end
