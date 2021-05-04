#import "XXRootViewController.h"
#import "HelpViewController.h"
#import "SettingViewController.h"
#import <libpowercontroller/powercontroller.h>
#import <kaddAvPlayer.h>
#import <kActivityIndicator.h>
#import <kaddprogressView.h>
#import <kaddNotificationCenter.h>
#import "LEDSwitch.h"
#import "MobileGestalt.h"
#import <SCLAlertView/SCLAlertView.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#define PCAImagePath @"/Applications/PowerControllerApp.app/AppIcon29x29@2x.png"

NSString *avUrl;
NSString *pcAppmessage = @"Respring\n uicache\n セーフモード\n reboot\n Cydiaインストール";
NSString *pcapptitle = @"🥺PowerControllerApp🥺";
SEL pcappAction = @selector(tapbt);
NSString *message = @"uicache実行中";
float mainInt;
UIColor *greenColor;
UIColor *redColor;
double latitude;
double longitude;
SEL tapButton = @selector(tappedButton:);
NSString *uiViewButtonTitle = @"テストボタン";
SEL uiViewButtonAction = @selector(uiViewButtonAction);
UIView *cashapeView;
UIDevice *dev = [UIDevice currentDevice];
CGPoint lastMenuLocation;

////////////////////////////////////////////////////////////////////////////////////
NSString *ComputerName() {
	NSString *ComputerName = nil;
	CFStringRef value = (CFStringRef) MGCopyAnswer(kMGComputerName);
	if (value != nil) {
		ComputerName = [NSString 
			stringWithFormat:@"%@", value];
		CFRelease(value);
	}
	return ComputerName;
}

NSString *HardwarePlatform() {
	NSString *HardwarePlatform = nil;
	CFStringRef value = (CFStringRef) MGCopyAnswer(kMGHardwarePlatform);
	if (value != nil) {
		HardwarePlatform = [NSString 
			stringWithFormat:@"%@", value];
		CFRelease(value);
	}
	return HardwarePlatform;
}

NSString *HWModel() {
	NSString *HWModel = nil;
	CFStringRef value = (CFStringRef) MGCopyAnswer(kMGHWModel);
	if (value != nil) {
		HWModel = [NSString stringWithFormat:@"%@", value];
		CFRelease(value);
	}
	return HWModel;
}

NSString *FirmwareVersion() {
	NSString *FirmwareVersion = nil;
	CFStringRef value = (CFStringRef) MGCopyAnswer(kMGFirmwareVersion);
	if (value != nil) {
		FirmwareVersion = [NSString 
			stringWithFormat:@"%@", value];
		CFRelease(value);
	}
	return FirmwareVersion;
}

NSString *ChipID() {
	NSString *ChipID = nil;
	CFStringRef value = (CFStringRef) MGCopyAnswer(kMGChipID);
	if (value != nil) {
		ChipID = [NSString 
			stringWithFormat:@"%@", value];
		CFRelease(value);
	}
	return ChipID;
}

NSString *CPUArchitecture() {
	NSString *CPUArchitecture = nil;
	CFStringRef value = (CFStringRef) MGCopyAnswer(kMGCPUArchitecture);
	if (value != nil) {
		CPUArchitecture = [NSString 
			stringWithFormat:@"%@", value];
		CFRelease(value);
	}
	return CPUArchitecture;
}

NSString *UserAssignedDeviceName() {
	NSString *UserAssignedDeviceName = nil;
	CFStringRef value = (CFStringRef) MGCopyAnswer(kMGUserAssignedDeviceName);
	if (value != nil) {
		UserAssignedDeviceName = [NSString 
			stringWithFormat:@"%@", value];
		CFRelease(value);
	}
	return UserAssignedDeviceName;
}

NSString *BatteryCurrentCapacity() {
	NSString *BatteryCurrentCapacity = nil;
	CFStringRef value = (CFStringRef) MGCopyAnswer(kMGBatteryCurrentCapacity);
	if (value != nil) {
		BatteryCurrentCapacity = [NSString 
			stringWithFormat:@"%@", value];
		CFRelease(value);
	}
	return BatteryCurrentCapacity;
}

NSString *ModelNumber() {
	NSString *ModelNumber = nil;
	CFStringRef value = (CFStringRef) MGCopyAnswer(kMGModelNumber);
	if (value != nil) {
		ModelNumber = [NSString 
			stringWithFormat:@"%@", value];
		CFRelease(value);
	}
	return ModelNumber;
}

NSString *UDID() {
	NSString *UDID = nil;
	CFStringRef value = (CFStringRef) MGCopyAnswer(kMGUniqueDeviceID);
	if (value != nil) {
		UDID = [NSString stringWithFormat:@"%@", value];
		CFRelease(value);
	}
	return UDID;
}

