//
//  Comments.h
//  bookklub
//
//  Created by Timothy Mueller on 4/1/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Comments : NSManagedObject

@property (nonatomic, retain) NSString * comements;
@property (nonatomic, retain) NSManagedObject *book;

@end
