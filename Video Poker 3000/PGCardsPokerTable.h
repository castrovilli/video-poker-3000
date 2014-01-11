/*
 *  PGCardsPokerTable.h
 *  ===================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to poker table class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <Foundation/Foundation.h>
#import "PGCardsPokerHandInfo.h"
#import "PGVPOptionsTypes.h"
#import "PGVPPokerMachineDelegate.h"


/**
 Enumeration type for game state.
 */
enum PGCardsPokerGameState {
    POKER_GAMESTATE_INITIAL,        /**< Bet has been made and cards can be dealt. */
    POKER_GAMESTATE_DEALED,         /**< Cards have been dealt, and exchanges have been chosen. */
    POKER_GAMESTATE_EVALUATED,      /**< The hand is over, and a new hand is ready to be dealt. */
    POKER_GAMESTATE_GAMEOVER,       /**< The game is over. */
    POKER_GAMESTATE_NEWGAME         /**< The first bet has been made at the start of a new game. */
};


@interface PGCardsPokerTable : NSObject <PGVPPokerMachineDelegate>


/**
 The game state.
 */
@property (assign, nonatomic, readonly) enum PGCardsPokerGameState gameState;

/**
 A string containing a description of the evaluation of the current hand.
 */
@property (strong, nonatomic, readonly) NSString * evaluationString;

/**
 The current amount of cash.
 */
@property (assign, nonatomic, readonly) int currentCash;

/**
 The current bet.
 */
@property (assign, nonatomic, readwrite) int currentBet;

/**
 The selected payout option, or difficulty level.
 */
@property (assign, nonatomic, readwrite) enum PayoutChoiceOptions payoutOption;

/**
 Replaces card which the player has chosen to exchange with fresh cards from the deck.
 */
- (void)replaceFlippedCards;

/**
 Advances the game to the next state.
 */
- (void)advanceGameState;

/**
 Gets the payout ratio for the specified hand with a specified payout option.
 @param handType The hand type.
 @param payoutOption The specified payout option.
 @return The payout ratio for the specified hand type and payout option.
 */
- (int)getPayoutRatioForHand:(enum PGCardsVideoPokerHandType)handType withType:(enum PayoutChoiceOptions)payoutOption;


@end
