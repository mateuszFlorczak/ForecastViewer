//
//  WeatherForecastDownloader.h
//  ForecastViewer
//
//  Created by Mateusz Florczak on 05/02/17.
//
//

#import <Foundation/Foundation.h>
#import "City.h"

@interface WeatherForecastDownloader : NSObject

- (void)downloadForecastsForCity:(City *)city;

@end
