/*
 *  PGVPMoneyView.m
 *  ===============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of class to contain the bet and cash views in a video poker game.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPMoneyView.h"
#import "PGVPBetView.h"
#import "PGVPCashView.h"


@implementation PGVPMoneyView
{
    PGVPBetView * _betView;
    PGVPCashView * _cashView;
}


+ (id)objectWithBet:(int)bet andCash:(int)cash
{
    return [[PGVPMoneyView alloc] initWithBet:bet andCash:cash];
}


- (instancetype)initWithBet:(int)bet andCash:(int)cash
{
    self = [super init];
    if ( self ) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _betView = [PGVPBetView objectWithAmount:bet];
        _cashView = [PGVPCashView objectWithAmount:cash];
        
        [self addSubview:_betView];
        [self addSubview:_cashView];
        
        
        //  Horizontally layout sub views
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_cashView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_betView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_betView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:_cashView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        
        //  Vertically layout sub views
        
        NSLayoutConstraint * minimizeHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:0];
        minimizeHeight.priority = 1;
        [self addConstraint:minimizeHeight];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_cashView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_cashView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_betView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_cashView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_betView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    }
    return self;
}


- (void)setBetAmount:(int)amount
{
    [_betView setAmount:amount];
}


- (void)setCashAmount:(int)amount
{
    [_cashView setAmount:amount];
}


- (void)enable:(BOOL)status
{
    self.userInteractionEnabled = status;
}


@end
