@import Foundation;
@import UIKit;
@import WebKit;
@import UserNotifications;
@import AVFoundation;
@import AVKit;
@import LocalAuthentication;
@import CoreMotion;
@import CoreLocation;

#import <Cephei/HBPreferences.h>
#import <notify.h>
#import <NSTask/NSTask.h>
#import <addButtonManager/addButtonManager.h>
#import <addLabelManager/addLabelManager.h>
#import <addAlertManager/addAlertManager.h>
#import <LocationHandler/LocationHandler.h>

@interface XXRootViewController : UIViewController <WKNavigationDelegate, WKUIDelegate, UNUserNotificationCenterDelegate>
@property (nonatomic, retain) UILabel *words1;
@property (nonatomic, retain) UILabel *words2;
@property (nonatomic, retain) UILabel *words3;
//@property (nonatomic, retain) CLLocationManager *locationManager;
@end
