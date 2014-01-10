//
//  PGVPPayoutTableView.h
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/9/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGVPPokerMachineDelegate.h"

@interface PGVPPayoutTableView : UIView

- (id)initWithDelegate:(id<PGVPPokerMachineDelegate>)delegate;

@end
