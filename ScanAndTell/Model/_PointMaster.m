// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PointMaster.m instead.

#import "_PointMaster.h"

const struct PointMasterAttributes PointMasterAttributes = {
	.productID = @"productID",
	.productName = @"productName",
};

const struct PointMasterRelationships PointMasterRelationships = {
	.points = @"points",
};

const struct PointMasterFetchedProperties PointMasterFetchedProperties = {
};

@implementation PointMasterID
@end

@implementation _PointMaster

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PointMaster" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PointMaster";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PointMaster" inManagedObjectContext:moc_];
}

- (PointMasterID*)objectID {
	return (PointMasterID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic productID;






@dynamic productName;






@dynamic points;

	
- (NSMutableSet*)pointsSet {
	[self willAccessValueForKey:@"points"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"points"];
  
	[self didAccessValueForKey:@"points"];
	return result;
}
	






@end
