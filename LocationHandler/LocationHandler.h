@import UIKit;
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationHandlerDelegate <NSObject>

@required
- (void)didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation;
@end

@interface LocationHandler : NSObject<CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
}
@property(nonatomic,strong) id<LocationHandlerDelegate> delegate;

//+ (instancetype)sharedInstance;
+ (id)sharedInstance;
- (void)startUpdating;
- (void)stopUpdating;
@end