//
//  DJISaveToFile.h
//  UILibraryDemo
//
//  Created by Gord Mason on 2017-07-21.
//  Copyright © 2017 DJI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DJIUILibrary/DJIUILibrary.h>
#import <DJISDK/DJISDK.h>

@interface DJISaveToFile : NSObject {


NSFileManager *fileMgr;
NSString *homeDir;
NSString *filename;
NSString *filepath;
}

@property(nonatomic, retain)NSFileManager *fileMgr;
@property(nonatomic, retain)NSString *homeDir;
@property(nonatomic, retain)NSString *filename;
@property(nonatomic, retain)NSString *filepath;
@property(nonatomic, readonly) double altitude;

-(NSString *)GetDocumentDirectory;
-(NSString *)setFilename;
-(void)WriteToStringFile: (NSMutableString *)textToWrite;

@end

