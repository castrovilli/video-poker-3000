/*
 *  PGVPBannerView.h
 *  ================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to class to contain the main game banner.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>


@interface PGVPBannerView : UIImageView

/**
 Returns a banner object.
 @return A banner object.
 */
+ (id)createBanner;

@end
