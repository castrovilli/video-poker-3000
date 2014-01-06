//
//  PGVPStatusView.h
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/5/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PGVPStatusView : UIView

+ (id)objectWithStatus:(NSString *)statusText;
- (void)setStatusText:(NSString *)statusText;

@end
