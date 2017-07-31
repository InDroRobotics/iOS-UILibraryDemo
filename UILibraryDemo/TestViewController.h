//
//  TestViewController.h
//  UILibraryDemo
//
//  Created by Gord Mason on 2017-07-20.
//  Copyright © 2017 DJI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DJIUILibrary/DJIUILibrary.h>
#import <DJISDK/DJISDK.h>

@interface TestViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *test;
- (IBAction)backbutton:(id)sender;


-(void)FlightLogs;

@end
