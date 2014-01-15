/*
 *  PGVPMainButtonView.m
 *  ====================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of class for main video poker game action button.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPMainButtonView.h"


@implementation PGVPMainButtonView
{
    /**
     Main button.
     */
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
        self.backgroundColor = [UIColor colorWithRed:.9766 green:.793 blue:.2031 alpha:.2];

        
        //  Main button
        
        _dealButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_dealButton setTitle:@"Deal cards!" forState:UIControlStateNormal];
        _dealButton.titleLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize] * 1.5];
        [_dealButton sizeToFit];
        [_dealButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        _dealButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_dealButton];
        
        
        //  Constrain minimum button height, to avoid layout changing when button text changes
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:40]];


        //  Constraints button boundary to fill the super view, to automatically center text and
        //  maximize the touch area
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_dealButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_dealButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_dealButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_dealButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];

    }
    return self;
}


- (void)setText:(NSString *)newText
{
    [_dealButton setTitle:newText forState:UIControlStateNormal];
}


- (void)enable:(BOOL)status
{
    self.userInteractionEnabled = status;
}


@end
