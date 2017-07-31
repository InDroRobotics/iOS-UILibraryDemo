//
//  InDroSavetoFile.h
//  UILibraryDemo
//
//  Created by Gord Mason on 2017-07-31.
//  Copyright © 2017 DJI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DJIUILibrary/DJIUILibrary.h>
#import <DJISDK/DJISDK.h>

@interface InDroSavetoFile : NSObject


@property(nonatomic, retain)NSFileManager *fileMgr;
@property(nonatomic, retain)NSString *homeDir;
@property(nonatomic, retain)NSString *filename;
@property(nonatomic, retain)NSString *filepath;
@property(nonatomic, retain)NSString *altitude;
@property(nonatomic, retain)NSString *BatteryLevel;
@property(nonatomic, retain)NSString *aircraftlocation;



-(NSString *)GetDocumentDirectory;
-(NSString *)setFilename;
-(NSString *)getAltitude;
-(NSString *)getbatterypercent;
-(NSString *)getaircaftlocation;
-(NSString *)SaveFlightLogs;

@end
