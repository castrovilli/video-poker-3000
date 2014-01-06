/*
 *  PGVPStatusView.h
 *  ================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to class to show a video poker game's status.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>


@interface PGVPStatusView : UIView

/**
 Returns an object created with specified status text.
 @param statusText The status text.
 @return An object created with the specified status text.
 */
+ (id)objectWithStatus:(NSString *)statusText;

/**
 Returns an object initialized with specified status text.
 @param statusText The status text.
 @return An object initialized with the specified status text.
 */
- (id)initWithFrame:(CGRect)frame andStatusText:(NSString *)statusText;

/**
 Sets the status text.
 @param statusText The status text.
 */
- (void)setStatusText:(NSString *)statusText;

@end
