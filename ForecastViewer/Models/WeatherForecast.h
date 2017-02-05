//
//  WeatherForecast.h
//  ForecastViewer
//
//  Created by Mateusz Florczak on 04/02/17.
//
//

#import <Realm/Realm.h>
#import "WeatherIcon.h"

@interface WeatherForecast : RLMObject

@property NSDate *date;
@property NSString *type;
@property NSNumber<RLMFloat> *temperature;
@property WeatherIcon *icon;

@end
RLM_ARRAY_TYPE(WeatherForecast)
