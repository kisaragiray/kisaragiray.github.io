#line 1 "XXRootViewController.xm"
#import "XXRootViewController.h"
#import <libpowercontroller/powercontroller.h>
#import <kaddAvPlayer.h>
#import <kActivityIndicator.h>
#import <kaddprogressView.h>
#import <kaddNotificationCenter.h>
#import "LEDSwitch.h"
#import <PureLayout/PureLayout.h>

#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height

UILabel *tlabel;

UIButton *pcappButton;
NSString *pcAppmessage = @"Respring\n uicache\n セーフモード\n reboot\n Cydiaインストール";
NSString *pcapptitle = @"🥺PowerControllerApp🥺";
SEL pcappAction = @selector(tapbt);


NSString *avUrl;
NSString *message = @"uicache実行中";
UIActivityIndicatorView *IndicatorView;

float mainInt;
NSTimer *countdownTimer;
UIAlertController *timeralertController;

WKWebView *wkWebView;
UIProgressView *progressView;
UIColor *greenColor;
UIColor *redColor;

CMMotionManager *motionManager;
UILabel *xLabel;
UILabel *yLabel;
UILabel *zLabel;

UILabel *latitudeLabel;
UILabel *longitudeLabel;
double latitude;
double longitude;

UIAlertController *addAlert;
UIView *sampleView;
UIView *sampleView2;

UIButton *btn;
UIAlertController *scrollViewaddAlert;
UIScrollView *scrollView;
UIImageView *imageView;
SEL tapButton = @selector(tappedButton:);

UISwitch *sw;
UIButton *uiViewButton;
NSString *uiViewButtonTitle = @"UIViewテスト";
SEL uiViewButtonAction = @selector(uiViewButtonAction);

UIScrollView *sampleView2scrollView;

@implementation XXRootViewController

- (void)viewDidLoad { 
	[super viewDidLoad];


	[addButtonManager.sharedInstance 
		addButton:pcappButton 
		title:pcapptitle 
		delegate:self 
		action:pcappAction 
		toItem:self.view 
		multiplierX:1.0f 
		constantX:0.0f 
		multiplierY:0.4f 
		constantY:0.0f];

	[addButtonManager.sharedInstance 
		addButton:uiViewButton 
		title:uiViewButtonTitle 
		delegate:self 
		action:uiViewButtonAction 
		toItem:self.view 
		multiplierX:1.0f 
		constantX:0.0f 
		multiplierY:1.8f 
		constantY:0.0f];

	[LocationHandler.sharedInstance setDelegate:self];
	[LocationHandler.sharedInstance startUpdating];
	[self setupAccelerometer];

	
	
	
	
	
	
	
	
	
	

	
	sampleView = [UIView new];
	sampleView2 = [UIView new];

	sampleView.translatesAutoresizingMaskIntoConstraints = NO;
	sampleView2.translatesAutoresizingMaskIntoConstraints = NO;

	sampleView.backgroundColor = [self randomColor];
	sampleView.layer.cornerRadius = 25.5;
	[self.view addSubview:sampleView];

	sampleView2.backgroundColor = [self randomColor];
	sampleView2.layer.cornerRadius = 25.5;
	[self.view addSubview:sampleView2];

	
	[NSLayoutConstraint 
		constraintWithItem:sampleView 
		attribute:NSLayoutAttributeTop 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeTop 
		multiplier:1.0 
		constant:280.0].active = YES;

	
	[NSLayoutConstraint 
		constraintWithItem:sampleView 
		attribute:NSLayoutAttributeLeading 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeLeading 
		multiplier:1.0 
		constant:30.0].active = YES;

	
	[NSLayoutConstraint 
		constraintWithItem:sampleView 
		attribute:NSLayoutAttributeHeight 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeHeight 
		multiplier:0.2 
		constant:0.0].active = YES;

	
	[NSLayoutConstraint 
		constraintWithItem:sampleView 
		attribute:NSLayoutAttributeWidth 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeWidth 
		multiplier:0.4 
		constant:0.0].active = YES;


	
	[NSLayoutConstraint 
		constraintWithItem:sampleView2 
		attribute:NSLayoutAttributeTop 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeTop 
		multiplier:1.0 
		constant:280.0].active = YES;

	
	[NSLayoutConstraint 
		constraintWithItem:sampleView2 
		attribute:NSLayoutAttributeTrailing 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeTrailing 
		multiplier:1.0 
		constant:-30.0].active = YES;

	
	[NSLayoutConstraint 
		constraintWithItem:sampleView2 
		attribute:NSLayoutAttributeHeight 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeHeight 
		multiplier:0.2 
		constant:0.0].active = YES;

	
	[NSLayoutConstraint 
		constraintWithItem:sampleView2 
		attribute:NSLayoutAttributeWidth 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeWidth 
		multiplier:0.4 
		constant:0.0].active = YES;

	[self fadeOut:sampleView];

	LEDSwitch *sw = [LEDSwitch new];
	[sw initSwitch:self.view];

	[self initButton];

	UIView *mainView = [[UIView alloc] 
		initWithFrame:CGRectMake(
			W / 2 - 150, 
			H / 2 + 70, 
			300, 
			100)];

	mainView.backgroundColor = [UIColor whiteColor];
	mainView.layer.cornerRadius = 25.5;
	[self.view addSubview:mainView];

	
	UIView *view1 = [UIView new];
	view1.backgroundColor = [UIColor blueColor];
	[view1.heightAnchor 
		constraintEqualToConstant:15].active = true;
	[view1.widthAnchor 
		constraintEqualToConstant:280].active = true;

	
	UIView *view2 = [UIView new];
	view2.backgroundColor = [UIColor greenColor];
	[view2.heightAnchor 
		constraintEqualToConstant:15].active = true;
	[view2.widthAnchor 
		constraintEqualToConstant:280].active = true;

	
	UIView *view3 = [UIView new];
	view3.backgroundColor = [UIColor magentaColor];
	[view3.heightAnchor 
		constraintEqualToConstant:15].active = true;
	[view3.widthAnchor 
		constraintEqualToConstant:280].active = true;

	
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

	
	[stackView.centerXAnchor constraintEqualToAnchor:mainView.centerXAnchor].active = true;
	[stackView.centerYAnchor constraintEqualToAnchor:mainView.centerYAnchor].active = true;


}

