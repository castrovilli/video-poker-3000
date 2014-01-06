//
//  PGVPBetView.h
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/4/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PGVPBetView : UIView

+ (id)objectWithAmount:(int)amount;
- (id)initWithFrame:(CGRect)frame andAmount:(int)amount;
- (void)enable:(BOOL)status;
- (void)setAmount:(int)amount;

@end
