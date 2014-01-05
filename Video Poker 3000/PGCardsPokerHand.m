//
//  PGCardsPokerHand.m
//  VideoPoker
//
//  Created by Paul Griffiths on 12/21/13.
//  Copyright (c) 2013 Paul Griffiths. All rights reserved.
//

#import "PGCardsPokerHand.h"
#import "PGCardsPokerHandInfo.h"


@implementation PGCardsPokerHand


//  Initializer method

- (PGCardsPokerHand *)init {
    if ( (self = [super init])) {
        _handInfo = [PGCardsPokerHandInfo new];
    }
    
    return self;
}


//  Public method to evaluate the poker hand

- (void) evaluate {
    [_handInfo resetInfo];
    [self getRankMatches];
    
    //  We can only get a flush or straight if all the cards are singles, so only check if they are
    
    if ( [_handInfo allSingles] ) {
        [self checkForFlush];
        [self checkForStraight];
        
        if ( _handInfo.straight && _handInfo.flush ) {
            _handInfo.straightFlush = YES;
            if ( _handInfo.highCard == 14 ) {
                _handInfo.royalFlush = YES;
            }
        }
    }
    
    
    //  Determine type of poker hand
    
    if ( _handInfo.royalFlush ) {
        _handInfo.pokerHandType = POKERHAND_ROYALFLUSH;
        _handInfo.videoPokerHandType = VIDEOPOKERHAND_ROYALFLUSH;
        [_handInfo setScoreType:POKERHAND_ROYALFLUSH];
    } else if ( _handInfo.straightFlush ) {
        _handInfo.pokerHandType = POKERHAND_STRAIGHTFLUSH;
        _handInfo.videoPokerHandType = VIDEOPOKERHAND_STRAIGHTFLUSH;
        [_handInfo addScoreElement:_handInfo.highCard];
        [_handInfo addScoreElement:POKERHAND_STRAIGHTFLUSH];
    } else if ( _handInfo.four ) {
        _handInfo.pokerHandType = POKERHAND_FOUR;
        _handInfo.videoPokerHandType = VIDEOPOKERHAND_FOUR;
        [_handInfo setScoreToSingles];
        [_handInfo addScoreElement:_handInfo.four];
        [_handInfo addScoreElement:POKERHAND_FOUR];
    } else if ( _handInfo.three && _handInfo.lowPair ) {
        _handInfo.pokerHandType = POKERHAND_FULLHOUSE;
        _handInfo.videoPokerHandType = VIDEOPOKERHAND_FULLHOUSE;
        [_handInfo addScoreElement:_handInfo.lowPair];
        [_handInfo addScoreElement:_handInfo.three];
        [_handInfo addScoreElement:POKERHAND_FULLHOUSE];
    } else if ( _handInfo.flush ) {
        _handInfo.pokerHandType = POKERHAND_FLUSH;
        _handInfo.videoPokerHandType = VIDEOPOKERHAND_FLUSH;
        [_handInfo setScoreToSingles];
        [_handInfo setScoreType:POKERHAND_FLUSH];
    } else if ( _handInfo.straight ) {
        _handInfo.pokerHandType = POKERHAND_STRAIGHT;
        _handInfo.videoPokerHandType = VIDEOPOKERHAND_STRAIGHT;
        [_handInfo addScoreElement:_handInfo.highCard];
        [_handInfo addScoreElement:POKERHAND_STRAIGHT];
    } else if ( _handInfo.three ) {
        _handInfo.pokerHandType = POKERHAND_THREE;
        _handInfo.videoPokerHandType = VIDEOPOKERHAND_THREE;
        [_handInfo setScoreToSingles];
        [_handInfo addScoreElement:_handInfo.three];
        [_handInfo addScoreElement:POKERHAND_THREE];
    } else if ( _handInfo.highPair ) {
        _handInfo.pokerHandType = POKERHAND_TWOPAIR;
        _handInfo.videoPokerHandType = VIDEOPOKERHAND_TWOPAIR;
        [_handInfo setScoreToSingles];
        [_handInfo addScoreElement:_handInfo.lowPair];
        [_handInfo addScoreElement:_handInfo.highPair];
        [_handInfo addScoreElement:POKERHAND_TWOPAIR];
    } else if ( _handInfo.lowPair ) {
        _handInfo.pokerHandType = POKERHAND_PAIR;
        
        //  For video poker, only jacks or higher count as winning pairs.
        
        if ( _handInfo.lowPair >= 11 ) {
            _handInfo.videoPokerHandType = VIDEOPOKERHAND_JACKSORBETTER;
        } else {
            _handInfo.videoPokerHandType = VIDEOPOKERHAND_NOWIN;
        }
        [_handInfo setScoreToSingles];
        [_handInfo addScoreElement:_handInfo.lowPair];
        [_handInfo addScoreElement:POKERHAND_PAIR];
    } else {
        _handInfo.pokerHandType = POKERHAND_HIGHCARD;
        _handInfo.videoPokerHandType = VIDEOPOKERHAND_NOWIN;
        [_handInfo setScoreToSingles];
        [_handInfo setScoreType:POKERHAND_HIGHCARD];
    }
}



//  Public method to get a string representation of the most recent evaluation

