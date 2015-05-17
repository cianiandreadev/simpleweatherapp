//
//  APIOpenWeather.m
//  AWeatherApp
//
//  Created by Andrea Ciani on 13/05/15.
//  Copyright (c) 2015 Ciani Andrea. All rights reserved.
//

#import "APIOpenWeather.h"

#define OW_APP_KEY @""

NSString * const api_base_url = @"http://api.openweathermap.org/data/2.5/";
NSString * const api_image_url = @"http://openweathermap.org/img/w/";


@implementation APIOpenWeather

+(void)getCurrentForecastAtCoordinate:(CLLocationCoordinate2D)coordinate completion:(void(^)(WAWeatherObject *weather,NSError *error))completion{
    
    NSString *url = [api_base_url stringByAppendingString:[NSString stringWithFormat:@"weather?lat=%f&lon=%f",
                                                           coordinate.latitude,coordinate.longitude]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager new];
    
    AFHTTPRequestOperation *getRequest = [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        
        WAWeatherObject *weather = [WAWeatherObject new];
        weather.referenceTime = [NSDate date];
        weather.code = responseObject[@"weather"][0][@"id"];
        weather.iconName = responseObject[@"weather"][0][@"icon"];
        weather.coordinate = coordinate;
        weather.weatherDescription = responseObject[@"weather"][0][@"description"];
        weather.temperatureMax = numberFromString(responseObject[@"main"][@"temp_max"]);
        weather.temperatureMin = numberFromString(responseObject[@"main"][@"temp_min"]);
        weather.humidity = numberFromString(responseObject[@"main"][@"humidity"]);
        weather.cityName = responseObject[@"name"];
        weather.sunrise = [NSDate dateWithTimeIntervalSince1970:(numberFromString(responseObject[@"sys"][@"sunrise"]).doubleValue)];
        weather.sunset = [NSDate dateWithTimeIntervalSince1970:(numberFromString(responseObject[@"sys"][@"sunset"]).doubleValue)];
        
        
        completion(weather,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil,error);
    }];
    
    [getRequest start];
    
}

+(void)getWeatherImageFromCode:(NSString *)weatherImageCode completion:(void(^)(UIImage *weatherImage,NSError *error))completion{
    NSString *url = [api_image_url stringByAppendingString:[NSString stringWithFormat:@"%@.png",weatherImageCode]];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion((UIImage*)responseObject,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil,error);
    }];
    [requestOperation start];
}

// Just a fast C function to transform a string to a number
NSNumber* numberFromString(NSString* string){
    return [NSNumber numberWithFloat:(string.floatValue)];
}

@end
