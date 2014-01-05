/*
 *  PGVPCardsInfo.m
 *  ===============
 *  Copyright 2013 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of video poker card info class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPCardInfo.h"


@implementation PGVPCardInfo

+ (PGVPCardInfo *)objectWithPosition:(int)positionIndex cardIndex:(int)cardIndex flipped:(BOOL)flipped
{
    return [[PGVPCardInfo alloc] initWithPosition:positionIndex cardIndex:cardIndex flipped:flipped];
}

- (instancetype)initWithPosition:(int)positionIndex cardIndex:(int)cardIndex flipped:(BOOL)flipped
{
    self = [super init];
    if ( self ) {
        _positionIndex = positionIndex;
        _cardIndex = cardIndex;
        _flipped = flipped;
    }
    return self;
}

@end
