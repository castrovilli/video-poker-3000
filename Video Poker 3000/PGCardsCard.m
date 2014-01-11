/*
 *  PGCardsCard.m
 *  =============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to playing card class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGCardsCard.h"


@implementation PGCardsCard


+ (int)getRankFromIndex:(int)index
{
    int rank = index % 13 + 1;
    return (rank == 1) ? 14 : rank;
}


+ (int)getSuitFromIndex:(int)index
{
    return index / 13;
}


+ (int)getIndexFromRank:(int)rank andSuit:(int)suit
{
    return ((rank == 14) ? 0 : (rank - 1)) + (suit * 13);
}


+ (int)getSuitIntegerFromChar:(int)shortNameChar
{
    static const int shortNames[] = {'C', 'H', 'S', 'D'};
    
    for ( int idx = 0; idx < (sizeof(shortNames) / sizeof(shortNames[0])); ++idx ) {
        if ( shortNames[idx] == shortNameChar ) {
            return idx;
        }
    }
    
    return -1;
}


+ (int)getRankIntegerFromChar:(int)shortNameChar
{
    static const int shortNames[] = {0, 0, '2', '3', '4', '5', '6', '7', '8',
        '9', 'T', 'J', 'Q', 'K', 'A'};
    
    for ( int idx = 2; idx < (sizeof(shortNames) / sizeof(shortNames[0])); ++idx ) {
        if ( shortNames[idx] == shortNameChar ) {
            return idx;
        }
    }
    
    return -1;
}


+ (NSString *)getSuitLongString:(int)suit
{
    static NSArray * suitNames = nil;
    if ( !suitNames ) {
        suitNames = @[@"clubs", @"hearts", @"spades", @"diamonds"];
    }
    return suitNames[suit];
}


+ (NSString *)getRankLongString:(int)rank
{
    static NSArray * rankNames = nil;
    if ( !rankNames ) {
        rankNames = @[@"ace", @"two", @"three", @"four", @"five", @"six", @"seven",
                      @"eight", @"nine", @"ten", @"jack", @"queen", @"king", @"ace"];
    }
    return rankNames[rank - 1];
}


+ (NSString *)getSuitShortString:(int)suit
{
    static NSArray * suitNames = nil;
    if ( !suitNames ) {
        suitNames = @[@"C", @"H", @"S", @"D"];
    }
    return suitNames[suit];
}


+ (NSString *)getRankShortString:(int)rank
{
    static NSArray * rankNames = nil;
    if ( !rankNames ) {
        rankNames = @[@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"T", @"J", @"Q", @"K", @"A"];
    }
    return rankNames[rank - 1];
}


+ (PGCardsCard *)cardWithIndex:(int)index
{
    return [[PGCardsCard alloc] initWithIndex:index];
}


+ (PGCardsCard *)cardWithRank:(int)rank andSuit:(int)suit
{
    return [[PGCardsCard alloc] initWithRank:rank andSuit:suit];
}


+ (PGCardsCard *)cardWithShortName:(NSString *)cardName
{
    return [[PGCardsCard alloc] initWithShortName:cardName];
}


- (instancetype)initWithIndex:(int)index
{
    if ( index < 0 || index > 51 ) {
        return nil;
    }

    if ( (self = [super init]) ) {
        _index = index;
        _suit = [PGCardsCard getSuitFromIndex:index];
        _rank = [PGCardsCard getRankFromIndex:index];
    }
    
    return self;
}


- (instancetype)initWithRank:(int)rank andSuit:(int)suit
{
    if ( suit < 0 || suit > 3 || rank < 1 || rank > 14 ) {
        return nil;
    }
    
    return [self initWithIndex:[PGCardsCard getIndexFromRank:rank andSuit:suit]];
}


- (instancetype)initWithShortName:(NSString *)cardName
{
    if ( cardName.length != 2U ) {
        return nil;
    }
    
    int rank = [PGCardsCard getRankIntegerFromChar:[cardName characterAtIndex:0]];
    int suit = [PGCardsCard getSuitIntegerFromChar:[cardName characterAtIndex:1]];
    
    return [self initWithRank:rank andSuit:suit];
}


- (instancetype)init
{
    return [self initWithIndex:0];
}


- (NSString *)longName
{
    return [NSString stringWithFormat:@"%@ of %@", [PGCardsCard getRankLongString:_rank],
            [PGCardsCard getSuitLongString:_suit]];
}


- (NSString *)shortName
{
    return [NSString stringWithFormat:@"%@%@", [PGCardsCard getRankShortString:_rank],
            [PGCardsCard getSuitShortString:_suit]];
}


- (BOOL)isSameCardAsCard:(PGCardsCard *)otherCard
{
    return (_index == otherCard.index) ? YES : NO;
}


- (BOOL)isNotSameCardAsCard:(PGCardsCard *)otherCard
{
    return (_index != otherCard.index) ? YES : NO;
}


- (BOOL)isSameRankAsCard:(PGCardsCard *)otherCard
{
    return (_rank == otherCard.rank) ? YES : NO;
}


- (BOOL)isNotSameRankAsCard:(PGCardsCard *)otherCard
{
    return (_rank != otherCard.rank) ? YES : NO;
}


- (BOOL)isLowerRankThanCard:(PGCardsCard *)otherCard
{
    return (_rank < otherCard.rank) ? YES : NO;
}


- (BOOL)isHigherRankThanCard:(PGCardsCard *)otherCard
{
    return (_rank > otherCard.rank) ? YES : NO;
}


- (BOOL)isLowerOrEqualRankThanCard:(PGCardsCard *)otherCard
{
    return (_rank <= otherCard.rank) ? YES : NO;
}


- (BOOL)isHigherOrEqualRankThanCard:(PGCardsCard *)otherCard
{
    return (_rank >= otherCard.rank) ? YES : NO;
}


@end
