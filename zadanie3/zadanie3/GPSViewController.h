//
//  GPSViewController.h
//  zadanie3
//
//  Created by Adam on 17/10/2024.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPSViewController : UIViewController
{
    CLLocationManager* locationManager;
    CLGeocoder* geocoder;
    CLPlacemark* placemark;
}

@property (weak, nonatomic) IBOutlet UILabel *latitudeField;
@property (weak, nonatomic) IBOutlet UILabel *longitudeField;
@property (weak, nonatomic) IBOutlet UILabel *addressField;

- (IBAction)getCurrentLocation:(id)sender;

@end

NS_ASSUME_NONNULL_END
