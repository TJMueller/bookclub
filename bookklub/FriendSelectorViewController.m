//
//  FriendSelectorViewController.m
//  bookklub
//
//  Created by Timothy Mueller on 4/1/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "FriendSelectorViewController.h"
#import "Reader.h"

@interface FriendSelectorViewController () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *friendSelectorTableView;
@property NSArray *readers;
@end

@implementation FriendSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appDelegate.managedObjectContext;
    [self load];
}


-(void)load{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Reader"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    request.sortDescriptors = @[sortDescriptor];
    self.readers = [self.moc executeFetchRequest:request error:nil];
    NSLog(@"%li",self.readers.count);
    [self.friendSelectorTableView reloadData];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.readers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    Reader *r = self.readers[indexPath.row];
    if (r.friend == YES) {
        cell.backgroundColor = [UIColor colorWithRed:0.000 green:1.000 blue:0.000 alpha:0.260];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.260];
    }
    cell.textLabel.text = r.name;
    NSLog(@" why %i",r.friend);
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Reader *reader = self.readers[indexPath.row];
    if (reader.friend == YES) {
        NSLog(@"friend = no");
        reader.friend = NO;
    } else {
        reader.friend = YES;
    }

    [self.moc save:nil];
    [self load];
    [self.friendSelectorTableView reloadData];
}

@end
