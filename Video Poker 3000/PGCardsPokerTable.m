/*
 *  PGCardsPokerTable.m
 *  ===================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of poker table class.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGCardsPokerTable.h"
#import "PGCardsCard.h"
#import "PGCardsDeck.h"
#import "PGCardsPokerHand.h"
#import "PGVPCardInfo.h"


/**
 Initial bet value.
 */
static const int kPGCardsBetInitialValue = 50;

/**
 Initial bet index value.
 */
static const int kPGCardsBetIndexInitialValue = 5;

/**
 Initial cash value.
 */
static const int kPGCardsCashInitialValue = 1000;

/**
 Array of allowable bets.
 */
static const int kPGCardsBets[] = {1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000,
                                   20000, 50000, 100000, 200000, 500000, 1000000, 2000000,
                                   5000000, 10000000, 20000000, 50000000, 100000000};


@interface PGCardsPokerTable ()

/**
 Flips the card in the specified position.
 @param position The 1-based index of the card position in the hand.
 */
- (void)flipCard:(int)position;

/**
 Flips all the cards in the hand.
 */
- (void)flipCards;

/**
 Unflips the card in the specified position.
 @param position The 1-based index of the card position in the hand.
 */
- (void)unflipCard:(int)position;

/**
 Unflips all the cards in the hand.
 */
- (void)unflipCards;

/**
 Shuffles the deck and draws five cards, optionally discarding the existing hand.
 @param discard @c YES to discard the current hand, @c NO otherwise.
 */
- (void)shuffleAndDrawWithDiscard:(BOOL)discard;

/**
 Deducts the current bet from the pot.
 */
- (void)deductBetFromPot;

/**
 Resets the current bet and cash to their initial values.
 */
- (void)resetBetAndCashToInitialValues;

/**
 Sets the game state.
 @param gameState The new game state.
 */
- (void)setGameState:(enum PGCardsPokerGameState)gameState;

/**
 Updates the current cash and bet with the specified win ratio.
 @param winRatio The win ratio.
 */
- (void)updateCashAndBetWithWinRatio:(int)winRatio;

/**
 Sets the evaluation string with the specified win ratio.
 @param winRatio The win ratio.
 */
- (void)setEvaluationStringWithWinRatio:(int)winRatio;

/**
 Returns @c YES if the player is out of cash, @c NO otherwise.
 */
- (BOOL)outOfCash;

@end


@implementation PGCardsPokerTable {
    
    /**
     The poker hand.
     */
    PGCardsPokerHand * _hand;
    
    /**
     The card deck.
     */
    PGCardsDeck * _deck;
    
    /**
     The flipped status of the cards in the hand, @c YES for flipped, @c NO otherwise.
     */
    BOOL _flipped[5];
    
}


//  Public methods


- (instancetype)init
{
    if ( (self = [super init]) ) {
        _deck = [PGCardsDeck new];
        _hand = [PGCardsPokerHand new];
        _betIndex = kPGCardsBetIndexInitialValue;
        
        [self setGameState:POKER_GAMESTATE_INITIAL];
        [self resetBetAndCashToInitialValues];
        [self flipCards];
    }
    
    return self;
}


- (void)replaceFlippedCards
{
    for ( int position = 1; position < 6; ++position ) {
        if ( [self isCardFlipped:position] ) {
            [_hand replaceCardAtPosition:position fromDeck:_deck];
        }
    }
    
    [self unflipCards];
}


- (NSArray *)getCardInfoArray
{
    NSMutableArray * cardInfoArray = [NSMutableArray new];
    for ( int i = 0; i < 5; ++i ) {
        PGVPCardInfo * cardInfo = [PGVPCardInfo new];
        cardInfo.positionIndex = i;
        cardInfo.cardIndex = [_hand cardIndexAtPosition:(i + 1)];
        [cardInfoArray addObject:cardInfo];
    }
    return [NSArray arrayWithArray:cardInfoArray];
}


