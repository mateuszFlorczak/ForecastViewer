//
//  CitiesForecastCollectionViewController.m
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

#import "CitiesForecastCollectionViewController.h"
#import "CitiesForecastCollectionViewCell.h"
#import "HeaderCollectionViewCell.h"
#import "StaticHeadersCollectionViewLayout.h"
#import "WeatherForecastDownloader.h"
#import "WeatherIcon.h"

@interface CitiesForecastCollectionViewController ()

@end

@implementation CitiesForecastCollectionViewController

static NSString * const forecastReuseIdentifier = @"CitiesForecastCollectionViewCell";
static NSString * const headerReuseIdentifier = @"HeaderCollectionViewCell.h";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCollectionView];
    [self setUpRealm];
    [self setUpData];
}

#pragma mark private inits

- (void)setUpCollectionView {
    [self.collectionView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    
    [self.collectionView registerClass:CitiesForecastCollectionViewCell.self forCellWithReuseIdentifier:forecastReuseIdentifier];
    [self.collectionView registerClass:HeaderCollectionViewCell.self forCellWithReuseIdentifier:headerReuseIdentifier];
    
    [self.collectionView setScrollEnabled:YES];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
}

- (void)setUpRealm {
    _realm = [RLMRealm defaultRealm];
    
    __weak typeof(self) weakSelf = self;
    _token = [_realm addNotificationBlock:^(RLMNotification  _Nonnull notification, RLMRealm * _Nonnull realm) {
        [weakSelf.collectionView reloadData];
    }];
}

- (void)setUpData {
    _cities = [City allObjects];
    
    WeatherForecastDownloader *downloader = [[WeatherForecastDownloader alloc] init];
    for (City *city in _cities) {
        [downloader downloadForecastsForCity:city];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _cities.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (_cities[section].weatherForecasts != nil) {
//        return _cities[section].weatherForecasts.count;
//    } else {
//        return 1;
//    }
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        HeaderCollectionViewCell *cell = (HeaderCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
        
        cell.title.text = [_cities[indexPath.section].name uppercaseString];
        
        return cell;
    } else {
        CitiesForecastCollectionViewCell *cell = (CitiesForecastCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:forecastReuseIdentifier forIndexPath:indexPath];
        
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        if (_cities[indexPath.section].weatherForecasts != nil) {
            NSInteger row = indexPath.row - 1;
            
            if (_cities[indexPath.section].weatherForecasts.count > row) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                WeatherForecast *forecast = _cities[indexPath.section].weatherForecasts[row];
                
                [dateFormatter setDateFormat:@"EEEE H:mma"];
                
                cell.date.text = [dateFormatter stringFromDate:forecast.date];
                cell.weatherImage.image = [UIImage imageWithData:forecast.icon.iconData];
                cell.weatherDescription.text = forecast.type;
                cell.temperature.text = [NSString stringWithFormat:@"%d°C", (int)[forecast.temperature integerValue]];
                
                if (indexPath.section % 2) {
                    [cell setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.25]];
                }
            }
        }
        
        return cell;
    }
}

@end
