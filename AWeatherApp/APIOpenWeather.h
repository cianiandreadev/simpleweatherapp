//
//  APIOpenWeather.h
//  AWeatherApp
//
//  Created by Andrea Ciani on 13/05/15.
//  Copyright (c) 2015 Ciani Andrea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <CoreLocation/CoreLocation.h>

#import "WAWeatherObject.h"

/**
 *  This class provides the interface between the application and the openweather API. It contains class methods to retrive the information needed
 */
@interface APIOpenWeather : NSObject

/**
 *  Get the current weather condition given a coordinate
 *
 *  @param coordinate The coordinate of the requested location
 *  @param completion A completion block that provides a WAWeatherObject with the information needed. If an error occurs a NSError is passed back
 */
+(void)getCurrentForecastAtCoordinate:(CLLocationCoordinate2D)coordinate completion:(void(^)(WAWeatherObject *weather,NSError *error))completion;

/**
 *  Get the corresponding weather image representation from the open weater server given the corresponding code
 @see @link http://openweathermap.org/weather-conditions for reference
 *
 *  @param weatherImageCode The code of the image requested (es 02d.png). @warning Add the .png extension!
 *  @param completion       A completion block is called with the requested UIImage back if no error was found, otherwise a NSError is provided.
 */
+(void)getWeatherImageFromCode:(NSString *)weatherImageCode completion:(void(^)(UIImage *weatherImage,NSError *error))completion;

@end
