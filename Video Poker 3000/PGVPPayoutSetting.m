/*
 *  PGVPPayoutSetting.m
 *  ===================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implenentation of payout setting view class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPPayoutSetting.h"


@implementation PGVPPayoutSetting
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


-(id) init
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _label = [UILabel new];
        _label.text = @"Payout";
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_label];
        
        _segCtl = [[UISegmentedControl alloc] initWithItems:@[@"Normal", @"Easy"]];
        _segCtl.translatesAutoresizingMaskIntoConstraints = NO;
        [_segCtl addTarget:self action:@selector(payoutValueChanged:) forControlEvents:UIControlEventValueChanged];
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


- (IBAction)payoutValueChanged:(id)sender
{
    if ( _segCtl.selectedSegmentIndex == 0 ) {
        _payoutOption = PAYOUT_CHOICE_NORMAL;
    } else if ( _segCtl.selectedSegmentIndex == 1 ) {
        _payoutOption = PAYOUT_CHOICE_EASY;
    }
}


- (void)setSelection:(enum PayoutChoiceOptions)selection
{
    _payoutOption = selection;
    if ( selection == PAYOUT_CHOICE_NORMAL ) {
        _segCtl.selectedSegmentIndex = 0;
    } else if ( selection == PAYOUT_CHOICE_EASY ) {
        _segCtl.selectedSegmentIndex = 1;
    } else {
        [NSException raise:@"payout_setting" format:@"Illegal payout setting"];
    }
}


@end
