/*
 *  PGVPSettingsViewController.h
 *  ============================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to view controller class for settings page.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>
#import "PGVPCancelDoneNavBarDelegate.h"
#import "PGVPOptionsTypes.h"
#import "PGVPSettingsViewControllerDelegate.h"


@interface PGVPSettingsViewController : UIViewController <PGVPCancelDoneNavBarDelegate>

/**
 Card back option setting.
 */
@property (assign, nonatomic, readwrite) enum CardBacksChoiceOptions cardBackOption;

/**
 Payout option setting.
 */
@property (assign, nonatomic, readwrite) enum PayoutChoiceOptions payoutOption;

/**
 Parent view controller delegate.
 */
@property (weak, nonatomic, readwrite) id<PGVPSettingsViewControllerDelegate>delegate;

@end
