/*
 *  PGVPCancelDoneNavBar.m
 *  ======================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of settings navigation bar.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPCancelDoneNavBar.h"


@implementation PGVPCancelDoneNavBar
{
    /**
     The delegate.
     */
    id<PGVPCancelDoneNavBarDelegate> _delegate;
}


+ (id)objectWithDelegate:(id<PGVPCancelDoneNavBarDelegate>)delegate
{
    return [[PGVPCancelDoneNavBar alloc] initWithDelegate:delegate];
}


- (id)initWithDelegate:(id<PGVPCancelDoneNavBarDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        UINavigationItem * topItem = [UINavigationItem new];
        topItem.title = @"Settings";
        
        UIBarButtonItem * cancelButton = [UIBarButtonItem new];
        cancelButton.title = @"Cancel";
        cancelButton.target = self;
        cancelButton.action = @selector(touchedCancelButton);
        topItem.leftBarButtonItem = cancelButton;
        
        UIBarButtonItem * doneButton = [UIBarButtonItem new];
        doneButton.title = @"Done";
        doneButton.target = self;
        doneButton.action = @selector(touchedDoneButton);
        topItem.rightBarButtonItem = doneButton;
        
        [self pushNavigationItem:topItem animated:NO];
    }
    return self;
}


- (void)touchedCancelButton
{
    [_delegate navbarCancel];
}


- (void)touchedDoneButton
{
    [_delegate navbarDone];
}


@end
