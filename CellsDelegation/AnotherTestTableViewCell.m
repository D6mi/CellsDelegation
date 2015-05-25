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

- (void)setupCellWithTitle:(NSString *)title selected:(BOOL)selected indexPath:(NSIndexPath *)indexPath delegate:(id<AnotherTestTableViewCellDelegate>)delegate {
    self.labelTitle.text = title;
    
    [self.buttonSelection setTitle:@"Select" forState:UIControlStateNormal];
    [self.buttonSelection setTitle:@"Selected" forState:UIControlStateSelected];
    
    self.buttonSelection.selected = selected;
    
    self.indexPath = indexPath;
    self.delegate = delegate;
}

- (IBAction)buttonTapped:(UIButton *)sender {
    self.buttonSelection.selected = !self.buttonSelection.selected;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(anotherTestTableViewCell:didTapSelectionButtonAtIndexPath:)]) {
        [self.delegate anotherTestTableViewCell:self didTapSelectionButtonAtIndexPath:self.indexPath];
    }
}

@end
