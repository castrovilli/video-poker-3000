//
//  PGVPBetPickerDelegate.h
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/12/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGVPPokerViewControllerDelegate.h"
#import "PGVPPokerMachineDelegate.h"

@interface PGVPBetPickerDelegate : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic, readwrite) id<PGVPPokerViewControllerDelegate> controllerDelegate;
@property (weak, nonatomic, readwrite) id<PGVPPokerMachineDelegate> machineDelegate;

+ (id)objectWithControllerDelegate:(id<PGVPPokerViewControllerDelegate>)controllerDelegate andMachineDelegate:(id<PGVPPokerMachineDelegate>)machineDelegate;
- (id)initWithControllerDelegate:(id<PGVPPokerViewControllerDelegate>)controllerDelegate andMachineDelegate:(id<PGVPPokerMachineDelegate>)machineDelegate;


@end
