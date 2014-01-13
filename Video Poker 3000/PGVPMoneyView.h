/*
 *  PGVPMoneyView.h
 *  ===============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to class to contain the bet and cash views in a video poker game.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>
#import "PGVPPokerViewControllerDelegate.h"


@interface PGVPMoneyView : UIView


/**
 Returns an object created with a specified bet and cash amount.
 @param bet The bet amount.
 @param cash The cash amount.
 @return An object created with the specified bet and cash amount.
 */
+ (id)objectWithBet:(int)bet andCash:(int)cash andDelegate:(id<PGVPPokerViewControllerDelegate>)delegate;

/**
 Returns an object initialized with a specified bet and cash amount.
 @param bet The bet amount.
 @param cash The cash amount.
 @return An object initialized with the specified bet and cash amount.
 */
- (instancetype)initWithBet:(int)bet andCash:(int)cash andDelegate:(id<PGVPPokerViewControllerDelegate>)delegate;

/**
 Sets the bet amount.
 @param amount The cash amount.
 */
- (void)setBetAmount:(int)amount;

/**
 Sets the cash amount.
 @param amount The cash amount.
 */
- (void)setCashAmount:(int)amount;

/**
 Enables or disables the view.
 @param status @c YES to enable, @c NO to disable.
 */
- (void)enable:(BOOL)status;


@end
