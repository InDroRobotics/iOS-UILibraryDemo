//
//  SavetoFileViewController.h
//  UILibraryDemo
//
//  Created by Gord Mason on 2017-07-19.
//  Copyright © 2017 DJI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SavetoFileViewController : NSObject {

NSFileManager *fileMgr;
NSString *homeDir;
NSString *filename;
NSString *filepath;
}

@property(nonatomic, retain)NSFileManager *fileMgr;
@property(nonatomic, retain)NSFileManager *homeDir;
@property(nonatomic, retain)NSFileManager *filename;
@property(nonatomic, retain)NSFileManager *filepath;

-(NSString *)GetDocumentDirectory;
-(void)WriteToStringFile:(NSMutableString *)testToWrite;
-(NSString *)readFromFile;
-(NSString *)setFilename;

@end


