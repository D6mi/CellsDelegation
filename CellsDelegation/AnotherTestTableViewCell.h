//
//  AnotherTestTableViewCell.h
//  CellsDelegation
//
//  Created by Domagoj Kulundžić on 22/05/15.
//  Copyright (c) 2015 Domagoj Kulundžić. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnotherTestTableViewCell;

@protocol AnotherTestTableViewCellDelegate <NSObject>
@optional
- (void)anotherTestTableViewCell:(AnotherTestTableViewCell *)cell didTapSelectionButtonAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface AnotherTestTableViewCell : UITableViewCell

@property (weak, nonatomic) id<AnotherTestTableViewCellDelegate> delegate;
- (void)setupCellWithTitle:(NSString *)title selected:(BOOL)selected delegate:(id<AnotherTestTableViewCellDelegate>)delegate;

@end
