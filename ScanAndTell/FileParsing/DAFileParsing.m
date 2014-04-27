//
//  DAFileParsing.m
//  ScanAndTell
//
//  Created by Suman Chatterjee on 16/04/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DAFileParsing.h"
#import <KCOrderedAccessorFix/NSManagedObjectModel+KCOrderedAccessorFix.h>
#import "PropertyDetails.h"
#import "chcsvparser.h"

@implementation DAFileParsing

- (void) parseFileInContext:(NSManagedObjectContext*)context
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pp-2012" ofType:@"csv"];
 //   NSString *csvString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *locations = [NSArray arrayWithContentsOfCSVFile:filePath options:CHCSVParserOptionsRecognizesBackslashesAsEscapes];
    
    
//    NSArray *locations = [csvString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for (NSArray * location in locations)
    {
        NSLog(@"count %lu",(unsigned long)location.count);
//        if([location isEqualToString:@""])
//            continue;
  //      NSLog(@"String is %@", location[3]);
   //     NSString *removeComma = [[location componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@","];
   //     NSLog(@"String is %@", removeComma);

    //    NSArray *components = [location componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\\,"]];
     //   [location componentsSeparatedByString:@","];
        //NSLog(@"array is %@ %@", com6ponents[1],components[3]);
     //   if(components.count == 0 )
    //        continue;
        if(location != nil && location.count > 1){
            NSLog(@"String is %@", location[3]);
            [self storeInDatabase:location inContext:context];
        }
        
        
    }
    
}


-(void) storeInDatabase:(NSArray*) record inContext:(NSManagedObjectContext*)context
{
    PropertyDetails *propertyDetails = [PropertyDetails MR_createInContext:context];
    propertyDetails.price = [NSNumber numberWithDouble:[record[1] doubleValue]];
    propertyDetails.postCode = record[3];
    propertyDetails.dateOfTransfer = dateFromString(record[2],nil);
    propertyDetails.propertyType = record[4];
    propertyDetails.oldOrNew = record[5];
    propertyDetails.duration = record[6];
    propertyDetails.street = record[9];
    propertyDetails.locality = record[10];
    propertyDetails.city = record[11];
    propertyDetails.district = record[12];
    propertyDetails.county = record[13];
}
@end
