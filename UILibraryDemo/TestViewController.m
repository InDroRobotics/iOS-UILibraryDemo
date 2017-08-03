//
//  TestViewController.m
//  UILibraryDemo
//
//  Created by Kate Mason on 2017-07-20.
//  Copyright © 2017 DJI. All rights reserved.
//
//
//
// View Controller to control the Flight Logs View. The view is accessed through the DefaultLayoutView Controller via a segue that is trigger by a button.

//Add libraries and headerfiles

#import "TestViewController.h"
#import "InDroSavetoFile.h"
#import <DJISDK/DJISDK.h>



@interface TestViewController ()


@end

@implementation TestViewController

//setup to ensure the view had loaded. Use this for all ViewController files

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


// Back button
- (IBAction)backbutton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Flight Logs Method call. This method calls the InDroSavetoFile header and implementation files to get the values of the parameters we want. Here we are initializing the class so we can use it then calling th SaveFlightLogs method in it

 
- (IBAction)log:(id)sender {
    
    InDroSavetoFile *logs = [[InDroSavetoFile alloc]init];
    [logs GetFlightData];
   // printf("Saved Flight Logs"); // For debugging
}
@end


