#import "MapViewController.h"

@implementation MapViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.view = [[UIView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];
	self.view.backgroundColor = [UIColor clearColor];

	self.mkMap = [[MKMapView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];

	self.mkMap.delegate = self;
	self.mkMap.showsUserLocation = YES;
	[self.mkMap setUserTrackingMode:MKUserTrackingModeFollow];

	MKPointAnnotation *pointAnnotation = [MKPointAnnotation new];

	CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(
		35.8291431, 
		139.6505896);
	pointAnnotation.coordinate = coordinate;

	pointAnnotation.title = @"ENE's";
	pointAnnotation.subtitle = @"私の職場です";
	[self.mkMap addAnnotation:pointAnnotation];

	[self.mkMap setCenterCoordinate:coordinate 
		animated:NO];
 
	// 縮尺を設定
	MKCoordinateRegion region = self.mkMap.region;
	region.center = coordinate;
	region.span.latitudeDelta = 0.02;
	region.span.longitudeDelta = 0.02;
	[self.mkMap setRegion:region animated:NO];



	self.mkMap.mapType = MKMapTypeStandard;

	[self.view addSubview:self.mkMap];

}
@end