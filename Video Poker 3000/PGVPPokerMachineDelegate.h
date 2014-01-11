/*
 *  PGVPPokerMachineDelegate.h
 *  ==========================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Protocol for poker machine object delegates.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <Foundation/Foundation.h>
#import "PGCardsPokerHandInfo.h"


@protocol PGVPPokerMachineDelegate <NSObject>

/**
 Tests if the card at the specified position is currently flipped.
 @param cardPosition The 1-based index of the position of the card.
 @return @c YES if the card is flipped, @c NO otherwise.
 */
- (BOOL)isCardFlipped:(int)cardPosition;

/**
 Switches the flipped status of the card at the specified position.
 @param cardPosition The 1-based index of the position of the card.
 */
- (void)switchCardFlip:(int)cardPosition;

/**
 Returns the index of the card at the specified position.
 @param cardPosition The 1-based index of the position of the card.
 @return The index of the card at the specified position, in the range 0-51 inclusive.
 */
- (int)cardIndexAtPosition:(int)cardPosition;

/**
 Returns the current cash.
 @return The current cash.
 */
- (int)getCurrentCash;

/**
 Returns the current bet.
 @return The current bet.
 */
- (int)getCurrentBet;

/**
 Gets the payout ratio for the specified hand, using the currently selected payout option.
 @param handType The hand type.
 @return The payout ratio for the specified hand type.
 */
- (int)getPayoutRatioForHand:(enum PGCardsVideoPokerHandType)handType;

@end
