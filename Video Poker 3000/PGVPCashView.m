//
//  PGVPCashView.m
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/4/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import "PGVPCashView.h"

#define SIDEMARGIN 20

@implementation PGVPCashView {
    UILabel * _titleLabel;
    UILabel * _amountLabel;
}

- (id)initWithFrame:(CGRect)frame andAmount:(int)amount
{
    self = [super initWithFrame:frame];
    if (self) {
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
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:SIDEMARGIN]];
        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        constraint.priority = 999;
        [self addConstraint:constraint];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_amountLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        constraint = [NSLayoutConstraint constraintWithItem:_amountLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        constraint.priority = 999;
        [self addConstraint:constraint];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeBaseline relatedBy:NSLayoutRelationEqual toItem:_amountLabel attribute:NSLayoutAttributeBaseline multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:_amountLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:-SIDEMARGIN]];

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
    intrinsicSize.width = _titleLabel.bounds.size.width + _amountLabel.bounds.size.width + SIDEMARGIN * 2;
    intrinsicSize.height = (_titleLabel.bounds.size.height >= _amountLabel.bounds.size.height) ? _titleLabel.bounds.size.height : _amountLabel.bounds.size.height;
    return intrinsicSize;
}


- (NSString *)formatAmount:(int)amount
{
    NSNumberFormatter * nf = [NSNumberFormatter new];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    return [NSString stringWithFormat:@"$%@", [nf stringFromNumber:[NSNumber numberWithInt:amount]]];
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
