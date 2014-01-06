/*
 *  PGVPCardPlace.h
 *  ===============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to class representing a place in a card hand.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>
#import "PGVPCardHandDelegate.h"


/**
 Time interval for a card deal transition.
 */
static const NSTimeInterval kPGVPDealTransitionTime = 0.3;

/**
 Time interval for a card flip transition.
 */
static const NSTimeInterval kPGVPFlipTransitionTime = 0.25;


@interface PGVPCardPlace : UIView

/**
 Flipped status of card, @c YES for face down, @c NO for face up.
 */
@property (assign, nonatomic, readonly) BOOL flipped;

/**
 Returns an object created with specified parameters.
 @param frame The view's frame.
 @param delegate The card hand delegate object.
 @return An object created with the specified parameters.
 */
+ (PGVPCardPlace *)objectWithFrame:(CGRect)frame andDelegate:(id<PGVPCardHandDelegate>)delegate;

/**
 Returns an object initialized with specified parameters.
 @param frame The view's frame.
 @param delegate The card hand delegate object.
 @return An object initialized with the specified parameters.
 */
- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id<PGVPCardHandDelegate>)delegate;

/**
 Deals a particular card with animation.
 @attention Do not call if a card has been previously dealt without calling @c discardCard first.
 @param cardIndex The index of the card to deal, 0-51 inclusive.
 @param faceDown @c YES to deal face down, @c NO to deal face up.
 */
- (void)dealCard:(int)cardIndex faceDown:(BOOL)faceDown;

/**
 Discards the current card with animation.
 @attention Do not call unless a card has previously been dealt with @c dealCard:faceDown: and not yet discarded.
 */
- (void)discardCard;

@end
