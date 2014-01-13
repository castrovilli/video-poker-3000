/*
 *  PGVPSettingsViewControllerDelegate.h
 *  ====================================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Protocol for delegate of a settings view controller parent view controller.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <Foundation/Foundation.h>
#import "PGVPOptionsTypes.h"


@protocol PGVPSettingsViewControllerDelegate <NSObject>

/**
 Called when the settings view controller should be dismissed.
 @param didCancel @c YES if the settings change was cancelled, @c NO if settings should be changed.
 @param payoutOption The payout option.
 @param cardBack The card back color option.
 */
- (void)dismissWithCancel:(BOOL)didCancel payout:(enum PayoutChoiceOptions)payoutOption cardBack:(enum CardBacksChoiceOptions)cardBack;

@end
