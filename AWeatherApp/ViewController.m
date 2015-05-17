//
//  ViewController.m
//  AWeatherApp
//
//  Created by Andrea Ciani on 13/05/15.
//  Copyright (c) 2015 Ciani Andrea. All rights reserved.
//

#import "ViewController.h"
#import "APIOpenWeather.h"

@interface ViewController (){
    WAWeatherObject *_currentWeather;
    CLLocationManager *_locationManager;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _locationManager = [self locationManager];
    [_locationManager startUpdatingLocation];
    
    // Just to see better the lables I add some shadow. :)
    [self.ibCityNameLabel.layer setShadowColor:[[UIColor whiteColor] CGColor]];
    [self.ibCityNameLabel.layer setShadowOpacity:0.8];
    [self.ibCityNameLabel.layer setShadowRadius:4];
    
    self.ibFullScreenImageView.backgroundColor = [UIColor lightGrayColor];
    [self.ibFullScreenImageView.layer setCornerRadius:8];
    [self.ibFullScreenImageView.layer setMasksToBounds:YES];
    
    self.ibBlurView = [self blurView];
}

-(UIView*)blurView{
    UIView *view;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>8) {
        view = (UIVisualEffectView*) [[UIVisualEffectView alloc]initWithEffect:[UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]]];
        [view setFrame:self.ibBlurView.frame];
    }else{
        view = [[UIView alloc]initWithFrame:self.ibBlurView.frame];
        [view setAlpha:0.6];
    }
    return view;
}

-(CLLocationManager*)locationManager{
    CLLocationManager *locationManager = _locationManager;
    if (!locationManager) {
        locationManager = [CLLocationManager new];
    }
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) { // iOS > 7
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [locationManager setDelegate:self];
    [locationManager setPausesLocationUpdatesAutomatically:YES];
    
    return locationManager;
}

-(void)updateWeatherInterfaceWithNewWeather:(WAWeatherObject*)newWeather{
    _currentWeather = newWeather;
    self.ibCityNameLabel.text = newWeather.cityName;
    [APIOpenWeather getWeatherImageFromCode:newWeather.iconName completion:^(UIImage *weatherImage, NSError *error) {
        if(error==nil){
            self.ibFullScreenImageView.image = weatherImage;
        }
    }];
    
    self.ibWeatherDescriptionLabel.text = newWeather.weatherDescription;
    
    /* Humidity Label */
    UILabel * label = [self.ibAdditionalInfo objectAtIndex:0];
    label.text = [NSString stringWithFormat:@"Humidity: %i %%",newWeather.humidity.intValue];
    
    /* Sunset / Sunrise */
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateStyle:NSDateFormatterNoStyle];
    [df setTimeStyle:NSDateFormatterMediumStyle];
    
    label = [self.ibAdditionalInfo objectAtIndex:1];
    label.text = [NSString stringWithFormat:@"Sunrise: %@",[df stringFromDate:newWeather.sunrise]];
    
    label = [self.ibAdditionalInfo objectAtIndex:2];
    label.text = [NSString stringWithFormat:@"Sunset: %@",[df stringFromDate:newWeather.sunset]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation = [locations firstObject];
    [manager stopUpdatingLocation]; // we stop updating location to avoid server overload
    [APIOpenWeather getCurrentForecastAtCoordinate:newLocation.coordinate completion:^(WAWeatherObject *weather, NSError *error) {
        if (error==nil) {
            [self updateWeatherInterfaceWithNewWeather:weather];
        }else{
            NSLog(@"Weather network error");
        }
    }];
}


@end
