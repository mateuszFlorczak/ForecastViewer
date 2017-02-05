//
//  WeatherForecastDownloader.m
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

#import "WeatherForecastDownloader.h"
#import "RequestManager.h"
#import "WeatherForecastEndpoint.h"
#import <Realm/Realm.h>
#import "WeatherForecast.h"
#import "WeatherIcon.h"

@implementation WeatherForecastDownloader

- (void)downloadForecastsForCity:(City *)city {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[WeatherForecastEndpoint get5D3HForecastForCityId:city.id]];
    
    [request setHTTPMethod:@"GET"];
    
    [RequestManager sendRequest:request successCallbackBlock:^(NSData *responseData) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options:0
                                                                       error:nil];
        @try {
            NSString *cityId = [[responseDict valueForKey:@"city"] valueForKey:@"id"];
            
            RLMRealm *realm = [RLMRealm defaultRealm];
            City *city = [City objectForPrimaryKey:cityId];
            
            NSArray *list = [responseDict valueForKey:@"list"];
            
            NSMutableArray *weatherForecasts = [[NSMutableArray alloc] init];
            NSDictionary *forecastDict;
            
            for (int i = 0; i < 8; ++i) {
                forecastDict = list[i];
                
                WeatherForecast *forecast = [[WeatherForecast alloc] init];
                NSDictionary *weather = [[forecastDict valueForKey:@"weather"] objectAtIndex:0];
                NSString *iconName = [weather valueForKey:@"icon"];
                WeatherIcon *icon = [[WeatherIcon objectsWhere:@"name == %s", iconName] firstObject];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                
                forecast.temperature = [[forecastDict valueForKey:@"main"] valueForKey:@"temp"];
                forecast.type = [weather valueForKey:@"description"];
                
                if (icon == nil) {
                    icon = [[WeatherIcon alloc] init];
                    icon.name = iconName;
                    icon.iconData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", iconName]]];
                }
                forecast.icon = icon;
                forecast.date = [dateFormatter dateFromString:[forecastDict valueForKey:@"dt_txt"]];
                
                [weatherForecasts addObject:forecast];
            }
            
            [realm beginWriteTransaction];
            [city.weatherForecasts removeAllObjects];
            [city.weatherForecasts addObjects:weatherForecasts];
            [realm commitWriteTransaction];
        } @catch (NSException *exception) {
            NSLog(@"error parsing data and saving it: %@", exception);
        }
    }];
}

@end
