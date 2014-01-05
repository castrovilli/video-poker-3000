//
//  PGVPPokerMachine.h
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/5/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PGVPPokerMachine <NSObject>

-(BOOL)isCardFlipped:(int)cardPosition;
-(void)switchCardFlip:(int)cardPosition;
-(int)cardIndexAtPosition:(int)cardPosition;
-(int)getCurrentCash;
-(int)getCurrentBet;

@end
