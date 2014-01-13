/*
 *  PGVPCancelDoneNavBarDelegate.h
 *  ==============================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Protocol for delegate of a settings view controller navigation bar.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <Foundation/Foundation.h>


@protocol PGVPCancelDoneNavBarDelegate <NSObject>

/**
 Called when the "Cancel" button of the navigation bar is touched.
 */
- (void)navbarCancel;

/**
 Called when the "Done" button of the navigation bar is touched.
 */
- (void)navbarDone;

@end
