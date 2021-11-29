#import "UIBarButtonItem+blocks.h"

@interface XXRootViewController : UIViewController <WKNavigationDelegate, WKUIDelegate, UNUserNotificationCenterDelegate, UITabBarControllerDelegate, UIPopoverPresentationControllerDelegate>

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
@property (nonatomic, retain) UIAlertController *accessAlert;
@property (nonatomic, retain) UIAlertController *noAccessAlert;
@property (nonatomic, retain) UIAlertController *addAlert;
@property (nonatomic, retain) UIAlertController *vaddAlert;
@property (nonatomic, retain) UIView *controlView;
@property (nonatomic, retain) UIButton *btn;
@property (nonatomic, retain) UIAlertController *scrollViewaddAlert;
@property (nonatomic, retain) UILabel *words1;
@property (nonatomic, retain) UILabel *words2;
@property (nonatomic, retain) UILabel *words3;
@property (nonatomic, retain) UIBarButtonItem *rightButtonItem;
@property (nonatomic, retain) UIBarButtonItem *rightButtonItem1;
@property (nonatomic, retain) UIBarButtonItem *rightButtonItem2;
@property (nonatomic, retain) UIBarButtonItem *leftButtonItem;
@property (nonatomic, retain) UIBarButtonItem *leftButtonItem1;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UISwitch *sw;
@property (nonatomic, retain) UIButton *uiViewButton;
@property (nonatomic, retain) UIButton *startbtn;

@property (nonatomic, retain) UIButton *backbtn;
@property (nonatomic, retain) UIButton *forwardbtn;

@property (nonatomic, retain) UIImage *startImg;
@property (nonatomic, retain) UIImage *stopImg;

@property (nonatomic, retain) UIImage *backwardImg;
@property (nonatomic, retain) UIImage *forwardImg;

@property (nonatomic, retain) UILabel *playBackTime;
@property (nonatomic, retain) UILabel *playBackTotalTime;

@property (nonatomic, retain) UISlider *progressBar;
@property (nonatomic, retain) UIProgressView *tprogressView;
@property (nonatomic, retain) UIImage *imageForThumb;

@property (nonatomic, retain) UISlider *volumeBar;
@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic, retain) UIStackView *stackView;
@property (nonatomic, retain) UITabBar *tabBar;
+ (BOOL)isLandscapeOrientation;
@end



@interface NSUserDefaults (PowerControllerAppX)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

#define kTimeScale 60.0
#define PCAImagePath @"/Applications/PowerControllerApp.app/box.png"

