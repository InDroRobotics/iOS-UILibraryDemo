//
//  TestViewController.h
//  UILibraryDemo
//
//  Created by Kate Mason on 2017-07-20.
//  Copyright © 2017 DJI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DJIUILibrary/DJIUILibrary.h>
#import <DJISDK/DJISDK.h>

@interface TestViewController : UIViewController
- (IBAction)backbutton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *testlabel;
@property(nonatomic, readonly) BOOL areMotorsOn;
- (IBAction)log:(id)sender;

// Method declarations

// Flight log method call


@end
