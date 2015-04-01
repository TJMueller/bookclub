//
//  Reader.h
//  bookklub
//
//  Created by Timothy Mueller on 4/1/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Reader : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property BOOL friend;
@property (nonatomic, retain) NSNumber * numbooks;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSSet *books;
@end

@interface Reader (CoreDataGeneratedAccessors)

- (void)addBooksObject:(NSManagedObject *)value;
- (void)removeBooksObject:(NSManagedObject *)value;
- (void)addBooks:(NSSet *)values;
- (void)removeBooks:(NSSet *)values;
+ (void)newReader:(NSString *)readerName inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)readersFromJSON:(NSString *)string inManagedObjectContext:(NSManagedObjectContext *)context;
@end
