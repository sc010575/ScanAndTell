// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PropertyDetails.m instead.

#import "_PropertyDetails.h"

const struct PropertyDetailsAttributes PropertyDetailsAttributes = {
	.city = @"city",
	.county = @"county",
	.dateOfTransfer = @"dateOfTransfer",
	.district = @"district",
	.duration = @"duration",
	.locality = @"locality",
	.oldOrNew = @"oldOrNew",
	.postCode = @"postCode",
	.price = @"price",
	.propertyType = @"propertyType",
	.street = @"street",
};

const struct PropertyDetailsRelationships PropertyDetailsRelationships = {
};

const struct PropertyDetailsFetchedProperties PropertyDetailsFetchedProperties = {
};

@implementation PropertyDetailsID
@end

@implementation _PropertyDetails

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PropertyDetails" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PropertyDetails";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PropertyDetails" inManagedObjectContext:moc_];
}

- (PropertyDetailsID*)objectID {
	return (PropertyDetailsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic city;






@dynamic county;






@dynamic dateOfTransfer;






@dynamic district;






@dynamic duration;






@dynamic locality;






@dynamic oldOrNew;






@dynamic postCode;






@dynamic price;



- (double)priceValue {
	NSNumber *result = [self price];
	return [result doubleValue];
}

- (void)setPriceValue:(double)value_ {
	[self setPrice:[NSNumber numberWithDouble:value_]];
}

- (double)primitivePriceValue {
	NSNumber *result = [self primitivePrice];
	return [result doubleValue];
}

- (void)setPrimitivePriceValue:(double)value_ {
	[self setPrimitivePrice:[NSNumber numberWithDouble:value_]];
}





@dynamic propertyType;






@dynamic street;











@end
