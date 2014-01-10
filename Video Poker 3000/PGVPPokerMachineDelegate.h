/*
 *  PGVPPokerMachineDelegate.h
 *  ==========================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Protocol for poker machine object delegates.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <Foundation/Foundation.h>
#import "PGCardsPokerHandInfo.h"


@protocol PGVPPokerMachineDelegate <NSObject>

-(BOOL)isCardFlipped:(int)cardPosition;
-(void)switchCardFlip:(int)cardPosition;
-(int)cardIndexAtPosition:(int)cardPosition;
-(int)getCurrentCash;
-(int)getCurrentBet;
-(int)getPayoutRatioForHand:(enum PGCardsVideoPokerHandType)handType;

@end
