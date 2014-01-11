/*
 *  PGCardsPokerHandInfo.h
 *  ======================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to class containing evaluation information about a poker hand.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <Foundation/Foundation.h>


/**
 Enumeration type for poker hand overall types.
 */
enum PGCardsPokerHandType {
    POKERHAND_HIGHCARD,         /**< High card. */
    POKERHAND_PAIR,             /**< Pair. */
    POKERHAND_TWOPAIR,          /**< Two Pair. */
    POKERHAND_THREE,            /**< Three of a Kind. */
    POKERHAND_STRAIGHT,         /**< Straight. */
    POKERHAND_FLUSH,            /**< Flush. */
    POKERHAND_FULLHOUSE,        /**< Full House. */
    POKERHAND_FOUR,             /**< Four of a Kind. */
    POKERHAND_STRAIGHTFLUSH,    /**< Straight Flush. */
    POKERHAND_ROYALFLUSH,       /**< Royal Flush. */
    POKERHAND_NOTEVALUATED      /**< Hand not yet evaluated. */
};


/**
 Enumeration type for video poker hand overall types.
 */
enum PGCardsVideoPokerHandType {
    VIDEOPOKERHAND_NOWIN,               /**< Pair of tens of lower */
    VIDEOPOKERHAND_JACKSORBETTER,       /**< Pair of Jacks, or a higher ranked pair */
    VIDEOPOKERHAND_TWOPAIR,             /**< Two Pair. */
    VIDEOPOKERHAND_THREE,               /**< Three of a kind. */
    VIDEOPOKERHAND_STRAIGHT,            /**< Straight. */
    VIDEOPOKERHAND_FLUSH,               /**< Flush. */
    VIDEOPOKERHAND_FULLHOUSE,           /**< Full House. */
    VIDEOPOKERHAND_FOUR,                /**< Four of a Kind. */
    VIDEOPOKERHAND_STRAIGHTFLUSH,       /**< Straight Flush. */
    VIDEOPOKERHAND_ROYALFLUSH,          /**< Royal Flush. */
    VIDEOPOKERHAND_NOTEVALUATED         /**< Hand not yet evaluated. */
};


@interface PGCardsPokerHandInfo : NSObject

/**
 A representation of the single cards in the hand.
 
 @discussion Singles are stored in a single (no pun intended) u_int32_t, each single taking one nibble.
 The highest ranking single is always stored in the fifth nibble from the right, so a hand
 comprising 6, 5, 4, 3, 2 would be represented 0x00065432, and a hand comprising queen and
 jack 8 would be represented 0x000CB000. Ranks are represented by 0x2 (two) through 0xE (ace)
 and so always fit in a single 4-bit nibble.
 */
@property (assign, nonatomic, readwrite) u_int32_t singles;

/**
 The rank of the only or lower pair, or zero if no pair.
 */
@property (assign, nonatomic, readwrite) int lowPair;

/**
 The rank of the higher pair, or zero if no or only one pair.
 */
@property (assign, nonatomic, readwrite) int highPair;

/**
 The rank of the three of a kind, or zero if no three of a kind.
 */
@property (assign, nonatomic, readwrite) int three;

/**
 The rank of the four of a kind, or zero if no four or a kind.
 */
@property (assign, nonatomic, readwrite) int four;

/**
 @c YES if the hand is a straight, @c NO otherwise.
 */
@property (assign, nonatomic, readwrite) BOOL straight;

/**
 @c YES if the hand is a flush, @c NO otherwise.
 */
@property (assign, nonatomic, readwrite) BOOL flush;

/**
 @c YES if the hand is a straight flush, @c NO otherwise.
 */
@property (assign, nonatomic, readwrite) BOOL straightFlush;

/**
 @c YES if the hand is a royal flush, @c NO otherwise.
 */
@property (assign, nonatomic, readwrite) BOOL royalFlush;

/**
 The rank of the highest card in a straight, or -1 if no straight.
 */
@property (assign, nonatomic, readwrite) int highCard;

/**
 The overall poker hand type.
 */
@property (assign, nonatomic, readwrite) enum PGCardsPokerHandType pokerHandType;

/**
 The overall video poker hand type.
 */
@property (assign, nonatomic, readwrite) enum PGCardsVideoPokerHandType videoPokerHandType;

/**
 A score enabling comparison between poker hands.
 
 @discussion The score is stored in a single u_int32_t, each element of the score taking one nibble.
 The overall hand type is always stored in the sixth nibble from the right. The value of subsequent
 nibbles depend on the hand type. For instance, for a full house, the fifth nibble from the right
 would contain the rank of the three of a kind, and the fourth nibble from the right would contain
 the rank of the pair.
 */
@property (assign, nonatomic, readwrite) u_int32_t score;


/**
 Resets all the properties to their default (empty) values.
 */
- (void)resetInfo;

/**
 Adds a single card to the singles component.
 @param newSingle The rank of the single card to add.
 */
- (void)addSingle:(int)newSingle;

/**
 Tests whether the hand is comprised entirely of single cards.
 @return @c YES if the hand is comprised entirely of single cards, @c NO otherwise.
 */
- (BOOL)allSingles;

/**
 Returns the rank of the single card at the specified index.
 @param The 0-based index of the card, where 0 is the highest ranked single.
 @return The rank of the single card at the specified index.
 */
- (int)singleAtIndex:(int)index;

/**
 Adds a score element. The elements are assumed to be added in decreasing order.
 @param The value of the score element to add.
 */
- (void)addScoreElement:(int)newElement;

/**
 Sets the overall hand type of the score element.
 @param handType The value of the overall hand type.
 @discussion This method is useful for adding the overall hand type after the score has
 been set to equal the singles element, since the overall hand type is added without
 right-shifting the rest of the score element.
 */
- (void)setScoreType:(enum PGCardsPokerHandType)handType;

/**
 Sets the score element to equal the list of singles.
 
 @discussion The method will be used for hands comprised entirely of single cards,
 including straights and flushes.
 */
- (void)setScoreToSingles;


@end
