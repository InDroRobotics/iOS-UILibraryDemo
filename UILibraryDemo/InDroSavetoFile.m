//
//  InDroSavetoFile.m
//  UILibraryDemo
//
//  Created by Kate Mason on 2017-07-31.
//  Copyright © 2017 DJI. All rights reserved.
//
// This implementation file creates a txt file in the iPad Documents Directory and write a string with current DJI parameters in it



#import "InDroSavetoFile.h"


@implementation InDroSavetoFile


// This method creates a file with the filename mytextfile_ and the timestamp  it was created. It returns the filename as a string to be used in other methods

-(NSString *)setFilename {
    
    NSDate *currentdate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM:dd:yyyy_HH_mm"];
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

//This method gets the value for the current battery percentage of the drone using the DJI Key Manager. It returns the value as a string.

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

- (void)SaveFlightLogs {
    
    _filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];
    
    // Get logging parameters
    NSString *batterylvl = [self.getbatterypercent stringByAppendingString:@""];
    NSString *altitudelvl = [self.getAltitude stringByAppendingString:@""];
    NSString *locationlvl = [self.getaircaftlocation stringByAppendingString:@""];
    
    // Get Timestamp
    NSDate *currentdate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM_dd_yyyy_HH:mm"];
    NSString *timestamp = [df stringFromDate: currentdate];
    
    NSString *string = [NSString stringWithFormat:@"%@ Battery Percentage: %@ Altitude: %@ Location: %@\n", timestamp, batterylvl, altitudelvl, locationlvl];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(LogData:) userInfo:string repeats:YES];


}

-(int)LogData: (NSTimer *)timer{
    
    
    
    NSError *error;
    
    NSString *param1 = [timer userInfo];
    
    [param1 writeToFile: _filepath atomically:YES encoding:NSUnicodeStringEncoding error:&error];
    printf("Successfully wrote to Flight Logs");

    
    return 0;
}

// ;)

@end