NSString *isDeviceInfoStr = [NSString 
	stringWithFormat:@"\
User Assigned Device Name : %@\r\n \
Computer Name : %@\r\n \
System Version : iOS %@\r\n \
Model Number : %@\r\n \
CPU Model : %@\r\n \
Firmware Version : %@\r\n \
Hardware Platform : %@\r\n \
CPU Architecture : %@\r\n \
Chip ID : %@\r\n \
Battery Current Capacity : %@%%\r\n \
UDID : %@\r\n ", \

		UserAssignedDeviceName(), 
		ComputerName(), 
		dev.systemVersion, 
		ModelNumber(), 
		HWModel(), 
		FirmwareVersion(), 
		HardwarePlatform(), 
		CPUArchitecture(), 
		ChipID(), 
		BatteryCurrentCapacity(), 
		UDID()];
////////////////////////////////////////////////////////////////////////////////////

@implementation XXRootViewController

- (void)viewDidLoad { // loadViewの次に呼ばれ、一度だけ生成される
	[super viewDidLoad];
	[LocationHandler.sharedInstance setDelegate:self];
	[LocationHandler.sharedInstance startUpdating];
	[self initUIBarButtonItem];

	/*[addButtonManager.sharedInstance 
		addButton:self.pcappButton 
		title:pcapptitle 
		delegate:self 
		action:pcappAction 
		toItem:self.view 
		multiplierX:1.0f 
		constantX:0.0f 
		multiplierY:0.4f 
		constantY:0.0f];*/

	/*[addButtonManager.sharedInstance 
		addButton:self.uiViewButton 
		title:uiViewButtonTitle 
		delegate:self 
		action:uiViewButtonAction 
		toItem:self.view 
		multiplierX:1.0f 
		constantX:0.0f 
		multiplierY:1.7f 
		constantY:0.0f];*/

	//加速度センサー
	//[self initAccelerometer];
	//[self setupAccelerometer];

	//点滅view
	//[self initSampleView];
	//[self fadeOut:self.sampleView];
	//[self fadeOut:self.sampleView2];

	//UISwitch
	//LEDSwitch *ledSwitch = [LEDSwitch new];
	//[ledSwitch initSwitch:self.view];

	//[self initButton];

	//UIBarButtonItem
	//[self initToolbarItem];

	//UIStackView
	//[self initStackView];

}

- (void)loadView { // 1番初めに呼ばれる
	self.view = [[UIView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];

	//AVPlayerItem
	[self initAddAvPlayer];

	//現在時刻
	//[self initCurrentTimeLabel];

	//[self.view layoutIfNeeded];

}

- (void)tapbt {

	UIAlertController *alert = [UIAlertController 
		alertControllerWithTitle:pcapptitle 
		message:pcAppmessage 
		preferredStyle:UIAlertControllerStyleActionSheet];

	//Respring////////////////////////////////////////////////////////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"Respring" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(krespring);
		}]];

	//カウントダウンRespring///////////////////////////////////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"カウントダウンRespring" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {


	self.countdownTimer = [NSTimer 
		scheduledTimerWithTimeInterval:0.01f 
		target:self 
		selector:@selector(countDown) 
		userInfo:nil 
		repeats:YES];

	mainInt = 100.00f;

	self.timeralertController = [UIAlertController 
		alertControllerWithTitle:nil 
		message:[self countDownString] 
		preferredStyle:UIAlertControllerStyleAlert];

	[self.timeralertController addAction:[UIAlertAction 
		actionWithTitle:@"Respring"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(krespring);
		}]];

	//キャンセル////////////////////////////////////////////////////////////
	[self.timeralertController addAction:[UIAlertAction 
		actionWithTitle:@"キャンセル"
		style:UIAlertActionStyleCancel 
		handler:^(UIAlertAction *action) {
		[self.countdownTimer invalidate];
		}]];

	[self presentViewController:self.timeralertController 
		animated:YES 
		completion:nil];

		}]];

	//uicache(通知あり)////////////////////////////////////////////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"uicache" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(kuicache);
		addActivityIndicator(self.IndicatorView, 
			message, 18.0, self);
		notify_post("com.mikiyan1978.alertapplibbulletinuicachenoti");

		}]];

	//セーフモード/////////////////////////////////////////////////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"Substrate Safe Mode" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(ksafemode);
		}]];

	//reboot
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"reboot" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(kreboot);
		}]];

	//ldrestart
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"ldrestart" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(klibpowercontrollerldrestart);
		}]];

	//launchctl reboot userspace
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"userspace reboot" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post("com.mikiyan1978.rebootUserspace");
		}]];

	//libnotifications/通知テスト////////////////////////////////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"libnotifications通知" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post("com.mikiyan1978.alertapplibnotificationsuicachenoti");
		}]];

	//libbulletin/通知テスト//////////////////////////////////////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"libbulletin通知" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		if (@available(iOS 14, *)) {
		notify_post("com.mikiyan1978.alertapplibbulletin14upnoti");
		} else {
		notify_post("com.mikiyan1978.alertapplibbulletin14downnoti");
		}
		}]];

	//UNUserNotificationCenter/通知テスト/////////////////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"UNUserNotificationCenter通知" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		[self UNUserNotificationCenterHandler];
		}]];

	//schedule/通知テスト////////////////////////////////////////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"スケジューリング通知" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		addscheduleNotificationCenter(23, 1);

		}]];

	//通知キャンセル//////////////////////////////////////////////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"通知キャンセル" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		[[UNUserNotificationCenter currentNotificationCenter] 
			removeAllPendingNotificationRequests];

		}]];

	//CFNotificationCenterPostNotification(sbreload)///////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"CFNPostNotification(sbreload)" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		notify_post("com.mikiyan1978.alertappsbreload");

		}]];

	//addAlertManager////////////////////////////////////////////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"addAlertManager" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		[addAlertManager.sharedInstance 
			addAlert:self.addAlert 
			preferredStyle:UIAlertControllerStyleAlert 
			alertControllerWithTitle:@"addAlertManagerテスト" 
			alertMessage:@"addAlertManager" 
			actionWithTitle:@"Respring" 
			target:self 
			actionHandler:^(){
				//notify_post(krespring);
			}];

		}]];

	//プログレスバー///////////////////////////////////////////////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"プログレスバー"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		addprogressView(self.progressView, 
			greenColor, 
			redColor, 
			self, self.view, 
			15, 2.0, 5.0, 2, 2);

		//[self.progressView removeFromSuperview];

		}]];

	//Device Information//////////////////////////////////////////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"Device Information"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		UIAlertController *alert = [UIAlertController 
			alertControllerWithTitle:@"Device Information\r\n" 
			message:isDeviceInfoStr 
			preferredStyle:UIAlertControllerStyleAlert];

		[alert addAction:[UIAlertAction 
			actionWithTitle:@"キャンセル" 
			style:UIAlertActionStyleCancel 
			handler:nil]];

		[self presentViewController:alert 
			animated:YES 
			completion:nil];

		}]];

	//キャンセル////////////////////////////////////////////////////////////
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"キャンセル" 
		style:UIAlertActionStyleCancel 
		handler:nil]];

	[self presentViewController:alert 
		animated:YES 
		completion:nil];
}

