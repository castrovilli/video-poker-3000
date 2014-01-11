/*
 *  PGVPPayoutTableView.h
 *  =====================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to payout table view class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>
#import "PGVPPokerMachineDelegate.h"


@interface PGVPPayoutTableView : UIView

/**
 Returns an object initialized with a poker machine delegate.
 @param delegate The poker machine delegate.
 @return An objected initialized with the poker machine delegate.
 */
- (id)initWithDelegate:(id<PGVPPokerMachineDelegate>)delegate;

@end
