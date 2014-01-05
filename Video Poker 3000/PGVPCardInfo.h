//
//  PGVPCardInfo.h
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/5/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGVPCardInfo : NSObject

@property (assign, nonatomic, readwrite) int positionIndex;
@property (assign, nonatomic, readwrite) int cardIndex;
@property (assign, nonatomic, readwrite) BOOL flipped;

@end
