/*
 *  PGCardsDeck.m
 *  =============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of playing card deck class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGCardsDeck.h"


@implementation PGCardsDeck {
    
    /**
     An array containing the main card deck.
     */
    NSMutableArray * _mainDeck;
    
    /**
     An array containing the cards in the discard pile.
     */
    NSMutableArray * _discardPile;
    
}


- (instancetype)init
{
    if ( (self = [super init]) ) {
        _mainDeck = [NSMutableArray new];
        _discardPile = [NSMutableArray new];
        
        //  Add cards in reverse order, so first card is at top of deck
        
        for ( int index = 51; index >= 0; --index ) {
            [_mainDeck addObject:[[PGCardsCard alloc] initWithIndex:index]];
        }        
    }
    
    return self;
}


- (NSUInteger)size
{
    return [_mainDeck count];
}


- (NSUInteger)discardPileSize
{
    return [_discardPile count];
}


- (void)shuffle
{
    NSUInteger deckSize = [_mainDeck count];

    for ( NSUInteger fromIndex = 0; fromIndex < deckSize; ++fromIndex ) {
        NSUInteger num_remaining = deckSize - fromIndex;
        NSUInteger toIndex = arc4random_uniform((u_int32_t) num_remaining) + fromIndex;
        [_mainDeck exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
    }
}


- (PGCardsCard *)drawTopCard
{
    PGCardsCard * topCard = [_mainDeck lastObject];

    if ( topCard ) {
        [_mainDeck removeLastObject];
    }

    return topCard;
}


- (NSMutableArray *)drawTopCards:(int)numCards
{
    PGCardsCard * card;
    NSMutableArray * drawnCards = [NSMutableArray new];

    while ( numCards-- && (card = [_mainDeck lastObject]) ) {
        [drawnCards addObject:card];
        [_mainDeck removeLastObject];
    }

    return drawnCards;
}


- (void)addCardToDiscards:(PGCardsCard *)card
{
    [_discardPile addObject:card];
}


- (void)addCardsToDiscards:(NSMutableArray *)cards
{
    for ( id array_object in cards ) {
        if ( ![array_object isMemberOfClass:[PGCardsCard class]] ) {
            assert(0);
        }
    }

    [_discardPile addObjectsFromArray:cards];
    [cards removeAllObjects];
}


- (void)replaceDiscards
{
    [_mainDeck addObjectsFromArray:_discardPile];
    [_discardPile removeAllObjects];
}


@end
