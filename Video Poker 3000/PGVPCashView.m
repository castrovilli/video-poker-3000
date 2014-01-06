/*
 *  PGVPCashView.m
 *  ==============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of class to show the current cash in a video poker game.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPCashView.h"


/**
 Margin between the title label and the left bound of the view.
 */
static const CGFloat kPGVPSideMargin = 20;


@interface PGVPCashView ()

/**
 Formats a cash amount in a currency format.
 */
- (NSString *)formatAmount:(int)amount;

@end


@implementation PGVPCashView {
    /**
     Label to contain the title.
     */
    UILabel * _titleLabel;
    
    /**
     Label to contain the cash amount.
     */
    UILabel * _amountLabel;
}


+ (id)objectWithAmount:(int)amount
{
    return [[PGVPCashView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andAmount:amount];
}


- (id)initWithFrame:(CGRect)frame andAmount:(int)amount
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _titleLabel = [UILabel new];
        _titleLabel.text = @"Cash:";
        [_titleLabel sizeToFit];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_titleLabel];
        
        _amountLabel = [UILabel new];
        _amountLabel.text = [self formatAmount:amount];
        [_amountLabel sizeToFit];
        _amountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_amountLabel];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:kPGVPSideMargin]];
        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        constraint.priority = 999;
        [self addConstraint:constraint];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_amountLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        constraint = [NSLayoutConstraint constraintWithItem:_amountLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        constraint.priority = 999;
        [self addConstraint:constraint];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeBaseline relatedBy:NSLayoutRelationEqual toItem:_amountLabel attribute:NSLayoutAttributeBaseline multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:_amountLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:-kPGVPSideMargin]];

    }
    return self;
}


- (void)setAmount:(int)amount
{
    _amountLabel.text = [self formatAmount:amount];
    [_amountLabel sizeToFit];
}


- (CGSize)intrinsicContentSize
{
    CGSize intrinsicSize;
    intrinsicSize.width = _titleLabel.bounds.size.width + _amountLabel.bounds.size.width + kPGVPSideMargin * 2;
    intrinsicSize.height = (_titleLabel.bounds.size.height >= _amountLabel.bounds.size.height) ? _titleLabel.bounds.size.height : _amountLabel.bounds.size.height;
    return intrinsicSize;
}


- (NSString *)formatAmount:(int)amount
{
    NSNumberFormatter * nf = [NSNumberFormatter new];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    return [NSString stringWithFormat:@"$%@", [nf stringFromNumber:[NSNumber numberWithInt:amount]]];
}


@end