#pragma mark - player
- (void)initAddAvPlayer {
	addAvPlayer(avUrl, 0.1, self);

	[NSNotificationCenter.defaultCenter 
		addObserver:self 
		selector:@selector(playerAdjustFrame) 
		name:UIApplicationDidFinishLaunchingNotification 
		object:nil];

	[NSNotificationCenter.defaultCenter 
		addObserver:self 
		selector:@selector(playerAdjustFrame) 
		name:UIDeviceOrientationDidChangeNotification 
		object:nil];

	player.actionAtItemEnd = AVPlayerActionAtItemEndNone; 

	[NSNotificationCenter.defaultCenter 
		addObserver:self 
		selector:@selector(playerItemDidReachEnd:) 
		name:AVPlayerItemDidPlayToEndTimeNotification 
		object:[player currentItem]];
}

- (void)playerAdjustFrame {
	[playerLayer setFrame:[[[self view] layer] bounds]];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
	[player seekToTime:kCMTimeZero];
	[player setActionAtItemEnd:AVPlayerActionAtItemEndNone];
	[player play];
}

#pragma mark - CurrentTimeLabel
- (void)initCurrentTimeLabel {
	self.tlabel = [UILabel new];
	[self.tlabel setTranslatesAutoresizingMaskIntoConstraints:NO];
	self.tlabel.lineBreakMode = NSLineBreakByWordWrapping;
	self.tlabel.numberOfLines = 0;
	self.tlabel.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:self.tlabel];

	//X軸(横方向)
	NSLayoutConstraint *labelX = [NSLayoutConstraint 
		constraintWithItem:self.tlabel 
		attribute:NSLayoutAttributeCenterX 
		relatedBy:NSLayoutRelationGreaterThanOrEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeCenterX 
		multiplier:1.0f 
		constant:0.0f];

	//Y軸(縦方向)
	NSLayoutConstraint *labelY = [NSLayoutConstraint 
		constraintWithItem:self.tlabel 
		attribute:NSLayoutAttributeCenterY 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeCenterY 
		multiplier:0.25f 
		constant:0.0f];

	[self.view addConstraints:@[labelX, labelY]];

	[[NSTimer 
		scheduledTimerWithTimeInterval:0.1f 
		target:self 
		selector:@selector(updateClock) 
		userInfo:nil 
		repeats:YES] fire];
}

- (void)updateClock {
	NSDate *date = [NSDate date];
	NSDateFormatter *form = [NSDateFormatter new];
	[form setLocale:[[NSLocale alloc] 
		initWithLocaleIdentifier:@"ja_JP"]];
	[form setDateFormat:@"yyyy/MM/dd HH:mm:ss (E)"];
	NSString *datetime = [form stringFromDate:date];
	self.tlabel.text = datetime;
	self.tlabel.textColor = [self randomColor];
}

#pragma mark - countDown
- (NSString *)countDownString {
	return [NSString stringWithFormat:@"%.2f 秒後にRespringします", mainInt];
}

