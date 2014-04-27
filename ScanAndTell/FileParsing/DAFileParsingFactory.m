//
//  DAFileParsingFactory.m
//  ScanAndTell
//
//  Created by Suman Chatterjee on 17/04/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DAFileParsingFactory.h"
#import "PropertyDetails.h"
#import "DAFileParsing.h"
#import "chcsvparser.h"

@implementation DAFileParsingFactory

+(void)parseFactory
{
    dispatch_queue_t parsingQueue = dispatch_queue_create("com.da.parsing", NULL);
    dispatch_async(parsingQueue, ^{
        if (![PropertyDetails MR_countOfEntities]) {
            [DAFileParsingFactory performParse];
        }
        else{
            NSLog(@"Complete loading");
   //      PropertyDetails *recent =   [ DAFileParsingFactory performQueryincontext];
            
     //       NSLog(@"address city = %@ county = %@ postCode = %@", recent.city,recent.county, recent.postCode);
            
        }
    });
    
}

+(PropertyDetails*) performQueryincontext
{
//   NSArray *purchases = [PropertyDetails MR_findAll];
  //  PropertyDetails *recent = purchases[1];
    
    NSString * t = @"SP3 6EE";
    NSPredicate *purchasePredicate = [NSPredicate predicateWithFormat:@"postCode == %@",t];
    PropertyDetails *recent = [[PropertyDetails MR_findAllWithPredicate:purchasePredicate]  firstObject];
    
    return  recent;
}

+(void) performParse
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        
        DAFileParsing *parser = [[DAFileParsing alloc] init];
        [parser parseFileInContext:localContext];
        
    }completion:^(BOOL success, NSError *error) {
        
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Suman Parsing complete");
            });
        }
        
    }];
}

@end