- (void)advanceGameState
{
    if ( self.gameState == POKER_GAMESTATE_INITIAL ) {
        
        //  Initial game state. Initial interface has been displayed prior to calling
        //  this method, so the player has already chosen her bet amount, or accepted
        //  the default, and is ready to be dealt a hand of cards, so the bet should be
        //  deducted from the pot now. The cards are initially flipped, so we should
        //  unflip them now.
        
        [self shuffleAndDrawWithDiscard:NO];
        [self unflipCards];
        [self deductBetFromPot];
        
        [self setGameState:POKER_GAMESTATE_DEALED];
        
    } else if ( self.gameState == POKER_GAMESTATE_DEALED ) {
        
        //  Cards have been dealt, and the player has flipped the cards she wants to
        //  exchange, so replace the flipped cards with new ones from the deck, which
        //  also unflips them all. Then, evaluate the resulting poker hand and update
        //  the pot with any winnings, set the evaluation string, and end the game if
        //  the player is out of cash.
        
        [self replaceFlippedCards];
        
        [_hand evaluate];
        int winRatio = [self getPayoutRatioForHand:_hand.handInfo.videoPokerHandType withType:self.payoutOption];
        
        [self updateCashAndBetWithWinRatio:winRatio];
        [self setEvaluationStringWithWinRatio:winRatio];
        
        if ( [self outOfCash] ) {
            [self setGameState:POKER_GAMESTATE_GAMEOVER];
        } else {
            [self setGameState:POKER_GAMESTATE_EVALUATED];
        }
        
    } else if ( self.gameState == POKER_GAMESTATE_EVALUATED ) {
        
        //  Player has made a new bet, if she wants, and chosen to deal another
        //  hand, so draw new cards and deduct the bet from the pot. Since the
        //  cards were already unflipped to show the final hand, we don't need
        //  to unflip them again, here.
        
        [self shuffleAndDrawWithDiscard:YES];
        [self deductBetFromPot];
        
        [self setGameState:POKER_GAMESTATE_DEALED];
        
    } else if ( self.gameState == POKER_GAMESTATE_GAMEOVER ) {
        
        //  Player has chosen to start a new game, so flip the cards to replicate the
        //  initial state, and reset the current bet and pot to their initial values.
        
        [self flipCards];
        [self resetBetAndCashToInitialValues];
        
        [self setGameState:POKER_GAMESTATE_NEWGAME];
        
    } else if ( self.gameState == POKER_GAMESTATE_NEWGAME ) {
        
        //  Following the start of a new game, game is in a situation equivalent
        //  to POKER_GAMESTATE_INITIAL where the bet has been made the the cards
        //  are ready to be drawn. The only difference is that we start with an
        //  existing hand, so we have to specify YES for shuffleAndDrawWithDiscard:.
        
        [self shuffleAndDrawWithDiscard:YES];
        [self unflipCards];
        [self deductBetFromPot];
        
        [self setGameState:POKER_GAMESTATE_DEALED];
        
    } else {
        
        //  We shouldn't ever get here, so log an error message and abort if we do.
        
        NSLog(@"Unrecognized game state in advanceGameState:");
        assert(0);
        
    }
}


- (int)getPayoutRatioForHand:(enum PGCardsVideoPokerHandType)handType withType:(enum PayoutChoiceOptions)payoutOption
{
    static const int videoPokerWinningsTableNormal[] = {0, 1, 2, 3, 4, 6, 9, 25, 50, 800};
    static const int videoPokerWinningsTableEasy[] = {0, 2, 3, 4, 15, 20, 50, 100, 250, 2500};
    int idx;
    
    switch ( handType ) {
        case VIDEOPOKERHAND_NOWIN:
            idx = 0;
            break;
            
        case VIDEOPOKERHAND_JACKSORBETTER:
            idx = 1;
            break;
            
        case VIDEOPOKERHAND_TWOPAIR:
            idx = 2;
            break;
            
        case VIDEOPOKERHAND_THREE:
            idx = 3;
            break;
            
        case VIDEOPOKERHAND_STRAIGHT:
            idx = 4;
            break;
            
        case VIDEOPOKERHAND_FLUSH:
            idx = 5;
            break;
            
        case VIDEOPOKERHAND_FULLHOUSE:
            idx = 6;
            break;
            
        case VIDEOPOKERHAND_FOUR:
            idx = 7;
            break;
            
        case VIDEOPOKERHAND_STRAIGHTFLUSH:
            idx = 8;
            break;
            
        case VIDEOPOKERHAND_ROYALFLUSH:
            idx = 9;
            break;
            
        case VIDEOPOKERHAND_NOTEVALUATED:
        default:
            assert(0);
            break;
    }
    
    if ( payoutOption == PAYOUT_CHOICE_NORMAL ) {
        return videoPokerWinningsTableNormal[idx];
    } else {
        return videoPokerWinningsTableEasy[idx];
    }
}


