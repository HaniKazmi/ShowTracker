//
//  Constants.h
//  Showtracker
//
//  Created by Hani Kazmi on 12/04/2012.
//  Copyright (c) 2012 Hani Kazmi. All rights reserved.
//

#import <Foundation/Foundation.h>

//Documents Directory
NSString * docsDir;

@interface Constants : NSObject 

//API Keys
extern NSString * const TheTVDBKey;

//Constant directory locations
extern NSString * const showsFile;
extern NSString * const reminderFile;
extern NSString * const showsXMLDir;
extern NSString * const episodesXMLDir;
extern NSString * const bannerDir;
extern NSString * const episodesDir;

//Constant URL locations
extern NSString * const addShowsURL;
extern NSString * const showRecordURL;

@end
