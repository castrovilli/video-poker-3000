/*
 *  PGCardsCard.h
 *  =============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to playing card class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <Foundation/Foundation.h>


@interface PGCardsCard : NSObject

/**
 The card's index, in the range 0-51 inclusive, where 0 is the Ace of Clubs, 1 is the
 Two of Clubs, 13 is the Ace of Hearts, 26 is the Ace of Spades, 39 is the Ace of Diamonds,
 and 51 is the King of Diamonds.
 */
@property (assign, nonatomic, readonly) int index;

/**
 The card's rank, in the range 2-14 inclusive, where 2 is Two, 11 is Jack, 12 is Queen,
 13 is King, and 14 is Ace.
 */
@property (assign, nonatomic, readonly) int rank;

/**
 The card's suit, where 0 is Clubs, 1 is Hearts, 2 is Spades, and 3 is Diamonds.
 */
@property (assign, nonatomic, readonly) int suit;


/**
 Returns a card's rank from its index.
 @param index The card's index, in the range 0-51 inclusive.
 @return The card's rank, in the range 2-14 inclusive.
 */
+ (int)getRankFromIndex:(int)index;

/**
 Returns a card's suit from its index.
 @param index The card's index, in the range 0-51 inclusive.
 @return The card's suit, in the range 0-3 inclusive.
 */
+ (int)getSuitFromIndex:(int)index;

/**
 Returns a card's index from its rank and suit.
 @param rank The card's rank, in the range 2-14 inclusive.
 @param suit The card's suit, in the range 0-3 inclusive.
 @return The card's index, in the range 0-51 inclusive.
 */
+ (int)getIndexFromRank:(int)rank andSuit:(int)suit;

/**
 Returns a suit integer from a character representation.
 @param shortNameChar @c 'C', @c 'H', @c 'S' or @c 'D'.
 @return The card's suit, in the range 0-3 inclusive.
 */
+ (int)getSuitIntegerFromChar:(int)shortNameChar;

/**
 Returns a rank integer from a character representation.
 @param shortNameChar @c 'A', @c '2', @c '3', @c '4', @c '5', @c '6',
 @c '7', @c '8', @c '9', @c 'T', @c 'J', @c 'Q', or @c 'K'.
 @return The card's rank, in the range 2-14 inclusive.
 */
+ (int)getRankIntegerFromChar:(int)shortNameChar;

/**
 Returns a long string representation of a suit, e.g. "Hearts" or "Spades".
 @param suit The suit, in the range 0-3 inclusive.
 @return The long string representation of the suit.
 */
+ (NSString *)getSuitLongString:(int)suit;

/**
 Returns a long string representation of a rank, e.g. "Two" or "Queen".
 @param suit The rank, in the range 2-14 inclusive.
 @return The long string representation of the rank.
 */
+ (NSString *)getRankLongString:(int)rank;

/**
 Returns a short string representation of a suit, e.g. "H" or "S".
 @param suit The suit, in the range 0-3 inclusive.
 @return The short string representation of the suit.
 */
+ (NSString *)getSuitShortString:(int)suit;

/**
 Returns a short string representation of a rank, e.g. "2" or "Q".
 @param suit The rank, in the range 2-14 inclusive.
 @return The short string representation of the rank.
 */
+ (NSString *)getRankShortString:(int)rank;

/**
 Returns a card object created from a specified index.
 @param index The new card's index, in the range 0-51 inclusive.
 @return A card object created from the specified index.
 */
+ (PGCardsCard *)cardWithIndex:(int)index;

/**
 Returns a card object created from a specified rank and suit.
 @param index The new card's rank, in the range 2-14 inclusive.
 @param index The new card's suit, in the range 0-3 inclusive.
 @return A card object created from the specified rank and suit.
 */
+ (PGCardsCard *)cardWithRank:(int)rank andSuit:(int)suit;

/**
 Returns a card object created from a specified short name.
 @param index The new card's short name, e.g. "2S", "KC".
 @return A card object created from the specified short name.
 */
+ (PGCardsCard *)cardWithShortName:(NSString *)cardName;

/**
 Returns a card object initialized with a specified index.
 @param index The new card's index, in the range 0-51 inclusive.
 @return A card object initialized with the specified index.
 */
- (instancetype)initWithIndex:(int)index;

/**
 Returns a card object initialized with a specified rank and suit.
 @param index The new card's rank, in the range 2-14 inclusive.
 @param index The new card's suit, in the range 0-3 inclusive.
 @return A card object initialized with the specified rank and suit.
 */
- (instancetype)initWithRank:(int)rank andSuit:(int)suit;

/**
 Returns a card object initialized with a specified short name.
 @param index The new card's short name, e.g. "2S", "KC".
 @return A card object initialized with the specified short name.
 */
- (instancetype)initWithShortName:(NSString *)cardName;

/**
 Returns the card's long name, e.g. "Two of Clubs".
 @return The card's long name.
 */
- (NSString *)longName;

/**
 Returns the card's short name, e.g. "2C".
 @return The card's short name.
 */
- (NSString *)shortName;

/**
 Tests if a card is of the same rank and suit as another card.
 @param otherCard The other card.
 @return @c YES if the cards are of the same rank and suit, @c NO otherwise.
 */
- (BOOL)isSameCardAsCard:(PGCardsCard *)otherCard;

/**
 Tests if a card is not of the same rank and/or suit as another card.
 @param otherCard The other card.
 @return @c YES if the cards are not of the same rank and/or suit, @c NO otherwise.
 */
- (BOOL)isNotSameCardAsCard:(PGCardsCard *)otherCard;

/**
 Tests if a card is of the same rank as another card.
 @param otherCard The other card.
 @return @c YES if the cards are of the same rank, @c NO otherwise.
 */
- (BOOL)isSameRankAsCard:(PGCardsCard *)otherCard;

/**
 Tests if a card is not of the same rank as another card.
 @param otherCard The other card.
 @return @c YES if the cards are not of the same rank, @c NO otherwise.
 */
- (BOOL)isNotSameRankAsCard:(PGCardsCard *)otherCard;

/**
 Tests if a card is of a lower rank as another card.
 @param otherCard The other card.
 @return @c YES if the receiver is of a lower rank, @c NO otherwise.
 */
- (BOOL)isLowerRankThanCard:(PGCardsCard *)otherCard;

/**
 Tests if a card is of a higher rank as another card.
 @param otherCard The other card.
 @return @c YES if the receiver is of a higher rank, @c NO otherwise.
 */
- (BOOL)isHigherRankThanCard:(PGCardsCard *)otherCard;

/**
 Tests if a card is of the same or lower rank as another card.
 @param otherCard The other card.
 @return @c YES if the receiver is of the same or lower rank, @c NO otherwise.
 */
- (BOOL)isLowerOrEqualRankThanCard:(PGCardsCard *)otherCard;

/**
 Tests if a card is of the same or higher rank as another card.
 @param otherCard The other card.
 @return @c YES if the receiver is of the same of higher rank, @c NO otherwise.
 */
- (BOOL)isHigherOrEqualRankThanCard:(PGCardsCard *)otherCard;


@end