- (void)countDown {
	mainInt -= 0.01f;

	if (mainInt < 0) {
		[self.countdownTimer invalidate];
		[self.timeralertController 
			dismissViewControllerAnimated:YES 
			completion:^{
			notify_post(krespring);
			}];
	} else {
		self.timeralertController.message = [self countDownString];
	}
}

- (void)UNUserNotificationCenterHandler {

	UNMutableNotificationContent *localNotification = [UNMutableNotificationContent new];

		localNotification.title = [NSString localizedUserNotificationStringForKey:@"UNUserNotificationCenter" arguments:nil];

		localNotification.body = [NSString localizedUserNotificationStringForKey:@"UNUserNotificationCenter" arguments:nil];

		localNotification.sound = [UNNotificationSound defaultSound];

		UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger 
			triggerWithTimeInterval:0.1 
			repeats:NO];

		UNNotificationRequest *request = [UNNotificationRequest 
			requestWithIdentifier:@"Time for a run!" 
			content:localNotification 
			trigger:trigger];
    
		UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

		center.delegate = self;

		[center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        //NSLog(@"Notification created");
    }];

}

//フォアグラウンドでも通知を受信できるようにする
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler { 

	completionHandler(
		UNAuthorizationOptionSound | 
		UNAuthorizationOptionAlert | 
		UNAuthorizationOptionBadge);

	//NSLog(@"APPDELEGATE: willPresentNotification %@", notification.request.content.userInfo);

}

//受信した通知をタップした時の処理
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {

	completionHandler();
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self.view];

	UIImageView *imgView = [[UIImageView alloc] 
		initWithFrame:CGRectMake(0, 0, 40, 40)];

	imgView.image = [UIImage 
		imageNamed:@"AppIcon29x29@2x.png"];

	imgView.clipsToBounds = YES;
	imgView.layer.borderColor = [[self randomColor] CGColor];
	imgView.layer.borderWidth = 2.5;
	imgView.layer.cornerRadius = 15.0f;
	//imgView.layer.shadowOffset = CGSizeMake(10, 10); // 影の向き CGSizeMake(左右, 上下) 右下に影
	//imgView.layer.shadowRadius = 30;   // 影の半径
	//imgView.layer.shadowOpacity = 0.8; // 影の透明度

	imgView.center = point;
	[self.view addSubview:imgView];

	[UIView animateWithDuration:0.8 
		animations:^{
		imgView.transform = CGAffineTransformMakeScale(0.01, 0.01);
		imgView.alpha = 0;
	} completion:^(BOOL finished) {
		[imgView removeFromSuperview];
	}];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self.view];

	UIImageView *imgView = [[UIImageView alloc] 
		initWithFrame:CGRectMake(0, 0, 40, 40)];

	imgView.image = [UIImage 
		imageNamed:@"AppIcon29x29@2x.png"];

	imgView.clipsToBounds = YES;
	imgView.layer.borderColor = [[self randomColor] CGColor];
	imgView.layer.borderWidth = 2.5f;
	imgView.layer.cornerRadius = 15.0f;

	imgView.transform = CGAffineTransformMakeScale(0.5, 0.5);

	imgView.center = point;
	[self.view addSubview:imgView];

	[UIView animateWithDuration:0.3 
		animations:^{
		imgView.transform = CGAffineTransformMakeScale(5, 5);
		//imgView.transform = CGAffineTransformIdentity;
		imgView.alpha = 0;
	} completion:^(BOOL finished) {
		[imgView removeFromSuperview];
	}];
}

