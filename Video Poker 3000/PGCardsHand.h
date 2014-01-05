/*
 *  PGCardsHand.m
 *  =============
 *  Copyright 2013 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of playing cards hand class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */

#import <Foundation/Foundation.h>
#import "PGCardsDeck.h"

@interface PGCardsHand : NSObject {
    NSMutableArray * _cards;                //  Declared in interface so subclasses can access it
}


//  Property

@property (nonatomic, readonly) NSUInteger size;


//  Public instance methods

-(void)addCardsFromArrayOfShortNames:(NSArray *)cardNames;
-(void)drawCards:(int)numCards fromDeck:(PGCardsDeck *)deck;
-(void)discardAllCardsToDeck:(PGCardsDeck *)deck;
-(int)replaceCardAtPosition:(int)position fromDeck:(PGCardsDeck *)deck;
-(int)cardIndexAtPosition:(int)position;
-(int)cardRankAtPosition:(int)position;
-(int)cardSuitAtPosition:(int)position;


@end
