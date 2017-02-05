//
//  WeatherIcon.h
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

#import <Realm/Realm.h>

@interface WeatherIcon : RLMObject

@property NSString *name;
@property NSData *iconData;

@end
