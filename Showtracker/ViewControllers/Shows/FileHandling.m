//
//  FileHandling.m
//  Showtracker
//
//  Created by Hani Kazmi on 08/04/2012.
//  Copyright (c) 2012 Hani Kazmi. All rights reserved.
//

#import "FileHandling.h"


@implementation FileHandling

+(void)createDirs: (NSString *)dirName{
    
    //Create temporary variables
    NSFileManager *filemgr;
    NSString *newDir;
    NSString *docsDir;
    NSArray *dirPaths;
    
    //Instantiate File Manager
    filemgr = [NSFileManager defaultManager];
    
    //Identify Documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    //Build Path to new directory
    newDir = [docsDir stringByAppendingPathComponent:dirName];
    
    //Create Directory
    [filemgr createDirectoryAtPath:newDir withIntermediateDirectories:YES attributes:nil error:NULL];
    
}

+(void)createPaths: (NSString *)fileName
{
    //create temporary variables
    NSFileManager *filemgr;
    NSString *fileDir;
    NSString *docsDir;
    NSArray *dirPaths;  
    
    //Instantiate File Manager  
    filemgr = [NSFileManager defaultManager];
    
    //Identify Documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    //Build Path to data files
    fileDir = [docsDir stringByAppendingPathComponent:fileName];
    
    //Create file if it doesn't exist
    if (![filemgr fileExistsAtPath:fileDir]){
        
        [filemgr createFileAtPath:fileDir contents:nil attributes:nil]; 
    }

}
@end
