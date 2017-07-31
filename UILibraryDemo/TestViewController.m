//
//  TestViewController.m
//  UILibraryDemo
//
//  Created by Gord Mason on 2017-07-20.
//  Copyright © 2017 DJI. All rights reserved.
//

#import "TestViewController.h"
#import "InDroSavetoFile.h"
#import <DJISDK/DJISDK.h>

@interface TestViewController ()


@end

@implementation TestViewController

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



- (IBAction)backbutton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)FlightLogs{
    InDroSavetoFile *logs = [[InDroSaveToFile alloc]init];
    [logs SaveFlightLogs];
    
}

@end

// - (void)first:(NSString *)fname second:(NSString *)mname third:(NSString *)lname;
