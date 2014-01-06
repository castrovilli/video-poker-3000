//
//  PGCardsPokerTable.h
//  VideoPoker
//
//  Created by Paul Griffiths on 12/21/13.
//  Copyright (c) 2013 Paul Griffiths. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGCardsPokerHandInfo.h"
#import "OptionsTypes.h"
#import "PGVPPokerMachineDelegate.h"


//  Enumeration for game state. See implementation for explanations of each state.

enum PGCardsPokerGameState {
    POKER_GAMESTATE_INITIAL,
    POKER_GAMESTATE_DEALED,
    POKER_GAMESTATE_EVALUATED,
    POKER_GAMESTATE_GAMEOVER,
    POKER_GAMESTATE_NEWGAME
};


//  Class interface

@interface PGCardsPokerTable : NSObject <PGVPPokerMachineDelegate>


//  Properties

@property (nonatomic, readonly) enum PGCardsPokerGameState gameState;
@property (strong, nonatomic) NSString * evaluationString;
@property (nonatomic, readonly) int currentCash;
@property (nonatomic) int currentBet;
@property (nonatomic) enum PayoutChoiceOptions payoutOption;


//  Public methods

- (void)replaceFlippedCards;
- (void)advanceGameState;
- (int)getPayoutRatioForHand:(enum PGCardsVideoPokerHandType)handType withType:(enum PayoutChoiceOptions)payoutOption;
- (NSArray *)getCardInfoArray;



@end
