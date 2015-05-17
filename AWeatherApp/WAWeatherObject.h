//
//  WAWeatherObject.h
//  AWeatherApp
//
//  Created by Andrea Ciani on 13/05/15.
//  Copyright (c) 2015 Ciani Andrea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

/**
 *  This object is used to represent a single timestamp of weather. It if usually returned by the APIOpenWeather object.
 */
@interface WAWeatherObject : NSObject

/**
 *  The time of downloaded weather request
 */
@property (nonatomic,strong) NSDate *referenceTime;
/**
 *  The openweather weather code.
 @see @link http://openweathermap.org/weather-conditions for reference
 */
@property (nonatomic,strong) NSString* code;
/**
 *  The icon name used by openweather (do _not_ include the .png extension!)
 */
@property (nonatomic,strong) NSString *iconName;
/**
 *  The coordinate of the location requested
 */
@property (nonatomic) CLLocationCoordinate2D coordinate;
/**
 *  The description of the weather is a readable form
 */
@property (nonatomic,strong) NSString *weatherDescription;
/**
 *  Thi maximum temperature
 */
@property (nonatomic,strong) NSNumber *temperatureMax;
/**
 *  The minimum temperature
 */
@property (nonatomic,strong) NSNumber *temperatureMin;
/**
 *  The current humidity
 */
@property (nonatomic,strong) NSNumber *humidity;
/**
 *  The city name corresponding to the coordinate
 */
@property (nonatomic,strong) NSString *cityName;
/**
 *  The time of the current sunrise in the location requested
 */
@property (nonatomic,strong) NSDate *sunrise;
/**
 *  The time of the current sunset in the location requested
 */
@property (nonatomic,strong) NSDate *sunset;

@end
