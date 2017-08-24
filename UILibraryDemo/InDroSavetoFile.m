//
//  InDroSavetoFile.m
//  UILibraryDemo
//
//  Created by Kate Mason on 2017-07-31.
//  Copyright © 2017 DJI. All rights reserved.
//
// This implementation file creates a txt file in the iPad Documents Directory and write a string with current DJI parameters in it every second. 



#import "InDroSavetoFile.h"


@implementation InDroSavetoFile


// This method creates a file with the filename mytextfile_ and the timestamp  it was created. It returns the filename as a string to be used in other methods

-(NSString *)setFilename {
    
    NSDate *currentdate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM_dd_yyyy_HH:mm"];
    NSString *timestamp = [df stringFromDate: currentdate];
    
    _filename = [NSString stringWithFormat:@"FlightLog_%@.txt", timestamp];
    printf("File Name Set"); // For debugging
    return _filename;
    
}

// This method gets the documents directory on the iPad and goes into the correct folder Flight Logs to save the txt file in

-(NSString *)GetDocumentDirectory{
    _fileMgr = [NSFileManager defaultManager];
    
    _homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Flight Logs"];
    
    return _homeDir;
}


//This method gets the value for the current altitude of the drone using the DJI Key Manager. It returns the value as a string.
-(NSString *)getAltitude{
    
    DJIKeyManager *keyManager = [DJISDKManager keyManager];
    DJIFlightControllerKey *altitudeLevelKey = [DJIFlightControllerKey keyWithParam:DJIFlightControllerParamAltitudeInMeters];
    
    
    [keyManager getValueForKey:altitudeLevelKey
                withCompletion:^(DJIKeyedValue * _Nullable value, NSError * _Nullable error)
     
     
     {
         if (error || value == nil) {
             // insert graceful error handling here.
             
             NSLog(@"Error getting Altitude Level Key");
         } else {
             // DJIBatteryParamChargeRemainingInPercent is associated with a uint8_t value
             
             double altitudeLevel = value.doubleValue;
             
             
             _altitude = [NSString stringWithFormat:@"%f",altitudeLevel];
             
         }
     }];
    
    
    return _altitude;
}

-(NSString *)getbatterypercent {
    
    DJIKeyManager *keyManager = [DJISDKManager keyManager];
    DJIBatteryKey *batteryLevelKey = [DJIBatteryKey keyWithParam:DJIBatteryParamChargeRemainingInPercent];
    //DJIFlightControllerKey *altitudeKey = [DJIFlightControllerKey keyWithParam:DJIFlightControllerParamAltitudeInMeters];
    
    
    [keyManager getValueForKey:batteryLevelKey
                withCompletion:^(DJIKeyedValue * _Nullable value, NSError * _Nullable error)
     
     
     {
         if (error || value == nil) {
             // insert graceful error handling here.
             
             NSLog(@"Error getting Battery Level Key");
         } else {
             // DJIBatteryParamChargeRemainingInPercent is associated with a uint8_t value
             
             NSUInteger batteryLevel = value.unsignedIntegerValue;
             
             
             _BatteryLevel = [NSString stringWithFormat:@"%tu%%", batteryLevel];
             
         }
     }];
    
    
    return _BatteryLevel;
}


//This method gets the value for the current battery percentage of the drone using the DJI Key Manager. It returns the value as a string.

-(NSString *)getflighttime {
    
    DJIKeyManager *keyManager = [DJISDKManager keyManager];
    DJIFlightControllerKey *flighttimeLevelKey = [DJIFlightControllerKey keyWithParam:DJIFlightControllerParamFlightTimeInSeconds];
    //DJIFlightControllerKey *altitudeKey = [DJIFlightControllerKey keyWithParam:DJIFlightControllerParamAltitudeInMeters];
    
    
    [keyManager getValueForKey:flighttimeLevelKey
                withCompletion:^(DJIKeyedValue * _Nullable value, NSError * _Nullable error)
     
     
     {
         if (error || value == nil) {
             // insert graceful error handling here.
             
             NSLog(@"Error getting Flight Time Level Key");
         } else {
             // DJIBatteryParamChargeRemainingInPercent is associated with a uint8_t value
             
             NSUInteger flighttime = value.unsignedIntegerValue;
             
             
             _FlightTime = [NSString stringWithFormat:@"%tu%%", flighttime];
             
         }
     }];
    
    
    return _FlightTime;
}


