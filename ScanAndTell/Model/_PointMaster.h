// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PointMaster.h instead.

#import <CoreData/CoreData.h>


extern const struct PointMasterAttributes {
	__unsafe_unretained NSString *productID;
	__unsafe_unretained NSString *productName;
} PointMasterAttributes;

extern const struct PointMasterRelationships {
	__unsafe_unretained NSString *points;
} PointMasterRelationships;

extern const struct PointMasterFetchedProperties {
} PointMasterFetchedProperties;

@class PointDetails;




@interface PointMasterID : NSManagedObjectID {}
@end

@interface _PointMaster : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PointMasterID*)objectID;





@property (nonatomic, strong) NSString* productID;



//- (BOOL)validateProductID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* productName;



//- (BOOL)validateProductName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *points;

- (NSMutableSet*)pointsSet;





@end

@interface _PointMaster (CoreDataGeneratedAccessors)

- (void)addPoints:(NSSet*)value_;
- (void)removePoints:(NSSet*)value_;
- (void)addPointsObject:(PointDetails*)value_;
- (void)removePointsObject:(PointDetails*)value_;

@end

@interface _PointMaster (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveProductID;
- (void)setPrimitiveProductID:(NSString*)value;




- (NSString*)primitiveProductName;
- (void)setPrimitiveProductName:(NSString*)value;





- (NSMutableSet*)primitivePoints;
- (void)setPrimitivePoints:(NSMutableSet*)value;


@end
