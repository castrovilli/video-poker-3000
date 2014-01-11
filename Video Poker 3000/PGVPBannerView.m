//
//  PGVPBannerView.m
//  Video Poker 3000
//
//  Created by Paul Griffiths on 1/11/14.
//  Copyright (c) 2014 Paul Griffiths. All rights reserved.
//

#import "PGVPBannerView.h"

@implementation PGVPBannerView


+ (id)createBanner
{
    return [[PGVPBannerView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
}

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}


@end
