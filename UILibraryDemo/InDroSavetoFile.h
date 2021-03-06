//
//  InDroSavetoFile.h
//  UILibraryDemo
//
//  Created by Kate Mason on 2017-07-31.
//  Copyright © 2017 DJI. All rights reserved.
//
//
// This is the header file to set up the methods and variable names in the implementation file
//
//
//


// Library import

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DJIUILibrary/DJIUILibrary.h>
#import <DJISDK/DJISDK.h>

@interface InDroSavetoFile : NSObject



// Variable/property  declaration

@property(nonatomic, retain)NSFileManager *fileMgr;
@property(nonatomic, retain)NSString *homeDir;
@property(nonatomic, retain)NSString *filepath;
@property(nonatomic, retain)NSString *filename;
@property(nonatomic, retain)NSString *altitude;
@property(nonatomic, retain)NSString *BatteryLevel;
@property(nonatomic, retain)NSString *FlightTime;
@property(nonatomic, retain)NSString *FlightMode;
@property(nonatomic, retain)NSString *aircraftlocation;
@property(nonatomic, retain)NSString *data;


// method declaration
-(NSString *)setFilename;
-(NSString *)GetDocumentDirectory;
-(NSString *)getAltitude;
-(NSString *)getbatterypercent;
-(NSString *)getflighttime;
-(NSString *)getflightmode;
-(NSString *)getaircaftlocation;
-(void)GetFlightData:(NSTimer*)timer;
-(int)LogData;
@end