- (void)loadView { 
	self.view = [[UIView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];


	addAvPlayer(avUrl, 0.1, self);
	
	

	[[NSNotificationCenter defaultCenter] 
		addObserver:self 
		selector:@selector(playerAdjustFrame) 
		name:UIApplicationDidFinishLaunchingNotification 
		object:nil];


	[[NSNotificationCenter defaultCenter] 
		addObserver:self 
		selector:@selector(playerAdjustFrame) 
		name:UIDeviceOrientationDidChangeNotification 
		object:nil];


	player.actionAtItemEnd = AVPlayerActionAtItemEndNone; 

	[[NSNotificationCenter defaultCenter] 
		addObserver:self 
		selector:@selector(playerItemDidReachEnd:) 
		name:AVPlayerItemDidPlayToEndTimeNotification 
		object:[player currentItem]];




	tlabel = [UILabel new];
	[tlabel setTranslatesAutoresizingMaskIntoConstraints:NO];
	tlabel.lineBreakMode = NSLineBreakByWordWrapping;
	tlabel.numberOfLines = 0;
	tlabel.textAlignment = NSTextAlignmentCenter;
	tlabel.textColor = [UIColor magentaColor];
	[self.view addSubview:tlabel];

	
	NSLayoutConstraint *labelX = [NSLayoutConstraint 
		constraintWithItem:tlabel 
		attribute:NSLayoutAttributeCenterX 
		relatedBy:NSLayoutRelationGreaterThanOrEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeCenterX 
		multiplier:1.0f 
		constant:0.0f];

	
	NSLayoutConstraint *labelY = [NSLayoutConstraint 
		constraintWithItem:tlabel 
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





	xLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	yLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	zLabel = [[UILabel alloc] initWithFrame:CGRectZero];

	[xLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
	[yLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
	[zLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

	xLabel.lineBreakMode = NSLineBreakByWordWrapping;
	xLabel.numberOfLines = 0;
	xLabel.textAlignment = NSTextAlignmentCenter;

	yLabel.lineBreakMode = NSLineBreakByWordWrapping;
	yLabel.numberOfLines = 0;
	yLabel.textAlignment = NSTextAlignmentCenter;

	zLabel.lineBreakMode = NSLineBreakByWordWrapping;
	zLabel.numberOfLines = 0;
	zLabel.textAlignment = NSTextAlignmentCenter;

	xLabel.textColor = [UIColor whiteColor];
	yLabel.textColor = [UIColor whiteColor];
	zLabel.textColor = [UIColor whiteColor];

	[self.view addSubview:xLabel];
	[self.view addSubview:yLabel];
	[self.view addSubview:zLabel];

	NSLayoutConstraint* xtopAnchor = [xLabel.topAnchor 
		constraintEqualToAnchor:self.view.topAnchor 
		constant:200];
	NSLayoutConstraint* xleftAnchor = [xLabel.leftAnchor 
		constraintEqualToAnchor:self.view.leftAnchor 
		constant:0];
	NSLayoutConstraint* xrightAnchor = [xLabel.rightAnchor 
		constraintEqualToAnchor:self.view.rightAnchor 
		constant:0];
	NSLayoutConstraint* xheightAnchor = [xLabel.heightAnchor 
		constraintEqualToConstant:30];

	NSLayoutConstraint* ytopAnchor = [yLabel.topAnchor 
		constraintEqualToAnchor:self.view.topAnchor 
		constant:220];
	NSLayoutConstraint* yleftAnchor = [yLabel.leftAnchor 
		constraintEqualToAnchor:self.view.leftAnchor 
		constant:0];
	NSLayoutConstraint* yrightAnchor = [yLabel.rightAnchor 
		constraintEqualToAnchor:self.view.rightAnchor 
		constant:0];
	NSLayoutConstraint* yheightAnchor = [yLabel.heightAnchor 
		constraintEqualToConstant:30];

	NSLayoutConstraint* ztopAnchor = [zLabel.topAnchor 
		constraintEqualToAnchor:self.view.topAnchor 
		constant:240];
	NSLayoutConstraint* zleftAnchor = [zLabel.leftAnchor 
		constraintEqualToAnchor:self.view.leftAnchor 
		constant:0];
	NSLayoutConstraint* zrightAnchor = [zLabel.rightAnchor 
		constraintEqualToAnchor:self.view.rightAnchor 
		constant:0];
	NSLayoutConstraint* zheightAnchor = [zLabel.heightAnchor 
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




	latitudeLabel = [[UILabel alloc] initWithFrame:CGRectZero];

	[latitudeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

	latitudeLabel.lineBreakMode = NSLineBreakByWordWrapping;
	latitudeLabel.numberOfLines = 0;
	latitudeLabel.textAlignment = NSTextAlignmentCenter;
	latitudeLabel.textColor = [UIColor magentaColor];
	
		
	[self.view addSubview:latitudeLabel];

	NSLayoutConstraint* ltopAnchor = [latitudeLabel.topAnchor 
		constraintEqualToAnchor:self.view.topAnchor 
		constant:270];
	NSLayoutConstraint* lleftAnchor = [latitudeLabel.leftAnchor 
		constraintEqualToAnchor:self.view.leftAnchor 
		constant:0];
	NSLayoutConstraint* lrightAnchor = [latitudeLabel.rightAnchor 
		constraintEqualToAnchor:self.view.rightAnchor 
		constant:0];
	NSLayoutConstraint* lheightAnchor = [latitudeLabel.heightAnchor 
		constraintEqualToConstant:30];

	[self.view addConstraint:ltopAnchor];
	[self.view addConstraint:lleftAnchor];
	[self.view addConstraint:lrightAnchor];
	[self.view addConstraint:lheightAnchor];



	longitudeLabel = [[UILabel alloc] 
		initWithFrame:CGRectZero];

	[longitudeLabel 
		setTranslatesAutoresizingMaskIntoConstraints:NO];

	longitudeLabel.lineBreakMode = NSLineBreakByWordWrapping;
	longitudeLabel.numberOfLines = 0;
	longitudeLabel.textAlignment = NSTextAlignmentCenter;
	longitudeLabel.textColor = [UIColor magentaColor];
	
		
	[self.view addSubview:longitudeLabel];

	NSLayoutConstraint* lotopAnchor = [longitudeLabel.topAnchor 
		constraintEqualToAnchor:self.view.topAnchor 
		constant:290];
	NSLayoutConstraint* loleftAnchor = [longitudeLabel.leftAnchor 
		constraintEqualToAnchor:self.view.leftAnchor 
		constant:0];
	NSLayoutConstraint* lorightAnchor = [longitudeLabel.rightAnchor 
		constraintEqualToAnchor:self.view.rightAnchor 
		constant:0];
	NSLayoutConstraint* loheightAnchor = [longitudeLabel.heightAnchor 
		constraintEqualToConstant:30];

	[self.view addConstraint:lotopAnchor];
	[self.view addConstraint:loleftAnchor];
	[self.view addConstraint:lorightAnchor];
	[self.view addConstraint:loheightAnchor];


}

- (void)tapbt {

	UIAlertController *alert = [UIAlertController 
		alertControllerWithTitle:pcapptitle 
		message:pcAppmessage 
		preferredStyle:UIAlertControllerStyleActionSheet];

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"Respring" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(krespring);
		}]];

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"カウントダウンRespring" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {


	countdownTimer = [NSTimer 
		scheduledTimerWithTimeInterval:0.01f 
		target:self 
		selector:@selector(countDown) 
		userInfo:nil 
		repeats:YES];

	mainInt = 100.00f;

	timeralertController = [UIAlertController 
		alertControllerWithTitle:nil 
		message:[self countDownString] 
		preferredStyle:UIAlertControllerStyleAlert];

	[timeralertController addAction:[UIAlertAction 
		actionWithTitle:@"Respring"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(krespring);
		}]];

	
	[timeralertController addAction:[UIAlertAction 
		actionWithTitle:@"キャンセル"
		style:UIAlertActionStyleCancel 
		handler:^(UIAlertAction *action) {
		[countdownTimer invalidate];
		}]];

	[self presentViewController:timeralertController 
		animated:YES 
		completion:nil];

		}]];

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"uicache" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(kuicache);
		addActivityIndicator(IndicatorView, 
			message, 18.0, self);
		notify_post("com.mikiyan1978.alertapplibbulletinuicachenoti");

		}]];

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"Substrate Safe Mode" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(ksafemode);
		}]];

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"ldrestart" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(klibpowercontrollerldrestart);
		}]];

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"libnotifications通知" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post("com.mikiyan1978.alertapplibnotificationsuicachenoti");
		}]];

	
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

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"UNUserNotificationCenter通知" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		[self UNUserNotificationCenterHandler];
		}]];

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"スケジューリング通知" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		addscheduleNotificationCenter(22, 16);

		}]];

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"通知キャンセル" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		[[UNUserNotificationCenter currentNotificationCenter] 
			removeAllPendingNotificationRequests];

		}]];

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"CFNPostNotification(sbreload)" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		notify_post("com.mikiyan1978.alertappsbreload");

		}]];

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"addAlertManager" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		[addAlertManager.sharedInstance 
			addAlert:addAlert 
			preferredStyle:UIAlertControllerStyleAlert 
			alertControllerWithTitle:@"addAlertManagerテスト" 
			alertMessage:@"addAlertManager" 
			actionWithTitle:@"Respring" 
			target:self 
			actionHandler:^(){
				notify_post(krespring);
			}];

		}]];

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"プログレスバー"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		addprogressView(progressView, 
			greenColor, 
			redColor, 
			self, self.view, 
			15, 2.0, 5.0, 2, 2);

		

		}]];

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"WKWebView"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		[self wkWebViewHandler];
		[wkWebView goBack];
		}]];

	
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"キャンセル" 
		style:UIAlertActionStyleCancel 
		handler:nil]];

	[self presentViewController:alert 
		animated:YES 
		completion:nil];
}


