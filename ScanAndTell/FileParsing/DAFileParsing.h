//
//  DAFileParsing.h
//  ScanAndTell
//
//  Created by Suman Chatterjee on 16/04/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAFileParsing : NSObject

- (void)parseFileInContext:(NSManagedObjectContext*)context;

@end
