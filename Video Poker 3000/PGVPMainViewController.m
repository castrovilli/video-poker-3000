/*
 *  PGVPMainViewController.m
 *  ========================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of video poker main view controller.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPMainViewController.h"
#import "PGVPFiveCardHand.h"
#import "PGVPStatusView.h"
#import "PGVPCashView.h"
#import "PGVPBetView.h"
#import "PGCardsPokerTable.h"
#import "PGVPPayoutTableView.h"


/**
 The height of the status bar.
 */
static const CGFloat kPGVPStatusBarHeight = 20;

/**
 The height of the vertical separation between certain views.
 */
static const CGFloat kPGVPTopVertSep = 15;

/**
 The height of vertical separate between UI elements.
 */
static const CGFloat kPGVPVertSep = 7;

/**
 Bottom margin.
 */
static const CGFloat kPGVPBottomMargin = 15;


@interface PGVPMainViewController ()

/**
 Enables or disables card hand view and bet view.
 @param handStatus @c YES to enable card hand view, @c NO to disable.
 @param betStatus @c YES to enable bet view, @c NO to disable.
 */
- (void)enableHandView:(BOOL)handStatus andBetView:(BOOL)betStatus;

/**
 Updates text for button title and status view.
 @discussion This method does not update the views immediately. The new text is stored,
 and the views are updated when the card hand view notifies us that any animations
 have been completed.
 @param newTitle The new title for the main button.
 @param newStatus The new status text.
 */
- (void)updateButtonTitle:(NSString *)newTitle andStatus:(NSString *)newStatus;

/**
 Called back by the card hand view when the cards have been dealed, re-dealed
 or exchanged, and all animations are complete.
 @discussion The purpose of this callback is to delay updating the status,
 button title, and bet and cash fields until any relevant card animations are
 complete, so that the result of a hand, for instance, is not shown until all
 the cards have been exchanged and are visible.
 */
- (void)cardsAllChangedAndAnimationsComplete;

/**
 Causes the cards to be exchanged, after the player may have flipped some.
 */
- (void)exchangeCards;

/**
 Causes the cards to be dealt, or, if there is already a dealt hand, to be
 discards and re-dealt.
 */
- (void)dealOrRedealCards;

/**
 Causes the cards to be discarded.
 */
- (void)discardCards;

/**
 Called back by the main button when touched. 
 @discussion This method embodies the main game logic.
 @param sender The id of the main button.
 */
- (IBAction)mainButtonAction:(id)sender;

@end


