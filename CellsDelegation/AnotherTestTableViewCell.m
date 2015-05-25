//
//  AnotherTestTableViewCell.m
//  CellsDelegation
//
//  Created by Domagoj Kulundžić on 22/05/15.
//  Copyright (c) 2015 Domagoj Kulundžić. All rights reserved.
//

#import "AnotherTestTableViewCell.h"

@interface AnotherTestTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *buttonSelection;

@end

@implementation AnotherTestTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupCellWithTitle:(NSString *)title selected:(BOOL)selected delegate:(id<AnotherTestTableViewCellDelegate>)delegate {
    self.labelTitle.text = title;
    
    [self.buttonSelection setTitle:@"Select" forState:UIControlStateNormal];
    [self.buttonSelection setTitle:@"Selected" forState:UIControlStateSelected];
    
    self.buttonSelection.selected = selected;
    self.delegate = delegate;
}

- (IBAction)buttonTapped:(UIButton *)sender {
    self.buttonSelection.selected = !self.buttonSelection.selected;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(anotherTestTableViewCell:didTapSelectionButtonAtIndexPath:)]) {
        NSTimeInterval start = CACurrentMediaTime();
        NSIndexPath *indexPath = [self retrieveIndexPath];
        NSLog(@"It took %f seconds to determine the index path.", (CACurrentMediaTime() - start) * 1000);
        
        [self.delegate anotherTestTableViewCell:self didTapSelectionButtonAtIndexPath:indexPath];
    }
}

/**
 Another way of determining which NSIndexPath relates to this particular cell - we query the parent table view of this cell.
 */
- (NSIndexPath *)retrieveIndexPath {
    UITableView *parentTableView = [self findParentTableViewOfView:self];
    
    if(parentTableView) {
        NSIndexPath *indexPath = [parentTableView indexPathForCell:self];
        
        NSLog(@"[%ld, %ld]", (long)indexPath.row, (long)indexPath.section);
        
        return indexPath;
    } else {
        return nil;
    }
}

/**
 Iterate recursively through each superview of this cell, in order to find the table view.
 */
- (UITableView *)findParentTableViewOfView:(UIView *)view {
    if([view.superview isKindOfClass:[UITableView class]]) {
        return (UITableView *)view.superview;
    } else {
        return [self findParentTableViewOfView:view.superview];
    }
}

@end
