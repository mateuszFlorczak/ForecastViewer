//
//  CitiesForecastCollectionViewCell.m
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

#import "CitiesForecastCollectionViewCell.h"

@implementation CitiesForecastCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _date = [[UILabel alloc] init];
        _temperature = [[UILabel alloc] init];
        _weatherImage = [[UIImageView alloc] init];
        _weatherDescription = [[UILabel alloc] init];
        
        [_weatherImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_temperature setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_date setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_weatherDescription setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.contentView addSubview:_temperature];
        [self.contentView addSubview:_date];
        [self.contentView addSubview:_weatherImage];
        [self.contentView addSubview:_weatherDescription];
        
        [_date setFont:[_date.font fontWithSize:14.0]];
        
        [_weatherDescription setNumberOfLines:2];
        [_weatherDescription setTextAlignment:NSTextAlignmentCenter];
        [_weatherDescription setAdjustsFontSizeToFitWidth:YES];
        [_weatherDescription setFont:[_weatherDescription.font fontWithSize:12.0]];
        
        [self setElement:_date aboveElement:_weatherImage];
        [self setElement:_weatherImage aboveElement:_temperature];
        [self setElement:_temperature aboveElement:_weatherDescription];

        [self centerElement:_date];
        [self centerElement:_weatherImage];
        [self centerElement:_temperature];
        [self centerElement:_weatherDescription];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_weatherDescription
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0.8
                                                                      constant:0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_weatherDescription
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:-41]];
    }
    
    [self setLayoutMargins:UIEdgeInsetsZero];
    
    return self;
}

- (void)setElement:(id)element aboveElement:(id)bottomElement {
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:element
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:bottomElement
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1
                                                                  constant:0]];
}

- (void)centerElement:(id)element {
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:element
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1
                                                                  constant:0]];
}

@end
