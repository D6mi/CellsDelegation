//
//  TestTableViewController.m
//  CellsDelegation
//
//  Created by Domagoj Kulundžić on 22/05/15.
//  Copyright (c) 2015 Domagoj Kulundžić. All rights reserved.
//

#import "TestTableViewController.h"
#import "TestTableViewCell.h"
#import "AnotherTestTableViewCell.h"

@interface TestTableViewController () <TestTableViewCellDelegate, AnotherTestTableViewCellDelegate>

@property (strong, nonatomic) NSMutableDictionary *state;
@property (strong, nonatomic) NSArray *items;

@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *people;

@property (strong, nonatomic) NSMutableArray *selectedPeople;

@end

@implementation TestTableViewController

- (NSMutableArray *)selectedPeople {
    if(!_selectedPeople) {
        _selectedPeople = [NSMutableArray arrayWithCapacity:[self.people count]];
    }
    
    return _selectedPeople;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Cell delegation";
    
    self.tableView.estimatedRowHeight = 80.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.allowsSelection = NO;
    
    self.state = [@{@"Notifications" : @(YES),
                   @"Delivery" : @(NO),
                    @"Save data automatically" : @(YES)} mutableCopy];
    
    self.titles = @[@"Notifications", @"Delivery", @"Save data automatically"];
    self.people = [@[@"John",
                     @"Neo",
                     @"Donald Duck",
                     @"Michael Jackson",
                     @"Aco",
                     @"Arnold Švarzneger",
                     @"Gordon Freeman",
                     @"Michelle Jordan",
                     @"Nix"] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark <TestTableViewCellDelegate>
#pragma mark -

- (void)testTableViewCell:(TestTableViewCell *)cell didChangeState:(BOOL)state forIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    NSString *title = [self.titles objectAtIndex:indexPath.row];
    [self.state setObject:@(state) forKey:title];
    
    NSLog(@"State : %@", self.state);
}

#pragma mark -
#pragma mark <AnotherTestTableViewCellDelegate>
#pragma mark -

- (void)anotherTestTableViewCell:(AnotherTestTableViewCell *)cell didTapSelectionButtonAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    NSString *title = [self.people objectAtIndex:indexPath.row];
    
    if([self.selectedPeople containsObject:title]) {
        [self.selectedPeople removeObject:title];
    } else {
        [self.selectedPeople addObject:title];
    }
    
    NSLog(@"People : %@", self.selectedPeople);
}

#pragma mark -
#pragma mark <UITableViewDataSource>
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? [self.titles count] : [self.people count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        TestTableViewCell *cell = (TestTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"testTableViewCell" forIndexPath:indexPath];
        
        NSString *title = [self.titles objectAtIndex:indexPath.row];
        BOOL state = [[self.state objectForKey:title] boolValue];
        
        [cell setupCellWithTitle:title state:state indexPath:indexPath delegate:self];
        
        return cell;
    } else {
        AnotherTestTableViewCell *cell = (AnotherTestTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"anotherTestTableViewCell" forIndexPath:indexPath];
        
        NSString *title = [self.people objectAtIndex:indexPath.row];
        BOOL selected = [self.selectedPeople containsObject:title];
        
        [cell setupCellWithTitle:title selected:selected indexPath:indexPath delegate:self];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), 50.0)];
    containerView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 0.0, 100.0, 21)];
    label.text = section == 0 ? @"Settings" : @"Contacts";
    
    CGPoint newCenter = label.center;
    newCenter.y = containerView.center.y;
    label.center = newCenter;
    
    
    [containerView addSubview:label];
    
    return containerView;

}

@end
