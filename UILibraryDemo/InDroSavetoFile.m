//
//  InDroSavetoFile.m
//  UILibraryDemo
//
//  Created by Gord Mason on 2017-07-31.
//  Copyright © 2017 DJI. All rights reserved.
//

#import "InDroSavetoFile.h"

@implementation InDroSavetoFile

-(NSString *)setFilename {
    
    NSDate *currentdate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM:dd:yyyy_HH_mm"];
    NSString *timestamp = [df stringFromDate: currentdate];
    
    _filename = [NSString stringWithFormat:@"mytextfile_%@.txt", timestamp];
    return _filename;
    
}

-(NSString *)GetDocumentDirectory{
    _fileMgr = [NSFileManager defaultManager];
    
    _homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Flight Logs"];
    
    return _homeDir;
}

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



- (NSString *)SaveFlightLogs:(id)sender {
    
    NSError *error;
    _filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:self.setFilename];
    
    NSString *batterylvl = [self.getbatterypercent stringByAppendingString:@""];
    NSString *altitudelvl = [self.getAltitude stringByAppendingString:@""];
    NSString *locationlvl = [self.getaircaftlocation stringByAppendingString:@""];
    
    NSString *string = [NSString stringWithFormat:@"Battery Percentage: %@ Altitude: %@ Location: %@\n",batterylvl, altitudelvl, locationlvl];
    [string writeToFile:_filepath atomically:YES encoding:NSUnicodeStringEncoding error:&error];
    
    return string;
    
}

// ;)

@end
