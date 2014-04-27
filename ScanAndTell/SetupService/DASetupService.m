//
//  DASetupService.m
//  ScanAndTell
//
//  Created by Suman Chatterjee on 31/03/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DASetupService.h"
#import <CoreData+MagicalRecord.h>
#import <KCOrderedAccessorFix/NSManagedObjectModel+KCOrderedAccessorFix.h>

@implementation DASetupService

+(void) setupCoredata
{
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"ScanModel.sqlite"];
    [[NSManagedObjectModel MR_defaultManagedObjectModel] kc_generateOrderedSetAccessors];  //This line fixes bugs that occur adding objects to an ordered relationship
}

@end
