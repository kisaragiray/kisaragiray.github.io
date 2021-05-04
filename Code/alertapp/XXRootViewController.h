@import Foundation;
//@import UIKit;
@import WebKit;
@import UserNotifications;
@import AVFoundation;
@import AVKit;
@import LocalAuthentication;
@import CoreMotion;
@import CoreLocation;

#import <Cephei/HBPreferences.h>
#import <notify.h>
//#import <NSTask/NSTask.h>
#import <addButtonManager/addButtonManager.h>
#import <addLabelManager/addLabelManager.h>
#import <addAlertManager/addAlertManager.h>
#import <LocationHandler/LocationHandler.h>
#import "UIBarButtonItem+blocks.h"
#import <WHToast/WHToast.h>
#import <os/log.h>

@interface XXRootViewController : UIViewController <WKNavigationDelegate, WKUIDelegate, UNUserNotificationCenterDelegate, UITabBarControllerDelegate>
@property (nonatomic, retain) UILabel *tlabel;
@property (nonatomic, retain) UIButton *pcappButton;
@property (nonatomic, retain) UIActivityIndicatorView *IndicatorView;
@property (nonatomic, retain) NSTimer *countdownTimer;
@property (nonatomic, retain) UIAlertController *timeralertController;
@property (nonatomic, retain) UIProgressView *progressView;
@property (nonatomic, retain) CMMotionManager *motionManager;
@property (nonatomic, retain) UILabel *xLabel;
@property (nonatomic, retain) UILabel *yLabel;
@property (nonatomic, retain) UILabel *zLabel;
@property (nonatomic, retain) UILabel *latitudeLabel;
@property (nonatomic, retain) UILabel *longitudeLabel;
@property (nonatomic, retain) UIAlertController *addAlert;
@property (nonatomic, retain) UIView *sampleView;
@property (nonatomic, retain) UIView *sampleView2;
@property (nonatomic, retain) UIButton *btn;
@property (nonatomic, retain) UIAlertController *scrollViewaddAlert;
@property (nonatomic, retain) UILabel *words1;
@property (nonatomic, retain) UILabel *words2;
@property (nonatomic, retain) UILabel *words3;
@property (nonatomic, retain) UIBarButtonItem *rightButtonItem;
@property (nonatomic, retain) UIBarButtonItem *rightButtonItem1;
@property (nonatomic, retain) UIBarButtonItem *leftButtonItem;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UISwitch *sw;
@property (nonatomic, retain) UIButton *uiViewButton;
@end
