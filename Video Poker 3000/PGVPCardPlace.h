//
//  PGVPCardPlace.h
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/4/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PGVPCardPlace : UIView

- (void)dealCard:(int)cardIndex faceDown:(BOOL)faceDown;
- (void)discardCard;

@end
