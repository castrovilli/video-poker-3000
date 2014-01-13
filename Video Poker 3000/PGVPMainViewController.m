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
#import "PGCardsPokerTable.h"
#import "PGVPOptionsTypes.h"
#import "PGVPBannerView.h"
#import "PGVPFiveCardHand.h"
#import "PGVPMoneyView.h"
#import "PGVPStatusView.h"
#import "PGVPMainButtonView.h"
#import "PGVPPayoutTableView.h"
#import "PGVPSettingsViewController.h"


/**
 The height of the status bar.
 */
static const CGFloat kPGVPStatusBarHeight = 20;

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
    PGVPBannerView * _banner;
    
    /**
     The card hand view.
     */
    PGVPFiveCardHand * _hand;
    
    /**
     The current cash view.
     */
    PGVPMoneyView * _moneyView;
    
    /**
     The game status view.
     */
    PGVPStatusView * _statusView;
    
    /**
     The main button view.
     */
    PGVPMainButtonView * _dealButton;
    
    /**
     The payout table.
     */
    PGVPPayoutTableView * _payoutTable;
    
    /**
     A settings button.
     */
    UIButton * _settingsButton;
    
    /**
     An array of spacer views.
     */
    NSArray * _spacerViews;

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
    
    /**
     Card back choice option.
     */
    enum CardBacksChoiceOptions _cardBackOption;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //  Set instance variables and background color

    self.view.backgroundColor = [UIColor whiteColor];
    _dealt = NO;
    _pokerMachine = [PGCardsPokerTable new];
    _cardBackOption = CARDBACKS_CHOICE_BLUE;
    
    
    //  Create sub views
    
    _banner = [PGVPBannerView createBanner];
    _hand = [PGVPFiveCardHand objectWithFrame:CGRectMake(15, 137, 290, 71) andMachineDelegate:_pokerMachine andNotifyDelegate:self];
    _moneyView = [PGVPMoneyView objectWithBet:_pokerMachine.currentBet andCash:_pokerMachine.currentCash];
    _statusView = [PGVPStatusView objectWithStatus:@"Welcome to Video Poker! Deal your first hand to begin."];
    _dealButton = [PGVPMainButtonView objectWithTarget:self andAction:@selector(mainButtonAction:)];
    _payoutTable = [[PGVPPayoutTableView alloc] initWithDelegate:_pokerMachine];
    
    _settingsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _settingsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_settingsButton addTarget:self action:@selector(showSettings) forControlEvents:UIControlEventTouchUpInside];
    [_settingsButton setImage:[UIImage imageNamed:@"settings_icon_small"] forState:UIControlStateNormal];
    
    
    //  Add sub views
    
    [self.view addSubview:_banner];
    [self.view addSubview:_hand];
    [self.view addSubview:_moneyView];
    [self.view addSubview:_statusView];
    [self.view addSubview:_dealButton];
    [self.view addSubview:_payoutTable];
    [self.view addSubview:_settingsButton];
    
    
    //  Horizontally layout sub views
   
    [_hand addConstraint:[NSLayoutConstraint constraintWithItem:_hand attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:290]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_banner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_hand attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

    for ( UIView * currentView in @[_moneyView, _statusView, _dealButton, _payoutTable] ) {
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    }
    
    
    //  Vertically layout top and bottom sub views against root view
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_banner attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:kPGVPStatusBarHeight]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_payoutTable attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-kPGVPBottomMargin]];

    
    //  Create spacer views and add constraints between UI views
    
    NSArray * views = @[_banner, _hand, _moneyView, _statusView, _dealButton, _payoutTable];
    int numViews = views.count;
    NSMutableArray * spaces = [NSMutableArray new];
    
    for ( int i = 0; i < (numViews - 1); ++i ) {
        UIView * upperView = views[i];
        UIView * lowerView = views[i+1];
        UIView * spacerView = [UIView new];
        spacerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:spacerView];
        [spaces addObject:spacerView];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:upperView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:spacerView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:lowerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:spacerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    }
    
    _spacerViews = [NSArray arrayWithArray:spaces];
    
    
    //  Set constraints to equalize and maximize height of spacer views
    
    for ( int i = 0; i < (numViews - 1); ++i ) {
        if ( i < (numViews - 2) ) {
            NSLayoutConstraint * equalSpace = [NSLayoutConstraint constraintWithItem:spaces[i] attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:spaces[i+1] attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
            equalSpace.priority = 5;
            [self.view addConstraint:equalSpace];
        }
      
        NSLayoutConstraint * maximumHeight = [NSLayoutConstraint constraintWithItem:spaces[i] attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:10000];
        maximumHeight.priority = 4;
        [spaces[i] addConstraint:maximumHeight];
    }
    
    
    //  Layout settings button
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_settingsButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_payoutTable attribute:NSLayoutAttributeRight multiplier:1 constant:-10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_settingsButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_payoutTable attribute:NSLayoutAttributeBottom multiplier:1 constant:-10]];
    
}


- (void)enableHandView:(BOOL)handStatus andBetView:(BOOL)betStatus
{
    [_hand enable:handStatus];
    [_moneyView enable:betStatus];
}


- (void)updateButtonTitle:(NSString *)newTitle andStatus:(NSString *)newStatus
{
    _buttonText = newTitle;
    _statusText = newStatus;
}


- (void)cardsAllChangedAndAnimationsComplete
{
    //  Now that animations are complete, update button, status and labels.
    
    [_dealButton setText:_buttonText];
    
    [_statusView setStatusText:_statusText];
    
    [_moneyView setCashAmount:_pokerMachine.currentCash];
    [_moneyView setBetAmount:_pokerMachine.currentBet];
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


- (void)showSettings
{
    PGVPSettingsViewController * controller = [PGVPSettingsViewController new];
    controller.cardBackOption = _cardBackOption;
    controller.payoutOption = _pokerMachine.payoutOption;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)dismissWithCancel:(BOOL)didCancel payout:(enum PayoutChoiceOptions)payoutOption cardBack:(enum CardBacksChoiceOptions)cardBack
{
    if ( !didCancel ) {
        _cardBackOption = cardBack;
        _pokerMachine.payoutOption = payoutOption;
        [_hand setCardBackColor:cardBack];
        [_payoutTable updatePayoutLabels];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