-(NSString *)getflightmode{
    
    DJIKeyManager *keyManager = [DJISDKManager keyManager];
    DJIFlightControllerKey *flightmodekey = [DJIFlightControllerKey keyWithParam:DJIFlightControllerParamFlightMode];
    
    
    [keyManager getValueForKey:flightmodekey
                withCompletion:^(DJIKeyedValue * _Nullable value, NSError * _Nullable error)
     
     
     {
         if (error || value == nil) {
             // insert graceful error handling here.
             
             NSLog(@"Error getting Flight Mode Key");
         } else {
             // DJIBatteryParamChargeRemainingInPercent is associated with a uint8_t value
             
             NSString *flightMode = value.stringValue;
             
             
             _FlightMode = [NSString stringWithFormat:@"%@",flightMode];
             
         }
     }];
    
    
    return _FlightMode;
}

//This method gets the value for the current latitude and longitude of the drone using the DJI Key Manager. It returns the value as a string.

-(NSString *)getaircaftlocation{
    
    DJIKeyManager *keyManager = [DJISDKManager keyManager];
    DJIFlightControllerKey *locationKey = [DJIFlightControllerKey keyWithParam:DJIFlightControllerParamAircraftLocation];
    
    [keyManager startListeningForChangesOnKey:locationKey
                                 withListener:self
                               andUpdateBlock:^(DJIKeyedValue * _Nullable oldValue, DJIKeyedValue * _Nullable newValue)
     {
         if (newValue) {
             // DJIFlightControllerParamAircraftLocation is associated with a DJISDKLocation object
             CLLocation *aircraftCoordinates = (CLLocation *)newValue.value;
             
             _aircraftlocation = [NSString stringWithFormat:@"Lat: %.6f - Long: %.6f", aircraftCoordinates.coordinate.latitude, aircraftCoordinates.coordinate.longitude];
         }
     }];
    
    NSLog(@"%@", _aircraftlocation);
    
    return _aircraftlocation;
}

// This method sets the filepath of the txt file by appending the filename to the documents path
// It calls each of the methods obove to return the specific string value for the parameter
// Then it puts all the parameters into one string and writes the string to the txt file

- (void)GetFlightData:(NSTimer *)timer {
    
    
    // Get logging parameters
    NSString *flightTIME = [self.getflighttime stringByAppendingString:@""];
    NSString *flightMODE = [self.getflightmode stringByAppendingString:@""];
    NSString *batterylvl = [self.getbatterypercent stringByAppendingString:@""];
    NSString *altitudelvl = [self.getAltitude stringByAppendingString:@""];
    NSString *locationlvl = [self.getaircaftlocation stringByAppendingString:@""];
    
    // Get Timestamp
    NSDate *currentdate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM_dd_yyyy_HH:mm:ss"];
    NSString *timestamp = [df stringFromDate: currentdate];
    
    NSString *string = [NSString stringWithFormat:@"%@ Flight Time (seconds): %@ Flight Mode: %@ Battery Percentage: %@ Altitude: %@ Location: %@\r\n", timestamp,flightTIME,flightMODE, batterylvl, altitudelvl, locationlvl];
    
    NSFileManager *myManager = [NSFileManager defaultManager];
    if (! [myManager fileExistsAtPath:_filepath]){
        [string writeToFile:_filepath atomically:YES encoding:NSUnicodeStringEncoding error:nil];
    }
    else{
        NSFileHandle *myhandle = [NSFileHandle fileHandleForWritingAtPath:_filepath];
        [myhandle seekToEndOfFile];
        [myhandle writeData:[string dataUsingEncoding:NSUnicodeStringEncoding]];
        
    }
    
    printf("Successfully wrote to Flight Logs");

}

// This method gets called from the TestView Controller and sets the filepath of the text file. Then it uses a timer to call the method GetFlightData every second

-(int)LogData{
    
    _filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(GetFlightData:) userInfo:nil repeats:YES];

    return 0;
}

// ;)

@end