- (void)playerAdjustFrame {
	[playerLayer setFrame:[[[self view] layer] bounds]];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
	[player seekToTime:kCMTimeZero];
	[player setActionAtItemEnd:AVPlayerActionAtItemEndNone];
	[player play];
}


- (NSString *)countDownString {
	return [NSString stringWithFormat:@"%.2f 秒後にRespringします", mainInt];
}


- (void)countDown {
	mainInt -= 0.01f;

	if (mainInt < 0) {
		[countdownTimer invalidate];
		[timeralertController 
			dismissViewControllerAnimated:YES 
			completion:^{
			notify_post(krespring);
			}];
	} else {
		timeralertController.message = [self countDownString];
	}
}

- (void)updateClock {
	NSDate *date = [NSDate date];
	NSDateFormatter *form = [NSDateFormatter new];
	[form setLocale:[[NSLocale alloc] 
		initWithLocaleIdentifier:@"ja_JP"]];
	[form setDateFormat:@"yyyy/MM/dd HH:mm:ss (E)"];
	NSString *datetime = [form stringFromDate:date];
	tlabel.text = datetime;
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
        
    }];

}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler { 

	completionHandler(
		UNAuthorizationOptionSound | 
		UNAuthorizationOptionAlert | 
		UNAuthorizationOptionBadge);

	

}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {

	completionHandler();
}

