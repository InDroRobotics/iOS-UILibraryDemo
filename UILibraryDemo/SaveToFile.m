//
//  SaveToFile.m
//  UILibraryDemo
//
//  Created by Gord Mason on 2017-07-19.
//  Copyright © 2017 DJI. All rights reserved.
//

#import "SaveToFile.h"
#import "DJIFlightControllerState.h"

@implementation SaveToFile

@synthesize fileMgr;
@synthesize homeDir;
@synthesize filename;
@synthesize filepath;
//@synthesize altitude;

// Name the filename
-(NSString *)setFilename {
    
    NSDate *currentdate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM:dd:yyyy_HH_mm"];
    NSString *timestamp = [df stringFromDate: currentdate];
    
    filename = [NSString stringWithFormat:@"mytextfile_%@.txt", timestamp];
    return filename;
    
}

//Get a handle on the directory where to write and read files. If it doesn't exist it will be created

-(NSString *)GetDocumentDirectory{
    fileMgr = [NSFileManager defaultManager];
    
    homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test Files"];
    
    return homeDir;
}

//Write to file

-(void)WriteToStringFile:(NSMutableString *)textToWrite {
    
    filepath = [[NSString alloc]init];
    NSError *error;
    
    filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];

    //textToWrite = string;
    
    [textToWrite writeToFile:filepath atomically:YES encoding:NSUnicodeStringEncoding error:&error];

    if(error){
        NSLog(@"Error writing file at %@\n%@",filepath, [error localizedFailureReason]);
    }
    //return textToWrite;
}

-(NSString *)readFromFile {
filepath = [[NSString alloc]init];
    NSError *err;
    NSString *title;
    filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];
    NSString *txtInFile = [[NSString alloc]initWithContentsOfFile:filepath encoding:NSUnicodeStringEncoding error:&err];
    
    if(!txtInFile){
        UIAlertView *tellErr = [[UIAlertView alloc]initWithTitle: title message:@"Unable to get text from the file" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [tellErr show];
        
    }
    return txtInFile;
}



@end
