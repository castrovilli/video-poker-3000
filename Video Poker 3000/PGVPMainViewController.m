//
//  PGVPMainViewController.m
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/4/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import "PGVPMainViewController.h"
#import "PGVPFiveCardHand.h"
#import "PGVPCashView.h"
#import "PGVPBetView.h"
#import "PGCardsPokerTable.h"
#import "PGVPCardInfo.h"

static const int kSideMargin = 15;
static const int kTopVertSep = 20;
static const int kResultsMargin = 10;

@interface PGVPMainViewController ()

@end

@implementation PGVPMainViewController {
    UIImageView * _banner;
    PGVPFiveCardHand * _hand;
    UIButton * _dealButton;
    PGVPCashView * _cashView;
    PGVPBetView * _betView;
    BOOL _dealt;
    PGCardsPokerTable * _pokerMachine;
    UILabel * _resultsLabel;
    NSString * _buttonText;
    NSString * _resultsText;
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
    
    
    //  Main button
    
    _dealButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_dealButton setTitle:@"Deal cards!" forState:UIControlStateNormal];
    [_dealButton sizeToFit];
    [_dealButton addTarget:self action:@selector(mainButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _dealButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_dealButton];
    _dealt = NO;
    
    
    //  Poker hand
    
    _hand = [PGVPFiveCardHand objectWithFrame:CGRectMake(15, 137, 290, 71) andMachineDelegate:_pokerMachine andNotifyDelegate:self];
    _hand.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_hand];
    
    
    //  Bet label
    
    _betView = [[PGVPBetView alloc] initWithFrame:(CGRectMake(0, 0, 0, 0)) andAmount:5];
    _betView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_betView];
    
 
    //  Cash label
    
    _cashView = [[PGVPCashView alloc] initWithFrame:(CGRectMake(0, 0, 0, 0)) andAmount:100];
    _cashView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_cashView];
    
    
    //  Results container
    
    UIView * _resultsContainer = [UIView new];
    _resultsContainer.backgroundColor = [UIColor colorWithRed:.8 green:1 blue:.8 alpha:1];
    _resultsContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_resultsContainer];
    

    //  Results label
    
    _resultsLabel = [UILabel new];
    _resultsLabel.text = @"Welcome to Video Poker! Deal your first hand to begin.";
    [_resultsLabel sizeToFit];
    _resultsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _resultsLabel.numberOfLines = 2;
    _resultsLabel.textAlignment = NSTextAlignmentCenter;
    [_resultsContainer addSubview:_resultsLabel];

    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_banner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_banner attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_hand attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_hand attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_banner attribute:NSLayoutAttributeBottom multiplier:1 constant:kTopVertSep]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cashView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-kSideMargin]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cashView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeBottom multiplier:1 constant:kTopVertSep]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_betView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:kSideMargin]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_betView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:_cashView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_betView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_cashView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_resultsContainer attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_resultsContainer attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:kSideMargin]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_resultsContainer attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-kSideMargin]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_resultsContainer attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_cashView attribute:NSLayoutAttributeBottom multiplier:1 constant:kTopVertSep]];

    [_resultsContainer addConstraint:[NSLayoutConstraint constraintWithItem:_resultsLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_resultsContainer attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [_resultsContainer addConstraint:[NSLayoutConstraint constraintWithItem:_resultsLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:_resultsContainer attribute:NSLayoutAttributeLeft multiplier:1 constant:kResultsMargin]];
    [_resultsContainer addConstraint:[NSLayoutConstraint constraintWithItem:_resultsLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:_resultsContainer attribute:NSLayoutAttributeRight multiplier:1 constant:-kResultsMargin]];
    [_resultsContainer addConstraint:[NSLayoutConstraint constraintWithItem:_resultsLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_resultsContainer attribute:NSLayoutAttributeTop multiplier:1 constant:kResultsMargin]];
    [_resultsContainer addConstraint:[NSLayoutConstraint constraintWithItem:_resultsLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_resultsContainer attribute:NSLayoutAttributeBottom multiplier:1 constant:-kResultsMargin]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_dealButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_dealButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_resultsContainer attribute:NSLayoutAttributeBottom multiplier:1 constant:44]];
    
}


- (void)enableCardButtons:(BOOL)handStatus andBetTextField:(BOOL)betStatus {
    [_hand enable:handStatus];
    [_betView enable:betStatus];
}


- (void)updateBetAndWinnings {
    [_cashView setAmount:_pokerMachine.currentCash];
    [_betView setAmount:_pokerMachine.currentBet];
}

- (void)updateButtonTitle:(NSString *)newTitle andResultsLabel:(NSString *)newLabel {
    _buttonText = newTitle;
    _resultsText = newLabel;
    
    /*
    [_dealButton setTitle:newTitle forState:UIControlStateNormal];
    [_dealButton sizeToFit];
    
    _resultsLabel.text = newLabel;
    [_resultsLabel sizeToFit];
     */
}

- (void)exchangeCards
{
    [_hand exchangeCards];
}


- (void)dealCards
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
    }
}

- (void)cardsAllChanged
{
    [_dealButton setTitle:_buttonText forState:UIControlStateNormal];
    [_dealButton sizeToFit];
    
    _resultsLabel.text = _resultsText;
    [_resultsLabel sizeToFit];
    
    [self updateBetAndWinnings];

}

- (IBAction)mainButtonAction:(id)sender
{
    
    [_pokerMachine advanceGameState];

    if ( _pokerMachine.gameState == POKER_GAMESTATE_DEALED ) {
        
        //  The initial cards have been dealt, so enable the card buttons for flipping,
        //  and disable the bet field.
        
        [self dealCards];
        [self enableCardButtons:YES andBetTextField:NO];
        [self updateButtonTitle:@"Exchange cards or stand"
                andResultsLabel:@"Touch a card to exchange it, or just keep what you have."];
        
    } else if ( _pokerMachine.gameState == POKER_GAMESTATE_EVALUATED ) {
        
        //  The cards have been exchanged and we're at the end of the hand, so disable the
        //  card buttons and enable the bet text field to allow a new bet to be entered.
        
        [self exchangeCards];
        [self enableCardButtons:NO andBetTextField:YES];
        [self updateButtonTitle:@"Deal new hand" andResultsLabel:_pokerMachine.evaluationString];
        
    } else if ( _pokerMachine.gameState == POKER_GAMESTATE_GAMEOVER ) {
        
        //  The cards have been exchanged and we're at the end of the hand, but the game is
        //  over since we've run out of cash, so disable both the card buttons and the bet
        //  text field, leaving only the option to start a new game via the main button.
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Game over!" message:@"You ran out of cash!" delegate:nil cancelButtonTitle:@"Start New Game" otherButtonTitles:nil];
        [alert show];
        
        [self enableCardButtons:NO andBetTextField:NO];
        [self updateButtonTitle:@"Start new game" andResultsLabel:_pokerMachine.evaluationString];
        
    } else if ( _pokerMachine.gameState == POKER_GAMESTATE_NEWGAME ) {
        
        //  We've started a new game after losing the last one, so reset the fields to their
        //  initial values, and disable the card buttons and enable the bet field.
        
        [self discardCards];
        [self enableCardButtons:NO andBetTextField:YES];
        [self updateButtonTitle:@"Deal your first hand!"
                andResultsLabel:@"Welcome to Video Poker! Deal your first hand to begin."];
        
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
