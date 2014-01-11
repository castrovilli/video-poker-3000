/*
 *  PGCardsDeck.h
 *  =============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to playing card deck class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <Foundation/Foundation.h>
#import "PGCardsCard.h"


@interface PGCardsDeck : NSObject


/**
 The number of cards in the main deck, excluding cards in the discard pile.
 */
@property (assign, nonatomic, readonly) NSUInteger size;

/**
 The number of cards in the discard pile.
 */
@property (assign, nonatomic, readonly) NSUInteger discardPileSize;

/**
 Shuffles the deck.
 
 @attention Cards in the discard pile are not returned to the main deck by
 this method. Call @c replaceDiscards if the discards should be returned
 prior to shuffling.
 */
-(void)shuffle;

/**
 Removes and returns the top card in the deck.
 @return The top card in the deck.
 */
-(PGCardsCard *)drawTopCard;

/**
 Removes and returns a specified number of cards from the top of the deck.
 @param numCards The number of cards to remove and return.
 @return A NSMutableArray contained the removed cards.
 */
-(NSMutableArray *)drawTopCards:(int)numCards;

/**
 Adds a card to the discard pile.
 @param card The card to add to the discard pile.
 */
-(void)addCardToDiscards:(PGCardsCard *)card;

/**
 Adds cards to the discard pile.
 @param cards An NSMutableArray containing the cards to be added to the discard pile.
 */
-(void)addCardsToDiscards:(NSMutableArray *)cards;

/**
 Removes any cards from the discard pile and places them in the main deck.
 */
-(void)replaceDiscards;


@end
