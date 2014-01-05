/*
 *  PGVPFiveCardHand.h
 *  ==================
 *  Copyright 2013 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to video poker five card hand view.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>
#import "PGVPPokerMachineDelegate.h"
#import "PGVPCardHandDelegate.h"
#import "PGVPPokerViewControllerDelegate.h"


@interface PGVPFiveCardHand : UIView <PGVPCardHandDelegate>

/**
 Returns an object created with specified parameters.
 @param frame The view's frame.
 @param machineDelegate The poker machine delegate object.
 @param notifyDelegate The delegate object for receiving notifications.
 @return An object created with the specified parameters.
 */
+ (PGVPFiveCardHand *)objectWithFrame:(CGRect)frame andMachineDelegate:(id<PGVPPokerMachineDelegate>)machineDelegate
                    andNotifyDelegate:(NSObject<PGVPPokerViewControllerDelegate> *)notifyDelegate;

/**
 Returns an object initialized with specified parameters.
 @param frame The view's frame.
 @param machineDelegate The poker machine delegate object.
 @param notifyDelegate The delegate object for receiving notifications.
 @return An object initialized with the specified parameters.
 */
- (instancetype)initWithFrame:(CGRect)frame andMachineDelegate:(id<PGVPPokerMachineDelegate>)machineDelegate
            andNotifyDelegate:(NSObject<PGVPPokerViewControllerDelegate> *)notifyDelegate;

/**
 Deals five new cards.
 @param faceDown @c YES to deal cards face down, @c NO to deal cards face up.
 */
- (void)dealCards:(BOOL)faceDown;

/**
 Deals five new cards face down.
 @attention Any existing hand should be discarded with @c discardCards prior to calling this.
 */
- (void)dealCardsFaceDown;

/**
 Deals five new cards face down.
 @attention Any existing hand should be discarded with @c discardCards prior to calling this.
 */
- (void)dealCardsFaceUp;

/**
 Discards the current cards.
 */
- (void)discardCards;

/**
 Discards the current cards, and deals a new hand face up.
 */
- (void)redealCards;

/**
 Enables and disables user interaction with the view.
 @param status @c YES to enable, @c NO to disable.
 */
- (void)enable:(BOOL)status;

/**
 Exchanges any cards that the user has flipped.
 */
- (void)exchangeCards;

@end
