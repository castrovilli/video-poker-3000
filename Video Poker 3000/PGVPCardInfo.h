/*
 *  PGVPCardsInfo.h
 *  ===============
 *  Copyright 2013 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to video poker card info class.
 *
 *  This class is used to describe a card that should be displayed at a
 *  particular position in a hand, and how it should be displayed.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <Foundation/Foundation.h>

@interface PGVPCardInfo : NSObject

/**
 The zero-based index in the hand at which to position.
 */
@property (assign, nonatomic, readwrite) int positionIndex;

/**
 The index of the card to place, from 0-51 inclusive.
 */
@property (assign, nonatomic, readwrite) int cardIndex;

/**
 The flipped status of the card, where YES is face down, NO is face up.
 */
@property (assign, nonatomic, readwrite) BOOL flipped;

/**
 Returns an object created with specified parameters.
 @param positionIndex The zero-based index in the hand at which to position.
 @param cardIndex The index of the card to place, from 0-51 inclusive.
 @param flipped The flipped status of the card, where YES is face down, NO is face up.
 @return An object created with the specified parameters.
 */
+ (PGVPCardInfo *)objectWithPosition:(int)positionIndex cardIndex:(int)cardIndex flipped:(BOOL)flipped;

/**
 Initializes an object created with specified parameters.
 @param positionIndex The zero-based index in the hand at which to position.
 @param cardIndex The index of the card to place, from 0-51 inclusive.
 @param flipped The flipped status of the card, where YES is face down, NO is face up.
 @return An object initialized with the specified parameters.
 */
- (instancetype)initWithPosition:(int)positionIndex cardIndex:(int)cardIndex flipped:(BOOL)flipped;

@end
