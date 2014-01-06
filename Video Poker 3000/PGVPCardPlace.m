/*
 *  PGVPCardPlace.m
 *  ===============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of class representing a place in a card hand.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPCardPlace.h"


@interface PGVPCardPlace ()

/**
 Flips a card in response to a touch and notifies the delegate.
 @attention Do not call unless a card has previously been dealt with @c dealCard:faceDown: and not yet discarded.
 */
- (void)flipCard;

@end


@implementation PGVPCardPlace {
    
    /**
     An image view containing an image of a playing card back.
     */
    UIImageView * _cardBackImg;
    
    /**
     A UIImageView containing the image of the current card.
     */
    UIImageView * _currentCardImg;
    
    /**
     An empty UIView the same size as a card image.
     */
    UIImageView * _blankCardImg;
    
    /**
     @c YES if the card place current has a card, @c NO otherwise.
     */
    BOOL _hasCard;
    
    /**
     The card hand delegate object.
     */
    __weak id<PGVPCardHandDelegate> _delegate;
    
    
}


+ (PGVPCardPlace *)objectWithFrame:(CGRect)frame andDelegate:(id<PGVPCardHandDelegate>)delegate
{
    return [[PGVPCardPlace alloc] initWithFrame:frame andDelegate:delegate];
}


- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id<PGVPCardHandDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if ( self ) {
        
        //  Initialize instance variables
        
        _delegate = delegate;
        _blankCardImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blank_card"]];
        _blankCardImg.alpha = 0.3;
        _cardBackImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card_back_blue"]];
        _currentCardImg = nil;
        _hasCard = NO;
        
        //  Begin with empty view
        
        [self addSubview:_blankCardImg];
        
        //  Create and add gesture recognizer to flip the card when tapped.
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipCard)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)dealCard:(int)cardIndex faceDown:(BOOL)faceDown {
    if ( _hasCard == NO ) {
        
        //  Change _hasCard status and update _currentCardImg with image for provided card
        
        _hasCard = YES;
        _currentCardImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i", cardIndex]]];
        
        //  Select new view based on faceDown status
        
        UIImageView * newView;        
        if ( faceDown ) {
            newView = _cardBackImg;
            _flipped = YES;
        } else {
            newView = _currentCardImg;
            _flipped = NO;
        }
        
        //  Transition to new view
        
        [UIView transitionFromView:_blankCardImg toView:newView duration:kPGVPDealTransitionTime
                           options:UIViewAnimationOptionTransitionCurlDown completion:nil];
    } else {
        [NSException raise:@"card_dealt" format:@"Already has a card"];
    }
}


- (void)discardCard
{
    if ( _hasCard ) {
        
        //  Change _hasCard status
        
        _hasCard = NO;
        
        //  Transition from current view to empty view
        
        UIImageView * currentView = _flipped ? _cardBackImg : _currentCardImg;
        [UIView transitionFromView:currentView toView:_blankCardImg duration:kPGVPDealTransitionTime
                           options:UIViewAnimationOptionTransitionCurlUp completion:nil];
    } else {
        [NSException raise:@"card_not_dealt" format:@"Does not have a card"];
    }
}


- (void)flipCard {
    if ( _hasCard ) {
        UIImageView * currentView;
        UIImageView * newView;
        UIViewAnimationOptions opts;
        
        //  Select current and new views and transition options based on current flipped status
        
        if ( _flipped ) {
            currentView = _cardBackImg;
            newView = _currentCardImg;
            _flipped = NO;
            opts = UIViewAnimationOptionTransitionFlipFromLeft;
        } else {
            currentView = _currentCardImg;
            newView = _cardBackImg;
            _flipped = YES;
            opts = UIViewAnimationOptionTransitionFlipFromRight;
        }
        
        //  Transition between views and notify delegate
        
        [UIView transitionFromView:currentView toView:newView duration:kPGVPFlipTransitionTime options:opts completion:nil];
        [_delegate wasFlipped:self];
    } else {
        [NSException raise:@"card_not_dealt" format:@"Does not have a card"];
    }
}


@end
