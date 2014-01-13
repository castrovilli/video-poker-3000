/*
 *  PGVPPayoutSetting.h
 *  ===================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to payout setting view class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>
#import "PGVPOptionsTypes.h"


@interface PGVPPayoutSetting : UIView

/**
 The payout option.
 */
@property (assign, nonatomic, readonly) enum PayoutChoiceOptions payoutOption;

/**
 Sets the selected option.
 @param selection The payout option to select.
 */
- (void)setSelection:(enum PayoutChoiceOptions)selection;

@end
