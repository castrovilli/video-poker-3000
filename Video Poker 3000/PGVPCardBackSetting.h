/*
 *  PGVPCardBackSetting.h
 *  =====================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to card back color setting view class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>
#import "PGVPOptionsTypes.h"


@interface PGVPCardBackSetting : UIView

/**
 The card back color setting.
 */
@property (assign, nonatomic, readonly) enum CardBacksChoiceOptions cardBackOption;

/**
 Sets the selected option.
 @param selection The card back color option to select.
 */
- (void)setSelection:(enum CardBacksChoiceOptions)selection;

@end
