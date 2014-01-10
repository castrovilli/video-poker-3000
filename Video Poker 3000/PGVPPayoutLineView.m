//
//  PGVPPayoutLineView.m
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/9/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import "PGVPPayoutLineView.h"


static const CGFloat innerMargin = 5;
static const CGFloat kPGVPFontSize = 12;

@implementation PGVPPayoutLineView {
    id<PGVPPokerMachineDelegate> _delegate;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithHandType:(enum PGCardsVideoPokerHandType)handType andDelegate:(id<PGVPPokerMachineDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        
        NSArray * handNames = @[
                                @"No Win",
                                @"Jacks or Better",
                                @"Two Pair",
                                @"Three of a Kind",
                                @"Straight",
                                @"Flush",
                                @"Full House",
                                @"Four of a Kind",
                                @"Straight Flush",
                                @"Royal Flush"
                                ];

        
        _handLabel = [UILabel new];
        _payoutLabel = [UILabel new];
        _handLabel.text = handNames[handType];
        _payoutLabel.text = [NSString stringWithFormat:@"%ix", [_delegate getPayoutRatioForHand:handType]];
        [_handLabel setFont:[UIFont systemFontOfSize:[UIFont smallSystemFontSize]]];
        [_payoutLabel setFont:[UIFont systemFontOfSize:[UIFont smallSystemFontSize]]];
        
        [_handLabel sizeToFit];
        [_payoutLabel sizeToFit];
        
        _handLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _payoutLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:_handLabel];
        [self addSubview:_payoutLabel];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_handLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_handLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_handLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        //[self addConstraint:[NSLayoutConstraint constraintWithItem:_handLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_payoutLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:innerMargin]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_payoutLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_handLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_payoutLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_handLabel attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_payoutLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-0]];
        
        
    }
    return self;
}


- (CGSize)intrinsicContentSize
{
    CGSize intrinsicSize;
    intrinsicSize.width = _handLabel.bounds.size.width + _payoutLabel.bounds.size.width + innerMargin;
    intrinsicSize.height = _handLabel.bounds.size.height;
    return intrinsicSize;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
