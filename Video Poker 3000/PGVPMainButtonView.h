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

+ (id)objectWithTarget:(id)target andAction:(SEL)action;
- (instancetype)initWithTarget:(id)target andAction:(SEL)action;
- (void)setText:(NSString *)newText;

@end
