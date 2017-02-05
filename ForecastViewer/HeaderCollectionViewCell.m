//
//  HeaderCollectionViewCell.m
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

#import "HeaderCollectionViewCell.h"

@implementation HeaderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    _title = [[UILabel alloc] init];
    [_title setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:_title];
    
    [_title setTextColor:[UIColor colorWithRed:0.37 green:0.48 blue:0.97 alpha:1.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_title
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1
                                                                  constant:8]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_title
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1
                                                                  constant:8]];
    
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    
    return self;
}
@end
