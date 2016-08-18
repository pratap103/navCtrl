//
//  CompanyMO+CoreDataProperties.h
//  NavCtrl
//
//  Created by Pratap Pandit on 8/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CompanyMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanyMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *myURL;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *stockPrice;
@property (nullable, nonatomic, retain) NSString *stockSymbol;
@property (nullable, nonatomic, retain) NSNumber *position;
@property (nullable, nonatomic, retain) NSOrderedSet<ProductMO *> *products;

@end

@interface CompanyMO (CoreDataGeneratedAccessors)

- (void)insertObject:(ProductMO *)value inProductsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromProductsAtIndex:(NSUInteger)idx;
- (void)insertProducts:(NSArray<ProductMO *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeProductsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInProductsAtIndex:(NSUInteger)idx withObject:(ProductMO *)value;
- (void)replaceProductsAtIndexes:(NSIndexSet *)indexes withProducts:(NSArray<ProductMO *> *)values;
- (void)addProductsObject:(ProductMO *)value;
- (void)removeProductsObject:(ProductMO *)value;
- (void)addProducts:(NSOrderedSet<ProductMO *> *)values;
- (void)removeProducts:(NSOrderedSet<ProductMO *> *)values;

@end

NS_ASSUME_NONNULL_END
