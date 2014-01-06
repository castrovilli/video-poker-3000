//
//  PGVPStatusView.m
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/5/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import "PGVPStatusView.h"

static const int kPGVPResultsMargin = 5;


@implementation PGVPStatusView {
    UILabel * _statusLabel;
}


+ (id)objectWithStatus:(NSString *)statusText
{
    return [[PGVPStatusView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andStatusText:statusText];
}

- (id)initWithFrame:(CGRect)frame andStatusText:(NSString *)statusText;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor colorWithRed:.8 green:1 blue:.8 alpha:1];
        
        
        //  Status label

        _statusLabel = [UILabel new];
        _statusLabel.text = @"Welcome to Video Poker! Deal your first hand to begin.";
        _statusLabel.numberOfLines = 2;
        [_statusLabel sizeToFit];
        _statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusLabel];
        
        
        //  Autolayout constraints
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_statusLabel
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_statusLabel
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1
                                                          constant:kPGVPResultsMargin]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_statusLabel
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationLessThanOrEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1
                                                          constant:-kPGVPResultsMargin]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_statusLabel
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1
                                                          constant:kPGVPResultsMargin]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_statusLabel
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:-kPGVPResultsMargin]];

    }
    return self;
}


- (void)setStatusText:(NSString *)statusText
{
    _statusLabel.text = statusText;
    [_statusLabel sizeToFit];
}


@end
