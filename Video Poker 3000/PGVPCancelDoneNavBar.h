/*
 *  PGVPCancelDoneNavBar.h
 *  ======================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to settings navigation bar.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>
#import "PGVPCancelDoneNavBarDelegate.h"


@interface PGVPCancelDoneNavBar : UINavigationBar

/**
 Returns an object created with a delegate.
 @param delegate The delegate.
 @return An object created with the delegate.
 */
+ (id)objectWithDelegate:(id<PGVPCancelDoneNavBarDelegate>)delegate;

/**
 Returns an object initialized with a delegate.
 @param delegate The delegate.
 @return An object initialized with the delegate.
 */
- (id)initWithDelegate:(id<PGVPCancelDoneNavBarDelegate>)delegate;


@end
