/*
 *  PGCardsPokerHandInfo.m
 *  ======================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of class containing evaluation information about a poker hand.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGCardsPokerHandInfo.h"


@implementation PGCardsPokerHandInfo


- (instancetype)init
{
    if ( (self = [super init])) {
        [self resetInfo];
    }
    
    return self;
}


- (void)resetInfo
{
    _singles = 0;
    _lowPair = 0;
    _highPair = 0;
    _three = 0;
    _four = 0;
    _highCard = -1;
    _straight = NO;
    _flush = NO;
    _straightFlush = NO;
    _royalFlush = NO;
    _pokerHandType = POKERHAND_NOTEVALUATED;
    _videoPokerHandType = VIDEOPOKERHAND_NOTEVALUATED;
    _score = 0;
}


- (void)addSingle:(int)newSingle
{
    _singles = _singles >> 4;
    _singles += newSingle << 16;
}


- (BOOL)allSingles
{
    if ( _singles & 0xF ) {
        return YES;
    } else {
        return NO;
    }
}


- (int)singleAtIndex:(int)index
{
    return (((_singles << (index * 4)) & 0xF0000) >> 16);
}


- (void)addScoreElement:(int)newElement
{
    _score = _score >> 4;
    _score += (newElement << 20);
}


- (void)setScoreToSingles
{
    _score = _singles;
}


- (void)setScoreType:(enum PGCardsPokerHandType)handType
{
    _score = (_score & ~(0xF00000)) | (handType << 20);
}


@end
