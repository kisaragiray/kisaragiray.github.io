#import "LocationHandler.h"

@interface LocationHandler()
- (id)init;
@end

@implementation LocationHandler

+ (id)sharedInstance {
	static LocationHandler* _instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [[LocationHandler alloc] init];
	});

	return _instance;
}

/*
+ (instancetype)sharedInstance {
	static id sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});
	return sharedInstance;
}
*/

- (id)init {
	self = [super init];
	if (self) {

	if (nil == locationManager) {

	locationManager = [CLLocationManager new];

	if (@available(iOS 8.0, *)) {
		// NSLocationWhenInUseUsageDescriptionに設定したメッセージでユーザに確認
		[locationManager requestWhenInUseAuthorization];

		// NSLocationAlwaysUsageDescriptionに設定したメッセージでユーザに確認
		//[self.locationManager requestAlwaysAuthorization];
	}
}

	if (nil == locationManager) {

		locationManager = [CLLocationManager new];
		locationManager.delegate = self;
		[locationManager startUpdatingLocation];
		locationManager.distanceFilter = kCLDistanceFilterNone;
		locationManager.desiredAccuracy = kCLLocationAccuracyBest;

		}
	}
	return self;
}

- (void)startUpdating {
	[locationManager startUpdatingLocation];
}

- (void)stopUpdating {
	[locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
   if ([self.delegate respondsToSelector:@selector
   (didUpdateToLocation:fromLocation:)]) {
      [self.delegate didUpdateToLocation:oldLocation 
      fromLocation:newLocation];
   }
}
@end