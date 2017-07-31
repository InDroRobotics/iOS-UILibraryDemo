//
//  ViewController.m
//  UILibraryDemo
//
//  Created by Gord Mason on 2017-07-19.
//  Copyright © 2017 DJI. All rights reserved.
//

#import "LoggerViewController.h"
#import "SaveToFile.h"


@interface LoggerViewController ()
- (IBAction)onbackbuttonclicked:(id)sender;

@end

@implementation LoggerViewController
@synthesize displayTxtFromFile;
@synthesize writeSomethingField;

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    //Release any cached data, images, ect that aren't in use.
}

#pragma mark - View Lifestyle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (void)viewDidUnload{
//    [self setWriteSomethingField:nil];
//    [self setDisplayTxtFromFile:nil];
//    [super viewDidUnload];
//    
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (BOOL) textFieldShouldReturn:(UITextField *)aTxtFld{
    if(aTxtFld ==self.writeSomethingField){
        [aTxtFld resignFirstResponder];
    }
    return YES;
}

- (IBAction)getFromFile:(id)sender {
    SaveToFile *readFile = [[SaveToFile alloc]init];
    self.displayTxtFromFile.text = [readFile readFromFile];
}

- (IBAction)saveTextToFile:(id)sender {
    SaveToFile *files = [[SaveToFile alloc]init];
    [files WriteToStringFile:[self.writeSomethingField.text mutableCopy]];
}

- (IBAction)onbackbuttonclicked:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
