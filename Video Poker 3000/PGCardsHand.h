/*
 *  PGCardsHand.h
 *  =============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to playing card hand class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <Foundation/Foundation.h>
#import "PGCardsDeck.h"


@interface PGCardsHand : NSObject {
    
    /**
     An array containing the cards in the hand.
     */
    NSMutableArray * _cards;
    
}


/**
 The number of cards in the hand.
 */
@property (assign, nonatomic, readonly) NSUInteger size;


/**
 Adds cards from an array of short names to the hand.
 @param cardNames An array containing short names in the form "2S", "TC", "AS", etc.
 */
- (void)addCardsFromArrayOfShortNames:(NSArray *)cardNames;

/**
 Draws a specified number of cards from a deck and adds them to the hand.
 @param numCards The number of cards to draw.
 @param deck The deck from which to draw.
 */
- (void)drawCards:(int)numCards fromDeck:(PGCardsDeck *)deck;

/**
 Discards all the cards from a hand to a deck.
 @param deck The deck to which to discard.
 */
- (void)discardAllCardsToDeck:(PGCardsDeck *)deck;

/**
 Replaces a card in the hand with a fresh card from a specified deck.
 @param position The 1-based index of the card in the hand to replace.
 @param deck The deck from which to draw the fresh card.
 @return @c -1 if the deck is empty, @c 0 on success.
 */
- (int)replaceCardAtPosition:(int)position fromDeck:(PGCardsDeck *)deck;

/**
 Returns the index of the card at a specified position in the hand.
 @param position The 1-based index of the card in the hand to replace.
 @return The index of the card, in the range 0-51 inclusive.
 */
- (int)cardIndexAtPosition:(int)position;

/**
 Returns the rank of the card at a specified position in the hand.
 @param position The 1-based index of the card in the hand to replace.
 @return The rank of the card, in the range 2-14 inclusive.
 */
- (int)cardRankAtPosition:(int)position;

/**
 Returns the suit of the card at a specified position in the hand.
 @param position The 1-based index of the card in the hand to replace.
 @return The suit of the card, in the range 0-3 inclusive.
 */
- (int)cardSuitAtPosition:(int)position;


@end
