//
//  FPVMapViewController.h
//  UILibraryDemo
//
//  Created by Kate Mason on 2017-08-01.
//  Copyright © 2017 DJI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <DJIUILibrary/DJIUILibrary.h>
#import <DJISDK/DJISDK.h>

@interface FPVMapViewController : UIViewController
- (IBAction)BacktoHome:(id)sender;


@property(nonatomic, readonly) BOOL areMotorsOn;

// Method declarations

// Flight log method call

-(void)FlightLogs:(id)sender;
-(BOOL)motorsOn;

@end
