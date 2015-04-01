//
//  Reader.m
//  bookklub
//
//  Created by Timothy Mueller on 4/1/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "Reader.h"


@implementation Reader

@dynamic name;
@dynamic friend;
@dynamic numbooks;
@dynamic picture;
@dynamic books;

+ (void)newReader:(NSString *)readerName inManagedObjectContext:(NSManagedObjectContext *)context {
    Reader * reader = (Reader *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Reader class]) inManagedObjectContext:context];
    reader.name = readerName;
    reader.friend = NO;
    NSLog(@"%i",reader.friend);

    [context save:nil];
}

+ (void)readersFromJSON:(NSString *)string inManagedObjectContext:(NSManagedObjectContext *)context{

    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSArray *temp = [NSArray new];
        temp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        for (NSString *string in temp) {
            [self newReader:string inManagedObjectContext:context];
        }
    }];
}


@end
