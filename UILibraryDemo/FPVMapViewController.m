//
//  FPVMapViewController.m
//  UILibraryDemo
//
//  Created by Gord Mason on 2017-08-01.
//  Copyright © 2017 DJI. All rights reserved.
//
//Add libraries and headerfiles

#import "InDroSavetoFile.h"
#import <DJISDK/DJISDK.h>
#import "FPVMapViewController.h"

@interface FPVMapViewController ()

@end

@implementation FPVMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BacktoHome:(id)sender {
}

// Flight Logs Method call. This method calls the InDroSavetoFile header and implementation files to get the values of the parameters we want. Here we are initializing the class so we can use it then calling th SaveFlightLogs method in it


-(BOOL)motorsOn{
    DJIKeyManager *keyManager = [DJISDKManager keyManager];
    DJIFlightControllerKey *motorsonLevelKey = [DJIFlightControllerKey keyWithParam:DJIFlightControllerParamAreMotorsOn];
    
    
    [keyManager getValueForKey:motorsonLevelKey
                withCompletion:^(DJIKeyedValue * _Nullable value, NSError * _Nullable error)
     
     
     {
         if (error || value == nil) {
             // insert graceful error handling here.
             
             NSLog(@"Error getting Motors On Level Key");
         } else {
             // DJIBatteryParamChargeRemainingInPercent is associated with a uint8_t value
             
             BOOL motorsonLevel = value.boolValue;
             
             
             _areMotorsOn = motorsonLevel;
             printf("motorsonLevel = _aremotorsOn"); // For debugging
             
         }
     }];
    
    
    return _areMotorsOn;
    
    
}

-(void)FlightLogs:(id)sender{
    
    
    
    while ((_areMotorsOn)) {
        
        InDroSavetoFile *logs = [[InDroSavetoFile alloc]init];
        [logs GetFlightData];
        printf("Saved Flight Logs"); // For debugging
        
    }
}


@end
