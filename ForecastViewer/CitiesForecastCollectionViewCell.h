//
//  CitiesForecastCollectionViewCell.h
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

#import <UIKit/UIKit.h>

@interface CitiesForecastCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *date;
@property (nonatomic, strong) UILabel *weatherDescription;
@property (nonatomic, strong) UILabel *temperature;
@property (nonatomic, strong) UIImageView *weatherImage;

@end