//加速度センサー
- (void)initAccelerometer {
	self.xLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.yLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.zLabel = [[UILabel alloc] initWithFrame:CGRectZero];

	[self.xLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.yLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.zLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

	self.xLabel.lineBreakMode = NSLineBreakByWordWrapping;
	self.xLabel.numberOfLines = 0;
	self.xLabel.textAlignment = NSTextAlignmentCenter;

	self.yLabel.lineBreakMode = NSLineBreakByWordWrapping;
	self.yLabel.numberOfLines = 0;
	self.yLabel.textAlignment = NSTextAlignmentCenter;

	self.zLabel.lineBreakMode = NSLineBreakByWordWrapping;
	self.zLabel.numberOfLines = 0;
	self.zLabel.textAlignment = NSTextAlignmentCenter;

	//self.xLabel.textColor = [UIColor whiteColor];
	//self.yLabel.textColor = [UIColor whiteColor];
	//self.zLabel.textColor = [UIColor whiteColor];

	[self.view addSubview:self.xLabel];
	[self.view addSubview:self.yLabel];
	[self.view addSubview:self.zLabel];

	NSLayoutConstraint* xtopAnchor = [self.xLabel.topAnchor 
		constraintEqualToAnchor:self.view.topAnchor 
		constant:200];
	NSLayoutConstraint* xleftAnchor = [self.xLabel.leftAnchor 
		constraintEqualToAnchor:self.view.leftAnchor 
		constant:0];
	NSLayoutConstraint* xrightAnchor = [self.xLabel.rightAnchor 
		constraintEqualToAnchor:self.view.rightAnchor 
		constant:0];
	NSLayoutConstraint* xheightAnchor = [self.xLabel.heightAnchor 
		constraintEqualToConstant:30];

	NSLayoutConstraint* ytopAnchor = [self.yLabel.topAnchor 
		constraintEqualToAnchor:self.view.topAnchor 
		constant:220];
	NSLayoutConstraint* yleftAnchor = [self.yLabel.leftAnchor 
		constraintEqualToAnchor:self.view.leftAnchor 
		constant:0];
	NSLayoutConstraint* yrightAnchor = [self.yLabel.rightAnchor 
		constraintEqualToAnchor:self.view.rightAnchor 
		constant:0];
	NSLayoutConstraint* yheightAnchor = [self.yLabel.heightAnchor 
		constraintEqualToConstant:30];

	NSLayoutConstraint* ztopAnchor = [self.zLabel.topAnchor 
		constraintEqualToAnchor:self.view.topAnchor 
		constant:240];
	NSLayoutConstraint* zleftAnchor = [self.zLabel.leftAnchor 
		constraintEqualToAnchor:self.view.leftAnchor 
		constant:0];
	NSLayoutConstraint* zrightAnchor = [self.zLabel.rightAnchor 
		constraintEqualToAnchor:self.view.rightAnchor 
		constant:0];
	NSLayoutConstraint* zheightAnchor = [self.zLabel.heightAnchor 
		constraintEqualToConstant:30];

	[self.view addConstraint:xtopAnchor];
	[self.view addConstraint:xleftAnchor];
	[self.view addConstraint:xrightAnchor];
	[self.view addConstraint:xheightAnchor];

	[self.view addConstraint:ytopAnchor];
	[self.view addConstraint:yleftAnchor];
	[self.view addConstraint:yrightAnchor];
	[self.view addConstraint:yheightAnchor];

	[self.view addConstraint:ztopAnchor];
	[self.view addConstraint:zleftAnchor];
	[self.view addConstraint:zrightAnchor];
	[self.view addConstraint:zheightAnchor];

	[self setupAccelerometer];
}

- (void)setupAccelerometer {
	self.motionManager = [CMMotionManager new];

	if (self.motionManager.accelerometerAvailable) {

	self.motionManager.accelerometerUpdateInterval = 0.01f;

	// ハンドラを設定
	CMAccelerometerHandler handler = ^(CMAccelerometerData *data, NSError *error) {
	double xac = data.acceleration.x;
	double yac = data.acceleration.y;
	double zac = data.acceleration.z;

	self.xLabel.text = [NSString 
		stringWithFormat:@"X軸 = %f", xac];
	self.yLabel.text = [NSString 
		stringWithFormat:@"Y軸 = %f", yac];
	self.zLabel.text = [NSString 
		stringWithFormat:@"Z軸 = %f", zac];

	self.xLabel.textColor = [self randomColor];
	self.yLabel.textColor = [self randomColor];
	self.zLabel.textColor = [self randomColor];
	};

	// 加速度の取得開始
	[self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] 
		withHandler:handler];
	}
}

//緯度/経度
- (void)didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

	//CLLocation *newLocation = [locations lastObject];

	CLLocation *currentLocation = newLocation;
	latitude = currentLocation.coordinate.latitude; //緯度
	longitude = currentLocation.coordinate.longitude; //経度

	self.latitudeLabel.text = [NSString 
		stringWithFormat:@"緯度 = %+.6f", latitude];
	self.longitudeLabel.text = [NSString 
		stringWithFormat:@"経度 = %+.6f", longitude];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {

	UIAlertController *alert = [UIAlertController 
		alertControllerWithTitle:@"位置情報エラー" 
		message:@"位置情報取得できてなーい！" 
		preferredStyle:UIAlertControllerStyleAlert];

	[alert addAction:[UIAlertAction 
		actionWithTitle:@"キャンセル" 
		style:UIAlertActionStyleCancel 
		handler:nil]];

	[self presentViewController:alert 
		animated:YES 
		completion:nil];
}