- (void)wkWebViewHandler {
	wkWebView = [WKWebView new];
		wkWebView.navigationDelegate = self;
		wkWebView.UIDelegate = self;
		CGRect rect = self.view.frame;
		wkWebView.frame = rect;
		[self.view addSubview:wkWebView];

		NSURL *url = [NSURL 
			URLWithString:@"https://kisaragiray.github.io/repo/"];
		NSURLRequest *request = [NSURLRequest 
			requestWithURL:url];
		[wkWebView loadRequest:request];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self.view];

	UIImageView *imgView = [[UIImageView alloc] 
		initWithFrame:CGRectMake(0, 0, 40, 40)];

	imgView.image = [UIImage 
		imageNamed:@"AppIcon29x29@2x.png"];

	imgView.clipsToBounds = YES;
	imgView.layer.borderColor = [[UIColor redColor] CGColor];
	imgView.layer.borderWidth = 2.5;
	imgView.layer.cornerRadius = 15.0f;
	
	
	

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
	imgView.layer.borderColor = [[UIColor redColor] CGColor];
	imgView.layer.borderWidth = 2.5f;
	imgView.layer.cornerRadius = 15.0f;

	imgView.transform = CGAffineTransformMakeScale(0.5, 0.5);

	imgView.center = point;
	[self.view addSubview:imgView];

	[UIView animateWithDuration:0.3 
		animations:^{
		imgView.transform = CGAffineTransformMakeScale(5, 5);
		
		imgView.alpha = 0;
	} completion:^(BOOL finished) {
		[imgView removeFromSuperview];
	}];
}


