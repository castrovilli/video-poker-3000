/*
 *  PGVPSettingsViewController.m
 *  ============================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of view controller class for settings page.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPSettingsViewController.h"
#import "PGVPCancelDoneNavBar.h"
#import "PGVPCardBackSetting.h"
#import "PGVPPayoutSetting.h"


@interface PGVPSettingsViewController ()

@end


@implementation PGVPSettingsViewController
{
    /**
     Card back setting control.
     */
    PGVPCardBackSetting * _cardSetting;
    
    /**
     Payout setting control.
     */
    PGVPPayoutSetting * _payoutSetting;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    PGVPCancelDoneNavBar * navBar = [PGVPCancelDoneNavBar objectWithDelegate:self];
    [self.view addSubview:navBar];
    
    _cardSetting = [PGVPCardBackSetting new];
    [_cardSetting setSelection:_cardBackOption];
    [self.view addSubview:_cardSetting];

    _payoutSetting = [PGVPPayoutSetting new];
    [_payoutSetting setSelection:_payoutOption];
    [self.view addSubview:_payoutSetting];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:navBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:navBar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:navBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [navBar addConstraint:[NSLayoutConstraint constraintWithItem:navBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:60]];
   
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cardSetting attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:navBar attribute:NSLayoutAttributeBottom multiplier:1 constant:44]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cardSetting attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:-30]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_cardSetting attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_payoutSetting attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_cardSetting attribute:NSLayoutAttributeBottom multiplier:1 constant:22]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_payoutSetting attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:-30]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_payoutSetting attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
   
    
}


- (void)navbarCancel
{
    [_delegate dismissWithCancel:YES payout:_payoutSetting.payoutOption cardBack:_cardSetting.cardBackOption];
}


- (void)navbarDone
{
    [_delegate dismissWithCancel:NO payout:_payoutSetting.payoutOption cardBack:_cardSetting.cardBackOption];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
