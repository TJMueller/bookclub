//
//  FriendsViewController.m
//  bookklub
//
//  Created by Timothy Mueller on 4/1/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "FriendsViewController.h"
#import "Reader.h"
#import "AppDelegate.h"


@interface FriendsViewController () <UITableViewDelegate,UITableViewDataSource>
@property NSManagedObjectContext *moc;
@property NSArray *readers;
@property (strong, nonatomic) IBOutlet UITableView *friendsTableView;

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appDelegate.managedObjectContext;
    [self load];


}

-(void)load{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Reader"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    if ([self.moc executeFetchRequest:request error:nil] == 0) {
        [Reader readersFromJSON:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/18/friends.json" inManagedObjectContext:self.moc];
    }
    request.predicate = [NSPredicate predicateWithFormat:@"friend == %@", [NSNumber numberWithBool: YES]];
    request.sortDescriptors = @[sortDescriptor];
    self.readers = [self.moc executeFetchRequest:request error:nil];
    [self.friendsTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.readers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    Reader *r = self.readers[indexPath.row];
    cell.textLabel.text = r.name;
    r.friend = [NSNumber numberWithBool:NO];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FriendSelectorViewController *vc = segue.destinationViewController;
    vc.moc = self.moc;
}

-(void)viewWillAppear:(BOOL)animated {
    [self load];
    [self.friendsTableView reloadData];

}

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
