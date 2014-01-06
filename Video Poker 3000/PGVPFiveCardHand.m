/*
 *  PGVPFiveCardHand.m
 *  ==================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of video poker five card hand view.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPFiveCardHand.h"
#import "PGVPCardPlace.h"
#import "PGVPCardInfo.h"


/**
 Time interval between dealing of each subsequent card.
 */
static const NSTimeInterval kPGVPDealDelay = 0.03;

/**
 Time interval between discarding an exchanged card, and dealing the new one.
 */
static const NSTimeInterval kPGVPExchangeDelay = 0.5;

/**
 Time interval between discarding all the cards, and dealing a new hand.
 */
static const NSTimeInterval kPGVPRedealDelay = 0.5;


@interface PGVPFiveCardHand ()

/**
 Deals a single card to a specified place.
 @param cardInfo PGVPCardInfo object containing the position and card indices, and flipped status.
 */
- (void)dealCard:(PGVPCardInfo *)cardInfo;

/**
 Discards the card from a specified place.
 @param number Zero-based index of place from which to discard.
 */
- (void)discardCard:(NSNumber *)number;

@end


@implementation PGVPFiveCardHand {
    
    /**
     An array of card places.
     */
    NSMutableArray * _cards;
    
    /**
     Flag set to @c YES when a hand is currently dealt, @c NO otherwise.
     */
    BOOL _dealt;
    
    /**
     Weak reference to the poker machine delegate.
     */
    __weak id<PGVPPokerMachineDelegate> _machineDelegate;
    
    /**
     Weak reference to the view controller delegate, for notifications of animation completion.
     */
    __weak NSObject<PGVPPokerViewControllerDelegate> * _notifyDelegate;
    
}


+ (PGVPFiveCardHand *)objectWithFrame:(CGRect)frame andMachineDelegate:(id<PGVPPokerMachineDelegate>)machineDelegate
                    andNotifyDelegate:(NSObject<PGVPPokerViewControllerDelegate> *)notifyDelegate;
{
    return [[PGVPFiveCardHand alloc] initWithFrame:frame andMachineDelegate:machineDelegate andNotifyDelegate:notifyDelegate];
}


- (instancetype)initWithFrame:(CGRect)frame andMachineDelegate:(id<PGVPPokerMachineDelegate>)machineDelegate
            andNotifyDelegate:(NSObject<PGVPPokerViewControllerDelegate> *)notifyDelegate;
{
    self = [super initWithFrame:frame];
    if (self) {
        _machineDelegate = machineDelegate;
        _notifyDelegate = notifyDelegate;
        _dealt = NO;
        _cards = [NSMutableArray new];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        for ( int i = 0; i < 5; ++i ) {
            PGVPCardPlace * cardPlace = [PGVPCardPlace objectWithFrame:CGRectMake(60 * i, 0, 50, 71) andDelegate:self];
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


- (void)dealCards:(BOOL)faceDown
{
    if ( _dealt == NO ) {
        _dealt = YES;
        
        for ( int i = 0; i < 5; ++i ) {
            PGVPCardInfo * cardInfo = [PGVPCardInfo objectWithPosition:i
                                                             cardIndex:[_machineDelegate cardIndexAtPosition:(i + 1)]
                                                               flipped:faceDown];
            [self performSelector:@selector(dealCard:) withObject:cardInfo afterDelay:(i * kPGVPDealDelay)];
        }
        
        NSTimeInterval timeDelay = kPGVPDealDelay * 4 + kPGVPDealTransitionTime;
        [_notifyDelegate performSelector:@selector(cardsAllChangedAndAnimationsComplete) withObject:nil afterDelay:timeDelay];
    } else {
        [NSException raise:@"Cards already dealt" format:@"Cards already dealt"];
    }
    
}

- (void)dealCardsFaceDown
{
    [self dealCards:YES];
}


- (void)dealCardsFaceUp
{
    [self dealCards:NO];
}


- (void)dealCard:(PGVPCardInfo *)cardInfo
{
    [_cards[cardInfo.positionIndex] dealCard:cardInfo.cardIndex faceDown:cardInfo.flipped];
}


- (void)discardCard:(NSNumber *)number
{
    [_cards[[number intValue]] discardCard];
}


- (void)discardCards
{
    if ( _dealt ) {
        _dealt = NO;
        for ( int i = 0; i < 5; ++i ) {
            [self performSelector:@selector(discardCard:) withObject:@(i) afterDelay:(4 - i) * kPGVPDealDelay];
        }
    }
}


- (void)enable:(BOOL)status
{
    self.userInteractionEnabled = status;
}


- (void)wasFlipped:(id)card;
{
    for ( int i = 0; i < 5; ++i ) {
        if ( card == _cards[i]) {
            [_machineDelegate switchCardFlip:(i + 1)];
            break;
        }
    }
}


- (void)exchangeCards
{
    BOOL anyCardsFlipped = NO;
    for ( int i = 0; i < 5; ++i ) {
        PGVPCardPlace * cardPlace = _cards[i];
        
        if ( cardPlace.flipped ) {
            anyCardsFlipped = YES;
            [cardPlace discardCard];
            PGVPCardInfo * cardInfo = [PGVPCardInfo objectWithPosition:i
                                                             cardIndex:[_machineDelegate cardIndexAtPosition:(i + 1)]
                                                               flipped:NO];
            [self performSelector:@selector(dealCard:) withObject:cardInfo afterDelay:kPGVPExchangeDelay];
        }
    }
    
    NSTimeInterval timeDelay = anyCardsFlipped ? (kPGVPExchangeDelay + kPGVPFlipTransitionTime) : 0;
    [_notifyDelegate performSelector:@selector(cardsAllChangedAndAnimationsComplete) withObject:nil afterDelay:timeDelay];
}


- (void)redealCards
{
    [self discardCards];
    [self performSelector:@selector(dealCardsFaceUp) withObject:Nil afterDelay:kPGVPRedealDelay];
}


@end
