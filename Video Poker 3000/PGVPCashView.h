/*
 *  PGVPCashView.h
 *  ==============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to class to show the current cash in a video poker game.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>


@interface PGVPCashView : UIView

/**
 Returns an object created with a specified cash amount.
 @param amount The cash amount.
 @return An object created with the specified cash amount.
 */
+ (id)objectWithAmount:(int)amount;

/**
 Returns an object initialized with a specified cash amount.
 @param amount The cash amount.
 @return An object initialized with the specified cash amount.
 */
- (id)initWithFrame:(CGRect)frame andAmount:(int)amount;

/**
 Sets the cash amount.
 @param amount The cash amount.
 */
- (void)setAmount:(int)amount;

@end
