//
//  PGVPFiveCardHand.m
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/4/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import "PGVPFiveCardHand.h"
#import "PGVPCardPlace.h"
#import "PGVPCardInfo.h"

@implementation PGVPFiveCardHand {
    NSMutableArray * _cards;
    BOOL _dealt;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dealt = NO;
        _cards = [NSMutableArray new];
        for ( int i = 0; i < 5; ++i ) {
            PGVPCardPlace * cardPlace = [[PGVPCardPlace alloc] initWithFrame:CGRectMake(60 * i, 0, 50, 71)];
            [self addSubview:cardPlace];
            [_cards addObject:cardPlace];
        }
    }
    return self;
}


- (CGSize)intrinsicContentSize
{
    return CGSizeMake(290, 71);
}

- (void)dealCardsFaceDown
{
    if ( _dealt == NO ) {
        _dealt = YES;
        
        for ( int i = 0; i < 5; ++i ) {
            PGVPCardInfo * cardInfo = [PGVPCardInfo new];
            cardInfo.positionIndex = i;
            cardInfo.cardIndex = [self.delegate cardIndexAtPosition:(i + 1)];
            cardInfo.flipped = YES;
            [self performSelector:@selector(dealCard:) withObject:cardInfo afterDelay:i * 0.03];        }
    }
}

- (void)dealCardsFaceUp
{
    if ( _dealt == NO ) {
        _dealt = YES;
        
        for ( int i = 0; i < 5; ++i ) {
            PGVPCardInfo * cardInfo = [PGVPCardInfo new];
            cardInfo.positionIndex = i;
            cardInfo.cardIndex = [self.delegate cardIndexAtPosition:(i + 1)];
            cardInfo.flipped = NO;
            [self performSelector:@selector(dealCard:) withObject:cardInfo afterDelay:i * 0.03];        }
    }
}




- (void)dealCardsWithArray:(NSArray *)cardArray flipped:(BOOL)flipped
{
    if ( _dealt == NO ) {
        _dealt = YES;
        
        for ( int i = 0; i < 5; ++i ) {
            PGVPCardInfo * cardInfo = cardArray[i];
            if ( flipped ) {
                [self performSelector:@selector(dealCardFaceDown:) withObject:cardInfo afterDelay:i * 0.03];
            } else {
                [self performSelector:@selector(dealCardFaceUp:) withObject:cardInfo afterDelay:i * 0.03];
            }
        }
    }
}

- (void)dealCard:(PGVPCardInfo *)cardInfo
{
    [_cards[cardInfo.positionIndex] dealCard:cardInfo.cardIndex faceDown:cardInfo.flipped];
}


- (void)dealCardFaceDown:(PGVPCardInfo *)cardInfo
{
    [_cards[cardInfo.positionIndex] dealCard:cardInfo.cardIndex faceDown:YES];
}

- (void)dealCardFaceUp:(PGVPCardInfo *)cardInfo
{
    [_cards[cardInfo.positionIndex] dealCard:cardInfo.cardIndex faceDown:NO];
}


- (void)discardCard:(NSNumber *)number
{
    int idx = [number intValue];
    [_cards[idx] discardCard];
}

- (void)discardCards
{
    if ( _dealt ) {
        _dealt = NO;
        for ( int i = 0; i < 5; ++i ) {
            [self performSelector:@selector(discardCard:) withObject:@(i) afterDelay:(4 - i) * 0.03];
        }
    }
}

- (void)enable:(BOOL)status
{
    self.userInteractionEnabled = status;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