//点滅view
- (void)initSampleView {
/////////////////////////////////////////////////////////////////////////
	//NSLayoutAttributeTop
	//NSLayoutAttributeLeft
	//NSLayoutAttributeRight
	//NSLayoutAttributeBottom
	//NSLayoutAttributeLeading
	//NSLayoutAttributeTrailing
	//NSLayoutAttributeWidth
	//NSLayoutAttributeHeight
	//NSLayoutAttributeCenterX
	//NSLayoutAttributeCenterY
/////////////////////////////////////////////////////////////////////////
	self.sampleView = [UIView new];
	self.sampleView2 = [UIView new];

	self.sampleView.translatesAutoresizingMaskIntoConstraints = NO;
	self.sampleView2.translatesAutoresizingMaskIntoConstraints = NO;

	//self.sampleView.backgroundColor = [self randomColor];
	self.sampleView.layer.cornerRadius = 25.5;
	[self.view addSubview:self.sampleView];

	self.sampleView2.backgroundColor = [self randomColor];
	self.sampleView2.layer.cornerRadius = 25.5;
	[self.view addSubview:self.sampleView2];

	//上 sampleView
	[NSLayoutConstraint 
		constraintWithItem:self.sampleView 
		attribute:NSLayoutAttributeTop 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeTop 
		multiplier:1.0 
		constant:280.0].active = YES;

	//左 sampleView
	[NSLayoutConstraint 
		constraintWithItem:self.sampleView 
		attribute:NSLayoutAttributeLeading 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeLeading 
		multiplier:1.0 
		constant:30.0].active = YES;

	//下 sampleView
	[NSLayoutConstraint 
		constraintWithItem:self.sampleView 
		attribute:NSLayoutAttributeHeight 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeHeight 
		multiplier:0.2 
		constant:0.0].active = YES;

	//横幅 sampleView
	[NSLayoutConstraint 
		constraintWithItem:self.sampleView 
		attribute:NSLayoutAttributeWidth 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeWidth 
		multiplier:0.4 
		constant:0.0].active = YES;


	//上 sampleView2
	[NSLayoutConstraint 
		constraintWithItem:self.sampleView2 
		attribute:NSLayoutAttributeTop 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeTop 
		multiplier:1.0 
		constant:280.0].active = YES;

	//右 sampleView2
	[NSLayoutConstraint 
		constraintWithItem:self.sampleView2 
		attribute:NSLayoutAttributeTrailing 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeTrailing 
		multiplier:1.0 
		constant:-30.0].active = YES;

	//下 sampleView2
	[NSLayoutConstraint 
		constraintWithItem:self.sampleView2 
		attribute:NSLayoutAttributeHeight 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeHeight 
		multiplier:0.2 
		constant:0.0].active = YES;

	//横幅 sampleView2
	[NSLayoutConstraint 
		constraintWithItem:self.sampleView2 
		attribute:NSLayoutAttributeWidth 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeWidth 
		multiplier:0.4 
		constant:0.0].active = YES;
}

//UIStackView
- (void)initStackView {
	UIView *mainView = [[UIView alloc] 
		initWithFrame:CGRectMake(
			W / 2 - 150, H / 2 - 150, 
			300, 100)];

	mainView.backgroundColor = [self randomColor];
	mainView.layer.cornerRadius = 25.5;
	[self.view addSubview:mainView];

	//view 1
	UIView *view1 = [UIView new];
	view1.backgroundColor = [self randomColor];
	[view1.heightAnchor 
		constraintEqualToConstant:15].active = true;
	[view1.widthAnchor 
		constraintEqualToConstant:280].active = true;

	//View 2
	UIView *view2 = [UIView new];
	view2.backgroundColor = [self randomColor];
	[view2.heightAnchor 
		constraintEqualToConstant:15].active = true;
	[view2.widthAnchor 
		constraintEqualToConstant:280].active = true;

	//View 3
	UIView *view3 = [UIView new];
	view3.backgroundColor = [self randomColor];
	[view3.heightAnchor 
		constraintEqualToConstant:15].active = true;
	[view3.widthAnchor 
		constraintEqualToConstant:280].active = true;

	//Stack View
	UIStackView *stackView = [UIStackView new];
	stackView.axis = UILayoutConstraintAxisVertical;
	stackView.distribution = UIStackViewDistributionEqualSpacing;
	stackView.alignment = UIStackViewAlignmentCenter;
	stackView.spacing = 15;
	[stackView addArrangedSubview:view1];
	[stackView addArrangedSubview:view2];
	[stackView addArrangedSubview:view3];
	stackView.translatesAutoresizingMaskIntoConstraints = false;
	[mainView addSubview:stackView];

	//Layout for Stack View
	[stackView.centerXAnchor constraintEqualToAnchor:mainView.centerXAnchor].active = true;
	[stackView.centerYAnchor constraintEqualToAnchor:mainView.centerYAnchor].active = true;
}

- (void)fadeOut:(UIView *)target {
	[UIView animateWithDuration:0.1f 
		delay:0.0 
		options:UIViewAnimationOptionCurveEaseIn 
		animations:^{
			self.sampleView.backgroundColor = [self randomColor];
			target.alpha = 0.0;
	} completion:^(BOOL finished) {
		[self fadeIn:target];
	}];
}

- (void)fadeIn:(UIView *)target {
	[UIView animateWithDuration:0.1f 
		delay:0.0 
		options:UIViewAnimationOptionCurveEaseIn 
		animations:^{
			self.sampleView.backgroundColor = [self randomColor];
			target.alpha = 1.0;
	} completion:^(BOOL finished) {
		[self fadeOut:target];
	}];
}
/*
- (void)initButton {

	[addButtonManager.sharedInstance 
		addButton:btn 
		title:@"🥺すくろーるびゅ🥺" 
		delegate:self 
		action:tapButton 
		toItem:self.view 
		multiplierX:1.0f 
		constantX:0.0f 
		multiplierY:0.1f 
		constantY:0.0f];
}
*/

