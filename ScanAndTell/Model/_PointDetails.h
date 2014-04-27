// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PointDetails.h instead.

#import <CoreData/CoreData.h>


extern const struct PointDetailsAttributes {
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *poiDescription;
} PointDetailsAttributes;

extern const struct PointDetailsRelationships {
	__unsafe_unretained NSString *master;
} PointDetailsRelationships;

extern const struct PointDetailsFetchedProperties {
} PointDetailsFetchedProperties;

@class PointMaster;





@interface PointDetailsID : NSManagedObjectID {}
@end

@interface _PointDetails : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PointDetailsID*)objectID;





@property (nonatomic, strong) NSNumber* latitude;



@property double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* longitude;



@property double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* poiDescription;



//- (BOOL)validatePoiDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) PointMaster *master;

//- (BOOL)validateMaster:(id*)value_ error:(NSError**)error_;





@end

@interface _PointDetails (CoreDataGeneratedAccessors)

@end

@interface _PointDetails (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;




- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;




- (NSString*)primitivePoiDescription;
- (void)setPrimitivePoiDescription:(NSString*)value;





- (PointMaster*)primitiveMaster;
- (void)setPrimitiveMaster:(PointMaster*)value;


@end
