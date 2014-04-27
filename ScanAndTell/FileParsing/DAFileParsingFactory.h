//
//  DAFileParsingFactory.h
//  ScanAndTell
//
//  Created by Suman Chatterjee on 17/04/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyDetails.h"

@interface DAFileParsingFactory : NSObject

+(void)parseFactory;
+(PropertyDetails*) performQueryincontext:(NSManagedObjectContext *)localContext;

@end
