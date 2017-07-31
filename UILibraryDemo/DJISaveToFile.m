//
//  DJISaveToFile.m
//  UILibraryDemo
//
//  Created by Gord Mason on 2017-07-21.
//  Copyright © 2017 DJI. All rights reserved.
//

#import "DJISaveToFile.h"
#import "DJIFlightControllerState.h"

@implementation DJISaveToFile

@synthesize fileMgr;
@synthesize homeDir;
@synthesize filename;
@synthesize filepath;
@synthesize altitude;



-(NSString *)setFilename {
    
    NSDate *currentdate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM:dd:yyyy_HH_mm"];
    NSString *timestamp = [df stringFromDate: currentdate];
    
    filename = [NSString stringWithFormat:@"mytextfile_%@.txt", timestamp];
    return filename;
    
}

-(NSString *)GetDocumentDirectory{
    fileMgr = [NSFileManager defaultManager];
    
    homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test Flights"];
    
    return homeDir;
}

-(void)WriteToStringFile:(NSMutableString *)textToWrite {
    
    filepath = [[NSString alloc]init];
    NSError *error;
    double DJItext;
    DJItext = self.altitude;
    
    NSNumber *straltitude = [NSNumber numberWithDouble:DJItext];
    NSMutableString *string = [straltitude mutableCopy];
    
    filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];
    
    textToWrite = string;
    
    [textToWrite writeToFile:filepath atomically:YES encoding:NSUnicodeStringEncoding error:&error];
    
    if(error){
        NSLog(@"Error writing file at %@\n%@",filepath, [error localizedFailureReason]);
    }
    //return textToWrite;
}

@end