- (void)initToolbarItem {
	self.navigationController.toolbar.tintColor = [UIColor redColor];

	UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
    initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

	UIBarButtonItem *uiberButton1 = [[UIBarButtonItem alloc] 
		initWithTitle:@"Power Controller" 
		style:UIBarButtonItemStylePlain 
		target:self 
		action:@selector(tapedButton1)];

	UIBarButtonItem *uiberButton2 = [[UIBarButtonItem alloc] 
		initWithTitle:@"ボタン2" 
		style:UIBarButtonItemStylePlain 
		target:self 
		action:@selector(tapedButton2)];

	UIBarButtonItem *uiberButton3 = [[UIBarButtonItem alloc] 
		initWithTitle:@"ボタン3" 
		style:UIBarButtonItemStylePlain 
		target:self 
		action:@selector(tapedButton3)];

	UIBarButtonItem *uiberButton4 = [[UIBarButtonItem alloc] 
		initWithTitle:@"設定" 
		style:UIBarButtonItemStylePlain 
		target:self 
		action:@selector(tapedButton4)];

	NSArray *items = [NSArray 
		arrayWithObjects:
		spacer, 
		uiberButton1, 
		spacer, 
		uiberButton2, 
		spacer, 
		uiberButton3, 
		spacer, 
		uiberButton4, 
		spacer, nil];

	self.toolbarItems = items;
}

- (void)tapedButton1 {
	
}

- (void)tapedButton2 {
	
}

- (void)tapedButton3 {
	
}

- (void)tapedButton4 {
	SettingViewController *SVC = [SettingViewController new];
	[self.navigationController pushViewController:SVC 
		animated:YES];
}

- (void)tappedButton:(UIButton*)button {

	[addAlertManager.sharedInstance 
		addAlert:self.scrollViewaddAlert 
		preferredStyle:UIAlertControllerStyleAlert 
		alertControllerWithTitle:@"イベントを発生させますか？" 
		alertMessage:nil 
		actionWithTitle:@"はい" 
		target:self 
		actionHandler:^(){
		[self event];
		}];

	[self.imageView removeFromSuperview];
	[self.scrollView removeFromSuperview];
}

- (void)event {

	CGRect rect = CGRectMake(
		0, 
		self.view.frame.size.height / 5, 
		self.view.frame.size.width, 
		self.view.frame.size.height * 4 / 5);

	self.scrollView = [[UIScrollView alloc] initWithFrame:rect];

	UIImage *image = [UIImage 
		imageNamed:@"AppIcon29x29@2x.png"];
    
	rect.origin.y = 0;
	self.imageView = [[UIImageView alloc] initWithFrame:rect];
	self.imageView.contentMode = UIViewContentModeScaleAspectFit;
	self.imageView.image = image;
	self.scrollView.backgroundColor = [UIColor clearColor];

	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] 
		initWithTarget:self 
		action:@selector(doubleTap:)];

	tapGestureRecognizer.numberOfTapsRequired = 2;
	[self.scrollView addGestureRecognizer: tapGestureRecognizer];
	[self.scrollView addSubview:self.imageView];
	self.scrollView.contentSize = self.imageView.bounds.size;
	self.scrollView.bounces = NO;
	[self.view addSubview:self.scrollView];

	//拡大/縮小対応
	self.scrollView.delegate = (id)self;
	self.scrollView.minimumZoomScale = 1.0;
	self.scrollView.maximumZoomScale = 1000.0;
}

//拡大/縮小対応
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

	for (id subview in self.scrollView.subviews) {
	if ([subview isKindOfClass:[UIImageView class]]) {
		return subview;
		}
	}
	return nil;
}

// ダブルタップで呼ばれるアクションメソッド
- (void)doubleTap:(UITapGestureRecognizer *)recognizer {

	if (recognizer.state == UIGestureRecognizerStateEnded) {
	// Scroll Viewの拡大率が等倍なら
	if (self.scrollView.zoomScale < 1.5) {
		CGPoint tappedPoint = [recognizer 
			locationInView:self.imageView];

		// タップ位置を中心にして拡大するよう、タップ位置を取得
		[self.scrollView zoomToRect:CGRectMake(
			tappedPoint.x, 
			tappedPoint.y, 
			160.0, 
			160.0) 
			animated: YES];
		// 拡大
	} else { // 倍だったら
		[self.scrollView zoomToRect:CGRectMake(
			0.0, 
			0.0, 
			self.scrollView.frame.size.width, 
			self.scrollView.frame.size.height) 
			animated:YES];
		}
	}
}

- (void)isOn:(UISwitch *)sw {
	AVCaptureDevice *captureDevice = [AVCaptureDevice 
		defaultDeviceWithMediaType:AVMediaTypeVideo];

	if (sw.on == YES) {
		//ライトon
		[captureDevice lockForConfiguration:NULL];
		captureDevice.torchMode = AVCaptureTorchModeOn;
		[captureDevice unlockForConfiguration];

	} else {
		//ライトoff
		[captureDevice lockForConfiguration:NULL];
		captureDevice.torchMode = AVCaptureTorchModeOff;
		[captureDevice unlockForConfiguration];
	}
}

