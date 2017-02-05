//
//  WeatherForecastEndpoint.m
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

#import "WeatherForecastEndpoint.h"

@implementation WeatherForecastEndpoint
static NSString *API_KEY = @"04b707d9154f699d7a9b3b14e8fecef7";
static NSString *BASE_URL = @"http://api.openweathermap.org/";

+ (NSURL *)get5D3HForecastForCityId:(NSInteger)cityId {
    NSString *urlAsString = [[NSString alloc] initWithString:BASE_URL];
    urlAsString = [urlAsString stringByAppendingString:@"data/2.5/forecast"];
    urlAsString = [urlAsString stringByAppendingString:[NSString stringWithFormat:@"?id=%ld&APPID=%@&units=metric", cityId, API_KEY]];
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    return url;
}

@end
