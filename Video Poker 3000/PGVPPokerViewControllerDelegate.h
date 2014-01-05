/*
 *  PGVPPokerViewControllerDelegate.h
 *  =================================
 *  Copyright 2013 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Protocol for objects wishing to receive notifications from a card hand view.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <Foundation/Foundation.h>


@protocol PGVPPokerViewControllerDelegate <NSObject>

/**
 Message to be sent by a delegee when the card hand view has changed state and
 all animations are complete.
 */
- (void)cardsAllChangedAndAnimationsComplete;

@end
