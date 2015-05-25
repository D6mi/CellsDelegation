//
//  TestTableViewCell.m
//  CellsDelegation
//
//  Created by Domagoj Kulundžić on 22/05/15.
//  Copyright (c) 2015 Domagoj Kulundžić. All rights reserved.
//

#import "TestTableViewCell.h"

@interface TestTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UISwitch *mainSwitch;


@end

@implementation TestTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupCellWithTitle:(NSString *)title state:(BOOL)state indexPath:(NSIndexPath *)indexPath delegate:(id<TestTableViewCellDelegate>)delegate {
    self.labelTitle.text = title;
    self.mainSwitch.on = state;
    
    self.indexPath = indexPath;
    self.delegate = delegate;
}

- (IBAction)switchTapped:(UISwitch *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(testTableViewCell:didChangeState:forIndexPath:)]) {
        [self.delegate testTableViewCell:self didChangeState:sender.on forIndexPath:self.indexPath];
    }
}

@end
