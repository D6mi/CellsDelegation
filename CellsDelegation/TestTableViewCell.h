//
//  TestTableViewCell.h
//  CellsDelegation
//
//  Created by Domagoj Kulundžić on 22/05/15.
//  Copyright (c) 2015 Domagoj Kulundžić. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestTableViewCell;

@protocol TestTableViewCellDelegate <NSObject>
@optional
- (void)testTableViewCell:(TestTableViewCell *)cell didChangeState:(BOOL)state forIndexPath:(NSIndexPath *)indexPath;
@end

@interface TestTableViewCell : UITableViewCell

@property (weak, nonatomic) id<TestTableViewCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;

- (void)setupCellWithTitle:(NSString *)title state:(BOOL)state indexPath:(NSIndexPath *)indexPath delegate:(id<TestTableViewCellDelegate>)delegate;

@end