- (int)currentBet
{
    return [self getBetForIndex:_betIndex];
}


//  Delegate methods


- (BOOL)isCardFlipped:(int)position
{
    return _flipped[position - 1];
}


- (void)switchCardFlip:(int)position
{
    if ( [self isCardFlipped:position] ) {
        [self unflipCard:position];
    } else {
        [self flipCard:position];
    }
}


- (int)cardIndexAtPosition:(int)position
{
    return [_hand cardIndexAtPosition:position];
}


- (int)getCurrentCash
{
    return _currentCash;
}


- (int)getCurrentBet
{
    return self.currentBet;
}


- (int)getPayoutRatioForHand:(enum PGCardsVideoPokerHandType)handType
{
    return [self getPayoutRatioForHand:handType withType:self.payoutOption];
}


- (int)getBetForIndex:(int)index
{
    static const int numBets = sizeof(kPGCardsBets) / sizeof(kPGCardsBets[0]);
    
    if ( index < 0 || index >= numBets ) {
        [NSException raise:@"PGCardsPokerTable" format:@"Invalid index for getBetForIndex:"];
    }
    return kPGCardsBets[index];
}


- (int)numberOfAvailableBets
{
    return sizeof(kPGCardsBets) / sizeof(kPGCardsBets[0]);
}


- (int)getHighestAvailableBetIndex
{
    static const int numBets = sizeof(kPGCardsBets) / sizeof(kPGCardsBets[0]);
    int highest = 0;
    
    for ( int i = 0; i < numBets; ++i ) {
        if ( kPGCardsBets[i] <= _currentCash ) {
            highest = i;
        } else {
            break;
        }
    }
    
    return highest;
}


//  Private methods


- (void)flipCard:(int)position
{
    _flipped[position - 1] = YES;
}


- (void)flipCards
{
    for ( int position = 1; position < 6; ++position ) {
        [self flipCard:position];
    }
}


- (void)unflipCard:(int)position
{
    _flipped[position - 1] = NO;
}


- (void)unflipCards
{
    for ( int position = 1; position < 6; ++position ) {
        [self unflipCard:position];
    }
}


- (void)shuffleAndDrawWithDiscard:(BOOL)discard
{
    if ( discard ) {
        [_hand discardAllCardsToDeck:_deck];
        [_deck replaceDiscards];
    }
    
    [_deck shuffle];
    [_hand drawCards:5 fromDeck:_deck];
}


- (void)deductBetFromPot
{
    _currentCash -= [self getBetForIndex:_betIndex];
}


- (void)resetBetAndCashToInitialValues
{
    _betIndex = kPGCardsBetIndexInitialValue;
    _currentCash = kPGCardsCashInitialValue;
}


- (void)setGameState:(enum PGCardsPokerGameState)gameState
{
    _gameState = gameState;
}


- (void)updateCashAndBetWithWinRatio:(int)winRatio
{
    _currentCash += winRatio * [self getBetForIndex:_betIndex];
    
    if ( [self getBetForIndex:_betIndex] > _currentCash ) {
        _betIndex = [self getHighestAvailableBetIndex];
    }
}


- (void)setEvaluationStringWithWinRatio:(int)winRatio
{
    NSString * winLoseString;
    
    if ( winRatio ) {
        NSNumberFormatter * nf = [NSNumberFormatter new];
        nf.numberStyle = NSNumberFormatterDecimalStyle;
        winLoseString = [NSString stringWithFormat:@"You win $%@!",
                         [nf stringFromNumber:[NSNumber numberWithInt:winRatio * [self getBetForIndex:_betIndex]]]];
    } else {
        winLoseString = @"Better luck next time!";
    }
    
    _evaluationString = [NSString stringWithFormat:@"%@ %@", [_hand evaluateString], winLoseString];
}


- (BOOL)outOfCash
{
    return (self.currentCash < 1) ? YES : NO;
}


@end
