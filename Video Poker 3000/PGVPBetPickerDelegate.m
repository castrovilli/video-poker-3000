//
//  PGVPBetPickerDelegate.m
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/12/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import "PGVPBetPickerDelegate.h"

@implementation PGVPBetPickerDelegate
{
    NSArray * _betAmounts;
    NSArray * _betValues;
}


- (id)init
{
    self = [super init];
    if ( self ) {
        _betAmounts = @[@"$5", @"$10", @"$20", @"$50", @"$100", @"$200", @"$500",
                        @"$1,000", @"$2,000", @"$5,000", @"$10,000"];
        _betValues = @[@5, @10, @20, @50, @100, @200, @500, @1000, @2000, @5000, @10000];
    }
    return self;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _betAmounts[row];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _betAmounts.count;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_delegate betPickerSelectionChangedWithIndex:row andValue:[_betValues[row] intValue]];
}


- (int)valueAtSelectedIndex:(NSInteger)index
{
    return [_betValues[index] intValue];
}


@end
