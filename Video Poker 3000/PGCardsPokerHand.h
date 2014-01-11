/*
 *  PGCardsPokerHand.h
 *  ==================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to playing card poker hand class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <Foundation/Foundation.h>
#import "PGCardsHand.h"
#import "PGCardsPokerHandInfo.h"


@interface PGCardsPokerHand : PGCardsHand


/**
 An object containing information about the hand.
 
 @attention This property is meaningless prior to calling @c evaluate.
 */
@property (strong, nonatomic, readonly) PGCardsPokerHandInfo * handInfo;


/**
 Evaluates the poker hand.
 */
- (void)evaluate;

/**
 Returns a string describing an evaluated hand.
 
 @attention @c evaluate should be called prior to this.
 */
- (NSString *)evaluateString;

/**
 Tests whether the poker hand evalutes equal to another poker hand.
 @param otherHand The other hand.
 @return @c YES if the two hands evaluate equal, @c NO otherwise.
 */
- (BOOL)equalsHand:(PGCardsPokerHand *)otherHand;

/**
 Tests whether the poker hand beats another poker hand.
 @param otherHand The other hand.
 @return @c YES if the receiver beats the other hand, @c NO otherwise.
 */
- (BOOL)beatsHand:(PGCardsPokerHand *)otherHand;

/**
 Tests whether the poker hand loses to another poker hand.
 @param otherHand The other hand.
 @return @c YES if the receiver loses to the other hand, @c NO otherwise.
 */
- (BOOL)losesToHand:(PGCardsPokerHand *)otherHand;


@end
