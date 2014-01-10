//
//  PGVPPayoutTableView.m
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/9/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import "PGVPPayoutTableView.h"
#import "PGVPPayoutLineView.h"

static const CGFloat kPGVPInnerMargin = 5;

@implementation PGVPPayoutTableView
{
    CGFloat _width;
    CGFloat _height;
    id<PGVPPokerMachineDelegate> _delegate;
    NSArray * _handLabels;
    UILabel * _titleLabel;
}

- (id)initWithDelegate:(id<PGVPPokerMachineDelegate>)delegate
{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        _delegate = delegate;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        
        UIView * container = [UIView new];
        container.translatesAutoresizingMaskIntoConstraints = NO;
        container.backgroundColor = [UIColor whiteColor];
        //container.layer.borderWidth = 1;
        //container.layer.borderColor = [UIColor blackColor].CGColor;
        [self addSubview:container];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:kPGVPInnerMargin]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-kPGVPInnerMargin]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        PGVPPayoutLineView * currentLine = nil;
        PGVPPayoutLineView * previousLine = nil;
        _width = 0;
        _height = 0;
        NSMutableArray * hands = [NSMutableArray new];
        
        NSLayoutConstraint * minWidthConstraint = [NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:0];
        minWidthConstraint.priority = 1;
        [container addConstraint:minWidthConstraint];
        
        for ( enum PGCardsVideoPokerHandType handType = 1; handType < 10; ++handType ) {
            currentLine = [[PGVPPayoutLineView alloc] initWithHandType:handType andDelegate:_delegate];
            [container addSubview:currentLine];
            [hands addObject:currentLine];
            
            if ( previousLine ) {
                [container addConstraint:[NSLayoutConstraint constraintWithItem:currentLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:previousLine attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
                [container addConstraint:[NSLayoutConstraint constraintWithItem:currentLine.payoutLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:previousLine.payoutLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
                
            } else {
                [container addConstraint:[NSLayoutConstraint constraintWithItem:currentLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
            }

            [container addConstraint:[NSLayoutConstraint constraintWithItem:currentLine.handLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:currentLine.payoutLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:-5]];
            [container addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationLessThanOrEqual toItem:currentLine attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
            [container addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:currentLine attribute:NSLayoutAttributeRight multiplier:1 constant:0]];

            previousLine = currentLine;
        }
        
        _titleLabel = [UILabel new];
        _titleLabel.text = @"Payout Table";
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_titleLabel sizeToFit];
        [container addSubview:_titleLabel];
        
        [container addConstraint:[NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [container addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:currentLine attribute:NSLayoutAttributeTop multiplier:1 constant:-6]];
        [container addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        _handLabels = [NSArray arrayWithArray:hands];
    }
    return self;
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
