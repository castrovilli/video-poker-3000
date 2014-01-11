//
//  PGVPMainButtonView.m
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/11/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import "PGVPMainButtonView.h"

@implementation PGVPMainButtonView
{
    UIButton * _dealButton;
}


+ (id)objectWithTarget:(id)target andAction:(SEL)action
{
    return [[PGVPMainButtonView alloc] initWithTarget:target andAction:action];
}


- (id)initWithTarget:(id)target andAction:(SEL)action
{
    self = [super init];
    if (self) {
        
        //  Main button container
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.layer.borderColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1].CGColor;
        self.layer.borderWidth = 1;
        self.backgroundColor = [UIColor whiteColor];
        
        //  Main button
        
        _dealButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_dealButton setTitle:@"Deal cards!" forState:UIControlStateNormal];
        _dealButton.titleLabel.font = [UIFont systemFontOfSize:24];
        [_dealButton sizeToFit];
        [_dealButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        _dealButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_dealButton];
        
        //  Constraints, center button in view
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_dealButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_dealButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];

        
    }
    return self;
}


- (void)setText:(NSString *)newText
{
    [_dealButton setTitle:newText forState:UIControlStateNormal];
    [_dealButton sizeToFit];
}


@end
