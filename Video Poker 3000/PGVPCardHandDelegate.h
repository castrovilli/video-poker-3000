/*
 *  PGVPCardHandDelegate.h
 *  ======================
 *  Copyright 2013 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Protocol for objects wishing to receive notifications from a card place view.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import <Foundation/Foundation.h>


@protocol PGVPCardHandDelegate <NSObject>

/**
 Message to be sent by a delegee when a card was flipped.
 */
- (void)wasFlipped:(id)card;

@end
