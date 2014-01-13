/*
 *  PGVPPayoutLineView.m
 *  ====================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of class representing a line within the payout table.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPPayoutLineView.h"


/**
 Constant for inner margin dimension.
 */
static const CGFloat innerMargin = 5;


@implementation PGVPPayoutLineView
{
    /**
     The poker machine delegate.
     */
    id<PGVPPokerMachineDelegate> _delegate;
    
    /**
     The hand type for this line.
     */
    enum PGCardsVideoPokerHandType _handType;
}


- (instancetype)initWithHandType:(enum PGCardsVideoPokerHandType)handType andDelegate:(id<PGVPPokerMachineDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _handType = handType;
        
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
        _handLabel.text = handNames[_handType];
        _payoutLabel.text = [NSString stringWithFormat:@"%ix", [_delegate getPayoutRatioForHand:_handType]];
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
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_payoutLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_handLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_payoutLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_handLabel attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_payoutLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-0]];
        
        
    }
    return self;
}


- (void)updatePayoutLabel
{
    _payoutLabel.text = [NSString stringWithFormat:@"%ix", [_delegate getPayoutRatioForHand:_handType]];
}


- (CGSize)intrinsicContentSize
{
    CGSize intrinsicSize;
    intrinsicSize.width = _handLabel.bounds.size.width + _payoutLabel.bounds.size.width + innerMargin;
    intrinsicSize.height = _handLabel.bounds.size.height;
    return intrinsicSize;
}


@end
