//
//  City.h
//  ForecastViewer
//
//  Created by Mateusz Florczak on 04/02/17.
//
//

#import <Realm/Realm.h>
#import "WeatherForecast.h"

@interface City : RLMObject

@property NSInteger id;
@property NSString *name;
@property RLMArray<WeatherForecast *><WeatherForecast> *weatherForecasts;

@end