- (void)setupAccelerometer {
	motionManager = [CMMotionManager new];

	if (motionManager.accelerometerAvailable) {

	motionManager.accelerometerUpdateInterval = 0.01f;

	
	CMAccelerometerHandler handler = ^(CMAccelerometerData *data, NSError *error) {
	double xac = data.acceleration.x;
	double yac = data.acceleration.y;
	double zac = data.acceleration.z;

	xLabel.text = [NSString 
		stringWithFormat:@"X軸 = %f", xac];
	yLabel.text = [NSString 
		stringWithFormat:@"Y軸 = %f", yac];
	zLabel.text = [NSString 
		stringWithFormat:@"Z軸 = %f", zac];
	};

	
	[motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] 
		withHandler:handler];
	}
}


- (void)didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

	

	CLLocation *currentLocation = newLocation;
	latitude = currentLocation.coordinate.latitude; 
	longitude = currentLocation.coordinate.longitude; 

	latitudeLabel.text = [NSString 
		stringWithFormat:@"緯度 = %+.6f", latitude];
	longitudeLabel.text = [NSString 
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

- (void)fadeOut:(UIView *)target {
	[UIView animateWithDuration:0.1f 
		delay:0.0 
		options:UIViewAnimationOptionCurveEaseIn 
		animations:^{
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
			target.alpha = 1.0;
	} completion:^(BOOL finished) {
		[self fadeOut:target];
	}];
}

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

- (void)tappedButton:(UIButton*)button {

	[addAlertManager.sharedInstance 
		addAlert:scrollViewaddAlert 
		preferredStyle:UIAlertControllerStyleAlert 
		alertControllerWithTitle:@"イベントを発生させますか？" 
		alertMessage:nil 
		actionWithTitle:@"はい" 
		target:self 
		actionHandler:^(){
		[self event];
		}];

	[imageView removeFromSuperview];
	[scrollView removeFromSuperview];
}

- (void)event {

	CGRect rect = CGRectMake(
		0, 
		self.view.frame.size.height / 5, 
		self.view.frame.size.width, 
		self.view.frame.size.height * 4 / 5);

	scrollView = [[UIScrollView alloc] initWithFrame:rect];

	UIImage *image = [UIImage 
		imageNamed:@"AppIcon29x29@2x.png"];
    
	rect.origin.y = 0;
	imageView = [[UIImageView alloc] initWithFrame:rect];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.image = image;
	scrollView.backgroundColor = [UIColor clearColor];

	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] 
		initWithTarget:self 
		action:@selector(doubleTap:)];

	tapGestureRecognizer.numberOfTapsRequired = 2;
	[scrollView addGestureRecognizer: tapGestureRecognizer];
	[scrollView addSubview:imageView];
	scrollView.contentSize = imageView.bounds.size;
	scrollView.bounces = NO;
	[self.view addSubview:scrollView];

	
	scrollView.delegate = (id)self;
	scrollView.minimumZoomScale = 1.0;
	scrollView.maximumZoomScale = 1000.0;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

	for (id subview in scrollView.subviews) {
	if ([subview isKindOfClass:[UIImageView class]]) {
		return subview;
		}
	}
	return nil;
}


