//
//  GPSViewController.m
//  zadanie3
//
//  Created by Adam on 17/10/2024.
//

#import "GPSViewController.h"

@interface GPSViewController () <CLLocationManagerDelegate>

@end

@implementation GPSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    // Do any additional setup after loading the view.
}

- (IBAction)getCurrentLocation:(id)sender {
    locationManager.delegate = self;
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Failed to update location with error %@", error);
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Location error" message:@"Failed to get location" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
        [self.view setBackgroundColor:[UIColor systemRedColor]];
    }];
    [alertController addAction:okButton];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"Location updated");
    [self.view setBackgroundColor:[UIColor systemBackgroundColor]];
    
    CLLocation* currentLocation = [locations lastObject];
    if (currentLocation != nil) {
        _longitudeField.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        _latitudeField.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    }
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Failed to reverse location into address: %@", error);
            return;
        }
        if ([placemarks count] < 0) {
            NSLog(@"Got 0 placemarks as result of reversing geocode location");
            return;
        }
        self->placemark = [placemarks lastObject];
        self->_addressField.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                    self->placemark.subThoroughfare, self->placemark.thoroughfare, self->placemark.postalCode, self->placemark.locality, self->placemark.administrativeArea, self->placemark.country];
    }];
}


@end