- (NSString *)evaluateString {
    static const char * cardNamesSingular[] = {"NONE", "ace", "two", "three", "four", "five", "six", "seven",
        "eight", "nine", "ten", "jack", "queen", "king", "ace"};
    static const char * cardNamesPlural[] = {"NONE", "aces", "twos", "threes", "fours", "fives", "sixes", "sevens",
        "eights", "nines", "tens", "jacks", "queens", "kings", "aces"};
    NSString * returnString;
    
    if ( _handInfo.videoPokerHandType == VIDEOPOKERHAND_ROYALFLUSH ) {
        returnString = @"Royal flush!";
    } else if ( _handInfo.videoPokerHandType == VIDEOPOKERHAND_STRAIGHTFLUSH ) {
        returnString = [NSString stringWithFormat:@"Straight flush, %s high!", cardNamesSingular[_handInfo.highCard]];
    } else if ( _handInfo.videoPokerHandType == VIDEOPOKERHAND_FOUR ) {
        returnString = [NSString stringWithFormat:@"Four %s!", cardNamesPlural[_handInfo.four]];
    } else if ( _handInfo.videoPokerHandType == VIDEOPOKERHAND_FULLHOUSE ) {
        returnString = [NSString stringWithFormat:@"Full house, %s full of %s!", cardNamesPlural[_handInfo.three],
                        cardNamesPlural[_handInfo.lowPair]];
    } else if ( _handInfo.videoPokerHandType == VIDEOPOKERHAND_FLUSH ) {
        returnString = [NSString stringWithFormat:@"Flush, %s high!", cardNamesSingular[[_handInfo singleAtIndex:0]]];
    } else if ( _handInfo.videoPokerHandType == VIDEOPOKERHAND_STRAIGHT ) {
        returnString = [NSString stringWithFormat:@"Straight, %s high!", cardNamesSingular[_handInfo.highCard]];
    } else if ( _handInfo.videoPokerHandType == VIDEOPOKERHAND_THREE ) {
        returnString = [NSString stringWithFormat:@"Three %s!", cardNamesPlural[_handInfo.three]];
    } else if ( _handInfo.videoPokerHandType == VIDEOPOKERHAND_TWOPAIR ) {
        returnString = [NSString stringWithFormat:@"Two pair, %s over %s!", cardNamesPlural[_handInfo.highPair],
                        cardNamesPlural[_handInfo.lowPair]];
    } else if ( _handInfo.videoPokerHandType == VIDEOPOKERHAND_JACKSORBETTER ) {
        returnString = [NSString stringWithFormat:@"Pair of %s!", cardNamesPlural[_handInfo.lowPair]];
    } else {
        returnString = @"No win.";
    }
    
    return returnString;
}


//  Private method which finds fours, threes, pairs and computes a list of single cards.

- (void)getRankMatches {
    int rankCounts[15] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    
    for ( PGCardsCard * card in _cards ) {
        rankCounts[card.rank] += 1;
    }
    
    for ( int rankCountIndex = 2; rankCountIndex < 15; ++rankCountIndex ) {
        int currentCount = rankCounts[rankCountIndex];
        if ( currentCount == 0 ) {
            continue;
        } else if ( currentCount == 1 ) {
            [_handInfo addSingle:rankCountIndex];
        } else if ( currentCount == 2 ) {
            if ( _handInfo.lowPair ) {
                _handInfo.highPair = rankCountIndex;
            } else {
                _handInfo.lowPair = rankCountIndex;
            }
        } else if ( currentCount == 3 ) {
            _handInfo.three = rankCountIndex;
        } else if ( currentCount == 4 ) {
            _handInfo.four = rankCountIndex;
        } else {
            NSLog(@"Anomalous rank count in getRankMatches:");
            assert(0);      // We should never get fives-of-a-kind, or higher
        }
    }
}


//  Private method which checks for a flush

- (void)checkForFlush {
    int suitCounts[4] = {0, 0, 0, 0};
    
    for ( PGCardsCard * card in _cards ) {
        suitCounts[card.suit] += 1;
    }
    
    for ( int suitCountIndex = 0; suitCountIndex < 4; ++suitCountIndex ) {
        if ( suitCounts[suitCountIndex] == 5 ) {
            _handInfo.flush = YES;
        }
    }
}


//  Private method which checks for a straight

- (void)checkForStraight {
    int single0 = [_handInfo singleAtIndex:0];
    int single1 = [_handInfo singleAtIndex:1];
    int single4 = [_handInfo singleAtIndex:4];
    
    if ( (single0 - single4) == 4 ) {
        _handInfo.straight = YES;
        _handInfo.highCard = [_handInfo singleAtIndex:0];
    } else if ( (single0 - single1) == 9 ) {
        _handInfo.straight = YES;
        _handInfo.highCard = 5;
    }
}


//  Public methods to compare poker hands by score

- (BOOL)equalsHand:(PGCardsPokerHand *)otherHand {
    return (_handInfo.score == otherHand.handInfo.score) ? YES : NO;
}


- (BOOL)beatsHand:(PGCardsPokerHand *)otherHand {
    return (_handInfo.score > otherHand.handInfo.score) ? YES: NO;
}


- (BOOL)losesToHand:(PGCardsPokerHand *)otherHand {
    return (_handInfo.score < otherHand.handInfo.score) ? YES : NO;
}


@end