- (void)doubleTap:(UITapGestureRecognizer *)recognizer {

	if (recognizer.state == UIGestureRecognizerStateEnded) {
	
	if (scrollView.zoomScale < 1.5) {
		CGPoint tappedPoint = [recognizer 
			locationInView: imageView];

		
		[scrollView zoomToRect:CGRectMake(
			tappedPoint.x, 
			tappedPoint.y, 
			160.0, 
			160.0) 
			animated: YES];
		
	} else { 
		[scrollView zoomToRect:CGRectMake(
			0.0, 
			0.0, 
			scrollView.frame.size.width, 
			scrollView.frame.size.height) 
			animated:YES];
		}
	}
}

- (void)isOn:(UISwitch *)sw {
	AVCaptureDevice *captureDevice = [AVCaptureDevice 
		defaultDeviceWithMediaType:AVMediaTypeVideo];

	if (sw.on == YES) {
		
		[captureDevice lockForConfiguration:NULL];
		captureDevice.torchMode = AVCaptureTorchModeOn;
		[captureDevice unlockForConfiguration];

	} else {
		
		[captureDevice lockForConfiguration:NULL];
		captureDevice.torchMode = AVCaptureTorchModeOff;
		[captureDevice unlockForConfiguration];
	}
}

- (UIColor *)randomColor {
	
	int r = arc4random_uniform(256);
	int g = arc4random_uniform(256);
	int b = arc4random_uniform(256);

	return [UIColor 
		colorWithRed:r / 255.0f 
		green:g / 255.0f 
		blue:b / 255.0f 
		alpha:1.0f];
}

- (void)uiViewButtonAction {
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];

	UIAlertController *alert;

	[addAlertManager.sharedInstance 
		addAlert:alert 
		preferredStyle:UIAlertControllerStyleAlert 
		alertControllerWithTitle:@"メモリ警告" 
		alertMessage:@"メモリがチャバイです！" 
		actionWithTitle:nil 
		target:self 
		actionHandler:nil];
}


@end



extern NSString *const HBPreferencesDidChangeNotification;


static __attribute__((constructor)) void _logosLocalCtor_df4a085e(int __unused argc, char __unused **argv, char __unused **envp) {
	HBPreferences *prefs = [[HBPreferences alloc] 
		initWithIdentifier:@"com.mikiyan1978.alertapppref"];

	[prefs registerObject:&avUrl 
		default:nil 
		forKey:@"avUrl"];
}

