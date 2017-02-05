//
//  CitiesForecastCollectionViewController.h
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "City.h"
#import "WeatherForecast.h"

@interface CitiesForecastCollectionViewController : UICollectionViewController

@property (nonatomic, strong) RLMResults<City *> *cities;
@property (nonatomic, strong) RLMRealm *realm;

@property (nonatomic, strong) RLMNotificationToken *token;

@end
