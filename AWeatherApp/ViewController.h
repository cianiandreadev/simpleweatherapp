//
//  ViewController.h
//  AWeatherApp
//
//  Created by Andrea Ciani on 13/05/15.
//  Copyright (c) 2015 Ciani Andrea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>
/* IBOutlets */
@property (strong, nonatomic) IBOutlet UILabel *ibCityNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ibFullScreenImageView;
@property (strong, nonatomic) IBOutlet UILabel *ibWeatherDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIView *ibBlurView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *ibAdditionalInfo;

@end

