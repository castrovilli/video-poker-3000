/*
 *  PGVPCardBackSetting.m
 *  =====================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of card back color setting view class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPCardBackSetting.h"


@implementation PGVPCardBackSetting
{
    /**
     The setting label.
     */
    UILabel * _label;
    
    /**
     The setting segmented control.
     */
    UISegmentedControl * _segCtl;
}


- (id)init
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _label = [UILabel new];
        _label.text = @"Card back color";
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_label];
        
        _segCtl = [[UISegmentedControl alloc] initWithItems:@[@"Blue", @"Red"]];
        _segCtl.translatesAutoresizingMaskIntoConstraints = NO;
        [_segCtl addTarget:self action:@selector(cardBackValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_segCtl];
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_segCtl attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_segCtl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_segCtl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:_segCtl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_label attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];

    }
    return self;
}


- (IBAction)cardBackValueChanged:(id)sender
{
    if ( _segCtl.selectedSegmentIndex == 0 ) {
        _cardBackOption = CARDBACKS_CHOICE_BLUE;
    } else if ( _segCtl.selectedSegmentIndex == 1 ) {
        _cardBackOption = CARDBACKS_CHOICE_RED;
    }
}


- (void)setSelection:(enum CardBacksChoiceOptions)selection
{
    _cardBackOption = selection;
    if ( selection == CARDBACKS_CHOICE_BLUE ) {
        _segCtl.selectedSegmentIndex = 0;
    } else if ( selection == CARDBACKS_CHOICE_RED ) {
        _segCtl.selectedSegmentIndex = 1;
    } else {
        [NSException raise:@"card_back_setting" format:@"Illegal card back setting"];
    }
}


@end
