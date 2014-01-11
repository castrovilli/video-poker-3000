/*
 *  PGVPBetView.m
 *  =============
 *  Copyright 2014 Paul Griffiths
 *  Email: mail@paulgriffiths.net
 *
 *  Implementation of class to show the current bet in a video poker game.
 *
 *  Distributed under the terms of the GNU General Public License.
 *  http://www.gnu.org/licenses/
 */


#import "PGVPBetView.h"


/**
 Margin between the title label and the left bound of the view.
 */
static const CGFloat kPGVPSideMargin = 20;


@interface PGVPBetView ()

/**
 Formats a bet amount in a currency format.
 */
- (NSString *)formatAmount:(int)amount;

@end


@implementation PGVPBetView {
    /**
     Label to contain the title.
     */
    UILabel * _titleLabel;
    
    /**
     Label to contain the cash amount.
     */
    UILabel * _amountLabel;
    
    /**
     Picker to contain bet choices.
     */
    UIPickerView * _betPicker;
    
    /**
     Array of bet choices for picker view.
     */
    NSArray * _betAmounts;
    
    NSArray * _betAmountViews;
    
    CGFloat _betComponentWidth;
    CGFloat _betComponentHeight;
}


+ (id)objectWithAmount:(int)amount
{
    return [[PGVPBetView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andAmount:amount];
}



- (id)initWithFrame:(CGRect)frame andAmount:(int)amount
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        /*
         
        _betAmounts = @[@"$1", @"$5", @"$10", @"$20", @"$50", @"$100", @"$200", @"$500", @"$1,000"];
        
        _betComponentWidth = 0;
        _betComponentHeight = 0;
        NSMutableArray * amountViews = [NSMutableArray new];
        for ( NSString * betText in _betAmounts ) {
            UILabel * betLabel = [UILabel new];
            betLabel.text = betText;
            [betLabel sizeToFit];
            [amountViews addObject:betLabel];
            if ( betLabel.frame.size.width > _betComponentWidth ) {
                _betComponentWidth = betLabel.frame.size.width;
            }
            if ( betLabel.frame.size.height > _betComponentHeight ) {
                _betComponentHeight = betLabel.frame.size.height;
            }
        }
        _betAmountViews = [NSArray arrayWithArray:amountViews];
        
         */
        
        _titleLabel = [UILabel new];
        _titleLabel.text = @"Bet:";
        [_titleLabel sizeToFit];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_titleLabel];
        
        _amountLabel = [UILabel new];
        _amountLabel.text = [self formatAmount:amount];
        [_amountLabel sizeToFit];
        _amountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_amountLabel];
        
        /*
        _betPicker = [UIPickerView new];
        _betPicker.dataSource = self;
        _betPicker.delegate = self;
        _betPicker.showsSelectionIndicator = YES;
        [_betPicker selectRow:4 inComponent:0 animated:NO];
        _betPicker.translatesAutoresizingMaskIntoConstraints = NO;
        [_betPicker sizeToFit];
        [self addSubview:_betPicker];
        */
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        constraint.priority = 999;
        [self addConstraint:constraint];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_amountLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        constraint = [NSLayoutConstraint constraintWithItem:_amountLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        constraint.priority = 999;
        [self addConstraint:constraint];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeBaseline relatedBy:NSLayoutRelationEqual toItem:_amountLabel attribute:NSLayoutAttributeBaseline multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:_amountLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:-kPGVPSideMargin]];
        /*
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_betPicker attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_betPicker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_amountLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        */
        
    }
    return self;
}


- (CGSize)intrinsicContentSize
{
    CGSize intrinsicSize;
    intrinsicSize.width = _titleLabel.bounds.size.width + _amountLabel.bounds.size.width + kPGVPSideMargin;
    intrinsicSize.height = ((_titleLabel.bounds.size.height >= _amountLabel.bounds.size.height) ? _titleLabel.bounds.size.height : _amountLabel.bounds.size.height) + _betPicker.bounds.size.height;
    return intrinsicSize;
}


- (NSString *)formatAmount:(int)amount
{
    NSNumberFormatter * nf = [NSNumberFormatter new];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    return [NSString stringWithFormat:@"$%@", [nf stringFromNumber:[NSNumber numberWithInt:amount]]];
}


- (void)setAmount:(int)amount
{
    _amountLabel.text = [self formatAmount:amount];
    [_amountLabel sizeToFit];
}


- (void)enable:(BOOL)status
{
    self.userInteractionEnabled = status;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _betAmountViews.count;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return _betComponentHeight;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return _betComponentWidth;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    return _betAmountViews[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}
@end
