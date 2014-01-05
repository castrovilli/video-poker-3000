//
//  PGVPCardPlace.m
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/4/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import "PGVPCardPlace.h"

@implementation PGVPCardPlace {
    UIImageView * _cardBackImg;;
    UIImageView * _currentCardImg;
    UIView * _emptyCardImg;
    BOOL _hasCard;
    BOOL _flipped;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ) {
        self.backgroundColor = nil;
        _emptyCardImg = [[UIView alloc] initWithFrame:frame];
        _cardBackImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card_back_blue"]];
        _currentCardImg = nil;

        [self addSubview:_emptyCardImg];
        _hasCard = NO;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipCard)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)dealCard:(int)cardIndex faceDown:(BOOL)faceDown {
    if ( _hasCard == NO ) {
        _currentCardImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i", cardIndex]]];
        _hasCard = YES;
        
        UIImageView * newView;
        
        if ( faceDown ) {
            newView = _cardBackImg;
            _flipped = YES;
        } else {
            newView = _currentCardImg;
            _flipped = NO;
        }
        
        [UIView transitionFromView:_emptyCardImg toView:newView duration:0.3 options:UIViewAnimationOptionTransitionCurlDown completion:nil];
    }
}


- (void)discardCard
{
    if ( _hasCard ) {
        _hasCard = NO;
        UIImageView * oldView;
        
        if ( _flipped ) {
            oldView = _cardBackImg;
        } else {
            oldView = _currentCardImg;
        }
        
        [UIView transitionFromView:oldView toView:_emptyCardImg duration:0.3 options:UIViewAnimationOptionTransitionCurlUp completion:nil];
    }
}


- (void)flipCard {
    if ( _hasCard ) {
        UIImageView * oldView;
        UIImageView * newView;
        UIViewAnimationOptions opts;
        
        if ( _flipped ) {
            oldView = _cardBackImg;
            newView = _currentCardImg;
            _flipped = NO;
            opts = UIViewAnimationOptionTransitionFlipFromLeft;
        } else {
            oldView = _currentCardImg;
            newView = _cardBackImg;
            _flipped = YES;
            opts = UIViewAnimationOptionTransitionFlipFromRight;
        }
        
        [UIView transitionFromView:oldView toView:newView duration:0.25 options:opts completion:nil];
    }
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