- (UIColor *)randomColor {
	// 0 - 255
	int r = arc4random_uniform(256);
	int g = arc4random_uniform(256);
	int b = arc4random_uniform(256);

	return [UIColor 
		colorWithRed:r / 255.0f 
		green:g / 255.0f 
		blue:b / 255.0f 
		alpha:1.0f];
}

- (void)initUIBarButtonItem {
	self.rightButtonItem = [[UIBarButtonItem alloc] 
		initWithTitle:@"❤️" 
		style:UIBarButtonItemStyleDone 
		target:self 
		action:@selector(shareTapped)];

	self.rightButtonItem1 = [[UIBarButtonItem alloc] 
		initWithImage:[UIImage imageNamed:@"power"] 
		style:UIBarButtonItemStylePlain 
		actionHandler:^{
		[self tapbt];
		}];

	self.leftButtonItem = [[UIBarButtonItem alloc] 
		initWithTitle:@"📱" 
		style:UIBarButtonItemStyleDone 
		target:self 
		action:@selector(leftButtonTapped)];

	self.navigationItem.rightBarButtonItems = @[
		self.rightButtonItem, 
		self.rightButtonItem1];

	//self.navigationItem.rightBarButtonItem = self.rightButtonItem;
	self.navigationItem.leftBarButtonItem = self.leftButtonItem;
}

- (void)leftButtonTapped {
	UIAlertController *alert = [UIAlertController 
		alertControllerWithTitle:@"Device Information\r\n" 
		message:isDeviceInfoStr 
		preferredStyle:UIAlertControllerStyleAlert];

	[alert addAction:[UIAlertAction 
		actionWithTitle:@"キャンセル" 
		style:UIAlertActionStyleCancel 
		handler:nil]];

	[self presentViewController:alert 
		animated:YES 
		completion:nil];
}

//シェア
- (void)shareTapped {
   
    NSString *shareText = @"#Power Controller App X by @mikiyan1978! Download from https://kisaragiray.github.io/repo/ repo in Cydia for free!";
	
    UIImage *image = [UIImage imageWithContentsOfFile:PCAImagePath];
    NSArray * itemsToShare = @[shareText, image];
    
	
	UIActivityViewController *controller = [[UIActivityViewController alloc] 
		initWithActivityItems:itemsToShare 
		applicationActivities:nil];

	[self presentActivityController:controller];
}


- (void)presentActivityController:(UIActivityViewController *)controller {
    
    // for iPad: make the presentation a Popover
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.rightBarButtonItem;

	controller.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *error) {
        // react to the completion
        if (completed) {
            
            // user shared an item
		os_log(OS_LOG_DEFAULT, "アクティビティタイプを使用しました%@", activityType);
            NSLog(@"We used activity type%@", activityType);
            
        } else {
            
            // user cancelled
		os_log(OS_LOG_DEFAULT, "結局、何も共有したくありませんでした。");
            NSLog(@"We didn't want to share anything after all.");
        }
        
        if (error) {
		os_log(OS_LOG_DEFAULT, "エラーが発生した: %@, %@", error.localizedDescription, error.localizedFailureReason);
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
 
}


- (NSString  *)getUUID {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *uuidStr = [defaults stringForKey:@"uuid"];

	if ([uuidStr length] == 0) {
		CFUUIDRef uuid = CFUUIDCreate(NULL);

		uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);

		CFRelease(uuid);
	[defaults setObject:uuidStr forKey:@"uuid"];	
	}

	return [NSString stringWithFormat:@"UUID:%@", uuidStr];
}

- (void)makeHoleAt:(CGPoint)point radius:(CGFloat)radius {
	cashapeView = [[UIView alloc] 
		initWithFrame:self.view.window.bounds];

	cashapeView.backgroundColor = [UIColor redColor];
	cashapeView.alpha = 0.7;

	CAShapeLayer *mask = [[CAShapeLayer alloc] init];
	mask.fillRule = kCAFillRuleEvenOdd;
	mask.fillColor = [UIColor blackColor].CGColor;

	// 画面全体
	UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:self.view.bounds];

	// 穴を空ける
	[maskPath moveToPoint:point];
	[maskPath addArcWithCenter:point 
		radius:radius 
		startAngle:0 
		endAngle:2 * M_PI 
		clockwise:YES];

	mask.path = maskPath.CGPath;
	cashapeView.layer.mask = mask;

	[self.view addSubview:cashapeView];
}

- (void)uiViewButtonAction {
	[self makeHoleAt:CGPointMake(W / 2, H / 2) radius:50];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 
		(int64_t)(5.0 * NSEC_PER_SEC)), 
		dispatch_get_main_queue(), ^{
			[cashapeView removeFromSuperview];
	});
}

////////////////////////////メモリ警告//////////////////////////////////
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}
/////////////////////////////////////////////////////////////////////////

@end



extern NSString *const HBPreferencesDidChangeNotification;


%ctor {
	HBPreferences *prefs = [[HBPreferences alloc] 
		initWithIdentifier:@"com.mikiyan1978.alertapppref"];

	[prefs registerObject:&avUrl 
		default:nil 
		forKey:@"avUrl"];
}

