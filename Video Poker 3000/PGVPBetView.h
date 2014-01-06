/*
 *  PGVPBetView.h
 *  =============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to class to show the current bet in a video poker game.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>


@interface PGVPBetView : UIView

/**
 Returns an object created with a specified bet amount.
 @param amount The bet amount.
 @return An object created with the specified bet amount.
 */
+ (id)objectWithAmount:(int)amount;

/**
 Returns an object initialized with a specified bet amount.
 @param amount The bet amount.
 @return An object initialized with the specified bet amount.
 */
- (id)initWithFrame:(CGRect)frame andAmount:(int)amount;

/**
 Enables or disables the view.
 @param status @c YES to enable, @c NO to disable.
 */
- (void)enable:(BOOL)status;

/**
 Sets the bet amount.
 @param amount The bet amount.
 */
- (void)setAmount:(int)amount;

@end
