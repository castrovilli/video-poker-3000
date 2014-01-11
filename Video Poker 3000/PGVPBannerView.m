/*
 *  PGVPBannerView.m
 *  ================
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of class to contain the main game banner.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPBannerView.h"


@implementation PGVPBannerView


+ (id)createBanner
{
    return [[PGVPBannerView alloc] initWithImage:[UIImage imageNamed:@"vp_banner"]];
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
