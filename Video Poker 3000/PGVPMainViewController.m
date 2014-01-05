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
    _dealButton.layer.borderColor = [UIColor colorWithRed:0 green:.4 blue:0 alpha:1].CGColor;
    _dealButton.layer.borderWidth = 1;
    [self.view addSubview:_dealButton];
    _dealt = NO;
    
    
    //  Poker hand
    
    _hand = [[PGVPFiveCardHand alloc] initWithFrame:CGRectMake(15, 137, 290, 71)];
    _hand.translatesAutoresizingMaskIntoConstraints = NO;
    _hand.delegate = _pokerMachine;
    [self.view addSubview:_hand];
    
    
    //  Bet label
    
    _betView = [[PGVPBetView alloc] initWithFrame:(CGRectMake(0, 0, 0, 0)) andAmount:5];
    _betView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_betView];
    
 
    //  Cash label
    
    _cashView = [[PGVPCashView alloc] initWithFrame:(CGRectMake(0, 0, 0, 0)) andAmount:100];
    _cashView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_cashView];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_banner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_banner attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_hand attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_hand attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_banner attribute:NSLayoutAttributeBottom multiplier:1 constant:20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_dealButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_dealButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_hand attribute:NSLayoutAttributeBottom multiplier:1 constant:44]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cashView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-15]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cashView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_dealButton attribute:NSLayoutAttributeBottom multiplier:1 constant:44]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_betView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:15]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_betView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:_cashView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_betView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_cashView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
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
    [_dealButton setTitle:newTitle forState:UIControlStateNormal];
    [_dealButton sizeToFit];
    
    //_resultsLabel.text = newLabel;
}

- (void)dealCards
{
    if ( _dealt == NO ) {
        [_hand dealCardsFaceUp];
        _dealt = YES;
    }
}

- (void)discardCards
{
    if ( _dealt ) {
        [_hand discardCards];
        _dealt = NO;
    }
}

- (IBAction)mainButtonAction:(id)sender
{
    /*
    if ( _dealt ) {
        [_hand discardCards];
        _dealt = NO;
        [_dealButton setTitle:@"Deal cards!" forState:UIControlStateNormal];
        [_dealButton sizeToFit];
    } else {
        [_hand dealCards];
        _dealt = YES;
        [_dealButton setTitle:@"Discard cards!" forState:UIControlStateNormal];
        [_dealButton sizeToFit];
    }
     */
    
    [_pokerMachine advanceGameState];
    [self updateBetAndWinnings];
    
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
