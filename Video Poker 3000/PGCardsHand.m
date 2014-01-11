/*
 *  PGCardsHand.m
 *  =============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of playing card hand class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGCardsHand.h"


@implementation PGCardsHand


- (instancetype)init
{
    if ( (self = [super init]) ) {
        _cards = [NSMutableArray new];
    }
    
    return self;
}


- (NSUInteger)size
{
    return [_cards count];
}


- (void)addCardsFromArrayOfShortNames:(NSArray *)cardNames
{
    for ( NSString * cardName in cardNames ) {
        [_cards addObject:[PGCardsCard cardWithShortName:cardName]];
    }
}


- (void)drawCards:(int)numCards fromDeck:(PGCardsDeck *)deck
{
    [_cards addObjectsFromArray:[deck drawTopCards:numCards]];
}


- (void)discardAllCardsToDeck:(PGCardsDeck *)deck
{
    [deck addCardsToDiscards:_cards];
}


- (int)replaceCardAtPosition:(int)position fromDeck:(PGCardsDeck *)deck
{
    PGCardsCard * newCard = [deck drawTopCard];
    if ( !newCard) {
        return -1;
    }
    
    [deck addCardToDiscards:_cards[position - 1]];
    [_cards removeObjectAtIndex:(position - 1)];
    [_cards insertObject:newCard atIndex:(position - 1)];
    
    return 0;
}


- (int)cardIndexAtPosition:(int)position
{
    if ( position > [_cards count] || position < 1 ) {
        return -1;
    }
    
    return ((PGCardsCard *) _cards[position - 1]).index;
}


- (int)cardRankAtPosition:(int)position
{
    if ( position > [_cards count] || position < 1 ) {
        return -1;
    }
    
    return ((PGCardsCard *) _cards[position - 1]).rank;
}


- (int)cardSuitAtPosition:(int)position
{
    if ( position > [_cards count] || position < 1 ) {
        return -1;
    }
    
    return ((PGCardsCard *) _cards[position - 1]).suit;
}


@end
