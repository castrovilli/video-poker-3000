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
}


+ (id)objectWithControllerDelegate:(id<PGVPPokerViewControllerDelegate>)controllerDelegate andMachineDelegate:(id<PGVPPokerMachineDelegate>)machineDelegate
{
    return [[PGVPBetPickerDelegate alloc] initWithControllerDelegate:controllerDelegate
                                                  andMachineDelegate:machineDelegate];
}


- (id)initWithControllerDelegate:(id<PGVPPokerViewControllerDelegate>)controllerDelegate andMachineDelegate:(id<PGVPPokerMachineDelegate>)machineDelegate
{
    self = [super init];
    if ( self ) {
        _controllerDelegate = controllerDelegate;
        _machineDelegate = machineDelegate;
        
        NSMutableArray * betStrings = [NSMutableArray new];
        const int numBets = [_machineDelegate numberOfAvailableBets];
        
        for ( int betIndex = 0; betIndex < numBets; ++betIndex ) {
            NSString * newAmount = [self formatAmount:[_machineDelegate getBetForIndex:betIndex]];
            [betStrings addObject:newAmount];
        }
        
        _betAmounts = [NSArray arrayWithArray:betStrings];
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
    return [_machineDelegate getHighestAvailableBetIndex] + 1;
    //return _betAmounts.count;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_controllerDelegate betPickerSelectionChangedWithIndex:row];
}


- (NSString *)formatAmount:(int)amount
{
    NSNumberFormatter * nf = [NSNumberFormatter new];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    return [NSString stringWithFormat:@"$%@", [nf stringFromNumber:[NSNumber numberWithInt:amount]]];
}


@end
