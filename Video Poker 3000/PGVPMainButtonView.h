/*
 *  PGVPMainButtonView.h
 *  ====================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Interface to class for main video poker game action button.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <UIKit/UIKit.h>


@interface PGVPMainButtonView : UIView

/**
 Returns an object created with a specified target and action.
 @param target The target object, which will receive the action message.
 @param action The action message selector.
 @return An object created with the specified target and action.
 */
+ (id)objectWithTarget:(id)target andAction:(SEL)action;

/**
 Returns an object initialized with a specified target and action.
 @param target The target object, which will receive the action message.
 @param action The action message selector.
 @return An object initialized with the specified target and action.
 */
- (instancetype)initWithTarget:(id)target andAction:(SEL)action;

/**
 Sets the button text.
 @param newText The new text for the button.
 */
- (void)setText:(NSString *)newText;

@end
