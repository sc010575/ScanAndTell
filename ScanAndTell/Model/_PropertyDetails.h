// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PropertyDetails.h instead.

#import <CoreData/CoreData.h>


extern const struct PropertyDetailsAttributes {
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *county;
	__unsafe_unretained NSString *dateOfTransfer;
	__unsafe_unretained NSString *district;
	__unsafe_unretained NSString *duration;
	__unsafe_unretained NSString *locality;
	__unsafe_unretained NSString *oldOrNew;
	__unsafe_unretained NSString *postCode;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *propertyType;
	__unsafe_unretained NSString *street;
} PropertyDetailsAttributes;

extern const struct PropertyDetailsRelationships {
} PropertyDetailsRelationships;

extern const struct PropertyDetailsFetchedProperties {
} PropertyDetailsFetchedProperties;














@interface PropertyDetailsID : NSManagedObjectID {}
@end

@interface _PropertyDetails : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PropertyDetailsID*)objectID;





@property (nonatomic, strong) NSString* city;



//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* county;



//- (BOOL)validateCounty:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* dateOfTransfer;



//- (BOOL)validateDateOfTransfer:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* district;



//- (BOOL)validateDistrict:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* duration;



//- (BOOL)validateDuration:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* locality;



//- (BOOL)validateLocality:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* oldOrNew;



//- (BOOL)validateOldOrNew:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* postCode;



//- (BOOL)validatePostCode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* price;



@property double priceValue;
- (double)priceValue;
- (void)setPriceValue:(double)value_;

//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* propertyType;



//- (BOOL)validatePropertyType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* street;



//- (BOOL)validateStreet:(id*)value_ error:(NSError**)error_;






@end

@interface _PropertyDetails (CoreDataGeneratedAccessors)

@end

@interface _PropertyDetails (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;




- (NSString*)primitiveCounty;
- (void)setPrimitiveCounty:(NSString*)value;




- (NSDate*)primitiveDateOfTransfer;
- (void)setPrimitiveDateOfTransfer:(NSDate*)value;




- (NSString*)primitiveDistrict;
- (void)setPrimitiveDistrict:(NSString*)value;




- (NSString*)primitiveDuration;
- (void)setPrimitiveDuration:(NSString*)value;




- (NSString*)primitiveLocality;
- (void)setPrimitiveLocality:(NSString*)value;




- (NSString*)primitiveOldOrNew;
- (void)setPrimitiveOldOrNew:(NSString*)value;




- (NSString*)primitivePostCode;
- (void)setPrimitivePostCode:(NSString*)value;




- (NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSNumber*)value;

- (double)primitivePriceValue;
- (void)setPrimitivePriceValue:(double)value_;




- (NSString*)primitivePropertyType;
- (void)setPrimitivePropertyType:(NSString*)value;




- (NSString*)primitiveStreet;
- (void)setPrimitiveStreet:(NSString*)value;




@end
