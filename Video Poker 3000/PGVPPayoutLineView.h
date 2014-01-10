//
//  PGVPPayoutLineView.h
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/9/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGVPPokerMachineDelegate.h"
#import "PGCardsPokerHandInfo.h"

@interface PGVPPayoutLineView : UIView

@property (strong, nonatomic, readonly) UILabel * handLabel;
@property (strong, nonatomic, readonly) UILabel * payoutLabel;


- (instancetype)initWithHandType:(enum PGCardsVideoPokerHandType)handType andDelegate:(id<PGVPPokerMachineDelegate>)delegate;

@end
