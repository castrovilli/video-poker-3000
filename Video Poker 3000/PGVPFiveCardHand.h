//
//  PGVPFiveCardHand.h
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/4/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGVPPokerMachine.h"

@interface PGVPFiveCardHand : UIView

@property (weak, nonatomic) id<PGVPPokerMachine> delegate;

- (void)dealCardsWithArray:(NSArray *)cardArray flipped:(BOOL)flipped;
- (void)dealCardsFaceDown;
- (void)dealCardsFaceUp;
- (void)discardCards;
- (void)enable:(BOOL)status;

@end
