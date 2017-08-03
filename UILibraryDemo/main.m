//
//  main.m
//  UILibraryDemo
//
//  Created by DJI on 15/4/2017.
//  Copyright © 2017 DJI. All rights reserved.
//
// Edited by Kate Mason Aug 1st 2017


// Import Libraries and Header Files
#import <UIKit/UIKit.h>
#import <DJISDK/DJISDK.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "InDroSavetoFile.h"


//Variable Declarations
BOOL _areMotorsOn;

int main(int argc, char * argv[]) {
    
    // This is the default function in main. Looks like it's to release something. Not sure though
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));

    }
}


