/*
 *  PGVPPayoutTableView.m
 *  =====================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of payout table view class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPPayoutTableView.h"
#import "PGVPPayoutLineView.h"


/**
 Constant for inner margin dimension.
 */
static const CGFloat kPGVPInnerMargin = 5;


@implementation PGVPPayoutTableView
{
    /**
     The poker machine delegate.
     */
    id<PGVPPokerMachineDelegate> _delegate;
    
    /**
     An array of labels for individual hand payouts.
     */
    NSArray * _handLabels;
    
    /**
     A label containing the view's title.
     */
    UILabel * _titleLabel;
}


- (id)initWithDelegate:(id<PGVPPokerMachineDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        //  Set basic options and delegate
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        _delegate = delegate;
        self.backgroundColor = [UIColor colorWithRed:.4801 green:.8203 blue:.3672 alpha:.2];
        
        
        //  Create a container view
        
        UIView * container = [UIView new];
        container.translatesAutoresizingMaskIntoConstraints = NO;
        container.backgroundColor = nil;
        [self addSubview:container];
        
        
        //  Add view constraints for the container view
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:kPGVPInnerMargin]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-kPGVPInnerMargin]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        
        //  Prepare to initialize the array of hand lines
        
        PGVPPayoutLineView * currentLine = nil;
        PGVPPayoutLineView * previousLine = nil;
        NSMutableArray * hands = [NSMutableArray new];
        
        
        //  Set a low priority constraint to minimize the width of the payout table view within the container
        
        NSLayoutConstraint * minWidthConstraint = [NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:0];
        minWidthConstraint.priority = 1;
        [container addConstraint:minWidthConstraint];
        
        
        //  Create the array of hand lines
        
        for ( enum PGCardsVideoPokerHandType handType = 1; handType < 10; ++handType ) {
            currentLine = [[PGVPPayoutLineView alloc] initWithHandType:handType andDelegate:_delegate];
            [container addSubview:currentLine];
            [hands addObject:currentLine];
            
            if ( previousLine ) {
                
                //  Align new line vertically with previous line, and align horizontally between the labels...
                [container addConstraint:[NSLayoutConstraint constraintWithItem:currentLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:previousLine attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
                [container addConstraint:[NSLayoutConstraint constraintWithItem:currentLine.payoutLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:previousLine.payoutLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
                
            } else {
                
                //  ...or just add the first line.
                
                [container addConstraint:[NSLayoutConstraint constraintWithItem:currentLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
            }

            //  Align the entire line within the payout table view within the container
            
            [container addConstraint:[NSLayoutConstraint constraintWithItem:currentLine.handLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:currentLine.payoutLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:-5]];
            [container addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationLessThanOrEqual toItem:currentLine attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
            [container addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:currentLine attribute:NSLayoutAttributeRight multiplier:1 constant:0]];

            previousLine = currentLine;
        }
        
        _handLabels = [NSArray arrayWithArray:hands];
       
        
        //  Create the table title label
        
        _titleLabel = [UILabel new];
        _titleLabel.text = @"Payout Table";
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]]];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_titleLabel sizeToFit];
        [container addSubview:_titleLabel];
        
        
        //  Add constraints to align the table title label
        
        [container addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [container addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:currentLine attribute:NSLayoutAttributeTop multiplier:1 constant:-6]];
        [container addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    }
    return self;
}


- (void)updatePayoutLabels
{
    for ( PGVPPayoutLineView * lineView in _handLabels ) {
        [lineView updatePayoutLabel];
    }
}


@end
