//
//  WeatherForecastEndpoint.h
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

#import <Foundation/Foundation.h>

@interface WeatherForecastEndpoint : NSObject

+ (NSURL *)get5D3HForecastForCityId:(NSInteger)cityId;

@end
