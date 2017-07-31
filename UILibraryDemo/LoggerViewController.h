//
//  ViewController.h
//  UILibraryDemo
//
//  Created by Gord Mason on 2017-07-19.
//  Copyright © 2017 DJI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DJIUILibrary/DJIUILibrary.h>
#import <DJISDK/DJISDK.h>


@interface LoggerViewController : UIViewController <UITextFieldDelegate>{
    
}
@property (weak, nonatomic)IBOutlet UITextField *writeSomethingField;
- (IBAction)saveTextToFile:(id)sender;
@property (weak, nonatomic)IBOutlet UILabel *displayTxtFromFile;
- (IBAction)getFromFile:(id)sender;


@end
