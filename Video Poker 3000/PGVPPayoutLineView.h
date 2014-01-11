/*
 *  PGVPPayoutLineView.h
 *  ====================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to class representing a line within the payout table.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>
#import "PGVPPokerMachineDelegate.h"
#import "PGCardsPokerHandInfo.h"


@interface PGVPPayoutLineView : UIView

/**
 UILabel view for the hand description.
 */
@property (strong, nonatomic, readonly) UILabel * handLabel;

/**
 UILabel view for the hand payout ratio.
 */
@property (strong, nonatomic, readonly) UILabel * payoutLabel;

/**
 Returns an object initialized with a specified hand type and poker machine delegate.
 @param handType The hand type.
 @param delegate The poker machine delegate.
 @return An object initialized with the specified hand type and poker machine delegate.
 */
- (instancetype)initWithHandType:(enum PGCardsVideoPokerHandType)handType andDelegate:(id<PGVPPokerMachineDelegate>)delegate;

@end