@implementation PGVPMainViewController {
    
    /**
     The main banner image view.
     */
    UIImageView * _banner;
    
    /**
     The card hand view.
     */
    PGVPFiveCardHand * _hand;
    
    /**
     The current cash view.
     */
    PGVPCashView * _cashView;
    
    /**
     The current bet view.
     */
    PGVPBetView * _betView;
    
    /**
     The game status view.
     */
    PGVPStatusView * _statusView;
    
    /**
     The main button view.
     */
    UIButton * _dealButton;
    
    /**
     The payout table.
     */
    PGVPPayoutTableView * _payoutTable;

    /**
     A flag set to @c YES if there is a currently dealt hand, and to @c NO if
     there is not. Typically there will always be a currently dealt hand except
     for immediately prior to the start of a new game.
     */
    BOOL _dealt;
    
    /**
     The poker machine object, providing the game logic.
     */
    PGCardsPokerTable * _pokerMachine;
    
    /**
     A string to hold the button text to which to next update the main button.
     @discussion This storage is necessary as the actual updating of the main
     button text is delayed until the card hand view completes its animations.
     */
    NSString * _buttonText;
    
    /**
     A string to hold the status text to which to next update the status view.
     @discussion This storage is necessary as the actual updating of the status
     view text is delayed until the card hand view completes its animations.
     */
    NSString * _statusText;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //  Poker machine
    
    _pokerMachine = [PGCardsPokerTable new];
    
    
    //  Banner
    
    _banner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
    _banner.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_banner];
    
    
    //  Poker hand
    
    _hand = [PGVPFiveCardHand objectWithFrame:CGRectMake(15, 137, 290, 71) andMachineDelegate:_pokerMachine andNotifyDelegate:self];
    [self.view addSubview:_hand];
    
    
    //  Bet label
    
    _betView = [PGVPBetView objectWithAmount:_pokerMachine.currentBet];
    [self.view addSubview:_betView];
    
 
    //  Cash label
    
    _cashView = [PGVPCashView objectWithAmount:_pokerMachine.currentCash];
    [self.view addSubview:_cashView];
    
    
    //  Status view
    
    _statusView = [PGVPStatusView objectWithStatus:@"Welcome to Video Poker! Deal your first hand to begin."];
    [self.view addSubview:_statusView];
    
    
    //  Main button container
    
    UIView * buttonContainer = [UIView new];
    buttonContainer.translatesAutoresizingMaskIntoConstraints = NO;
    buttonContainer.layer.borderColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1].CGColor;
    buttonContainer.layer.borderWidth = 1;
    buttonContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonContainer];
    
    //  Main button
    
    _dealButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_dealButton setTitle:@"Deal cards!" forState:UIControlStateNormal];
    _dealButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [_dealButton sizeToFit];
    [_dealButton addTarget:self action:@selector(mainButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _dealButton.translatesAutoresizingMaskIntoConstraints = NO;
    [buttonContainer addSubview:_dealButton];
    _dealt = NO;
    
    
    //  Payout table
    
    _payoutTable = [[PGVPPayoutTableView alloc] initWithDelegate:_pokerMachine];
    [self.view addSubview:_payoutTable];
    
    
    //  Autolayout constraints
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_banner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_banner attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:kPGVPStatusBarHeight]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_banner attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_hand attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_banner attribute:NSLayoutAttributeBottom multiplier:1 constant:kPGVPVertSep]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_hand attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [_hand addConstraint:[NSLayoutConstraint constraintWithItem:_hand attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:290]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cashView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cashView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeBottom multiplier:1 constant:kPGVPVertSep]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_betView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_betView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:_cashView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_betView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_cashView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_statusView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_statusView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_statusView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_betView attribute:NSLayoutAttributeBottom multiplier:1 constant:kPGVPVertSep]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:buttonContainer attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:buttonContainer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:buttonContainer attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_statusView attribute:NSLayoutAttributeBottom multiplier:1 constant:kPGVPVertSep]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:buttonContainer attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_payoutTable attribute:NSLayoutAttributeTop multiplier:1 constant:-kPGVPVertSep]];
    
    [buttonContainer addConstraint:[NSLayoutConstraint constraintWithItem:_dealButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:buttonContainer attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [buttonContainer addConstraint:[NSLayoutConstraint constraintWithItem:_dealButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:buttonContainer attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    NSLayoutConstraint * butContHeight = [NSLayoutConstraint constraintWithItem:buttonContainer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:Nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:10000];
    butContHeight.priority = 1;
    [buttonContainer addConstraint:butContHeight];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_payoutTable attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_payoutTable attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_payoutTable attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-kPGVPBottomMargin]];

    
}


- (void)enableHandView:(BOOL)handStatus andBetView:(BOOL)betStatus
{
    [_hand enable:handStatus];
    [_betView enable:betStatus];
}


- (void)updateButtonTitle:(NSString *)newTitle andStatus:(NSString *)newStatus
{
    _buttonText = newTitle;
    _statusText = newStatus;
}


- (void)cardsAllChangedAndAnimationsComplete
{
    //  Now that animations are complete, update button, status and labels.
    
    [_dealButton setTitle:_buttonText forState:UIControlStateNormal];
    [_dealButton sizeToFit];
    
    [_statusView setStatusText:_statusText];
    
    [_cashView setAmount:_pokerMachine.currentCash];
    [_betView setAmount:_pokerMachine.currentBet];
}


- (void)exchangeCards
{
    if ( _dealt ) {
        [_hand exchangeCards];
    } else {
        [NSException raise:@"cards_not_dealt" format:@"No cards have been dealt."];
    }
}


- (void)dealOrRedealCards
{
    if ( _dealt == NO ) {
        [_hand dealCardsFaceUp];
        _dealt = YES;
    } else {
        [_hand redealCards];
    }
}


- (void)discardCards
{
    if ( _dealt ) {
        [_hand discardCards];
        _dealt = NO;
    } else {
        [NSException raise:@"cards_not_dealt" format:@"No cards have been dealt."];
    }
}


- (IBAction)mainButtonAction:(id)sender
{
    [_pokerMachine advanceGameState];
    
    if ( _pokerMachine.gameState == POKER_GAMESTATE_DEALED ) {
        
        //  The initial cards have been dealt, so enable the card view for flipping,
        //  and disable the bet view.
        
        [self dealOrRedealCards];
        [self enableHandView:YES andBetView:NO];
        [self updateButtonTitle:@"Exchange cards or stand"
                      andStatus:@"Touch a card to exchange it, or just keep what you have."];
        
    } else if ( _pokerMachine.gameState == POKER_GAMESTATE_EVALUATED ) {
        
        //  The cards have been exchanged and we're at the end of the hand, so disable the
        //  card view and enable the bet view to allow a new bet to be entered.
        
        [self exchangeCards];
        [self enableHandView:NO andBetView:YES];
        [self updateButtonTitle:@"Deal new hand" andStatus:_pokerMachine.evaluationString];
        
    } else if ( _pokerMachine.gameState == POKER_GAMESTATE_GAMEOVER ) {
        
        //  The cards have been exchanged and we're at the end of the hand, but the game is
        //  over since we've run out of cash, so disable both the card view and the bet
        //  view, leaving only the option to start a new game via the main button.
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Game over!" message:@"You ran out of cash!" delegate:nil cancelButtonTitle:@"Start New Game" otherButtonTitles:nil];
        [alert show];
        
        [self exchangeCards];
        [self enableHandView:NO andBetView:NO];
        [self updateButtonTitle:@"Start new game" andStatus:_pokerMachine.evaluationString];
        
    } else if ( _pokerMachine.gameState == POKER_GAMESTATE_NEWGAME ) {
        
        //  We've started a new game after losing the last one, so reset the cash and bet views
        //  to their initial values, disable the card view and enable the bet view.
        
        [self discardCards];
        [self enableHandView:NO andBetView:YES];
        [self updateButtonTitle:@"Deal your first hand!"
                      andStatus:@"Welcome to Video Poker! Deal your first hand to begin."];
        
    } else {
        
        //  We should never get here, so log error and abort if we do.
        
        NSLog(@"Unknown game state in changeCards:");
        assert(0);
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
