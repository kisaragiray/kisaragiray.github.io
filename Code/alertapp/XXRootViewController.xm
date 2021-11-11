#import "XXRootViewController.h"
#import "HelpViewController.h"
#import "SettingViewController.h"
#import <Cephei/HBPreferences.h>
#import <libpowercontroller/powercontroller.h>
#import <kaddAvPlayer.h>
#import <kActivityIndicator.h>
#import <kaddprogressView.h>
#import <kaddNotificationCenter.h>
#import "LEDSwitch.h"
#import "SnowView.h"

static NSString *avUrl;
id playbackObserver;
CMTime currentT;
#define kTimeScale 60.0
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
CGPoint lastMenuLocation;
AVSpeechSynthesizer *speechSynthesizer;
UIViewController *popController;

//////////////////////////////////////////////////////////////////
void fileCheck() {
	if (access("/", F_OK) == -1) {
		//アクセスできない
	} else {
		//アクセスできる
	}
}

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

UIDevice *dev = [UIDevice currentDevice];

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
UDID : %@\r\n", \

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
//////////////////////////////////////////////////////////////////

@implementation XXRootViewController

- (void)loadView { // 1番初めに呼ばれる
	self.view = [[UIView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];

	//AVPlayerItem
	[self initAddAvPlayer];


	//現在時刻
	//[self initCurrentTimeLabel];

	//[self.view layoutIfNeeded];

	//fileCheck();

	[self testSnowAndRain];

	//[self addEmitter];

	[self initVersion];

	//CurrentTimeSlider
	[self initCurrentTimeSlider];
	[self initCustomSlider];

}

- (void)viewDidLoad { // loadViewの次に呼ばれ、一度だけ生成される
	[super viewDidLoad];
	[LocationHandler.sharedInstance setDelegate:self];
	[LocationHandler.sharedInstance startUpdating];
	//[self initUIViewButtonAction];
	//[self initPCappAction];
	[self initUIBarButtonItem];
	[self initControllPanel];

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

	//Siri読み上げ
	//[self initSiri];


}

- (void)tapbt {

	UIAlertController *alert = [UIAlertController 
		alertControllerWithTitle:pcapptitle 
		message:pcAppmessage 
		preferredStyle:UIAlertControllerStyleActionSheet];

	//Respring
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"Respring" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(krespring);
		}]];

	[alert addAction:[UIAlertAction 
		actionWithTitle:@"sbreload" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post("com.mikiyan1978.sbreload");
		}]];

	//カウントダウンRespring
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

	//キャンセル
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

	//uicache(通知あり)
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"uicache" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(kuicache);
		addActivityIndicator(self.IndicatorView, 
			message, 18.0, self);
		notify_post("com.mikiyan1978.alertapplibbulletinuicachenoti");

		}]];

	//launchctl reboot userspace
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"userspace reboot" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post("com.mikiyan1978.rebootUserspace");
		}]];

	//セーフモード
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
		//notify_post(kreboot);
		}]];

	//ldrestart
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"ldrestart" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post(klibpowercontrollerldrestart);
		}]];

	//libnotifications/通知テスト
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"libnotifications通知" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post("com.mikiyan1978.alertapplibnotificationsuicachenoti");
		}]];

	//libbulletin/通知テスト
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

	//UNUserNotificationCenter/通知テスト
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"UNUserNotificationCenter通知" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		[self UNUserNotificationCenterHandler];
		}]];

	//schedule/通知テスト
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"スケジューリング通知" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		addscheduleNotificationCenter(20, 40);

		}]];

	//通知キャンセル
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"通知キャンセル" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		[[UNUserNotificationCenter currentNotificationCenter] 
			removeAllPendingNotificationRequests];

		}]];

	//Substitute(F_OK)
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"Substitute(F_OK)" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		if (access(SUBSTITUTE_PATH, F_OK) == 0) {
		if (@available(iOS 14, *)) {

		UIAlertController *alert = [UIAlertController 
			alertControllerWithTitle:@"Substitute確認" 
			message:@"Substituteがインストールされており、かつiOS14以降である事を確認しました" 
			preferredStyle:UIAlertControllerStyleAlert];

		[alert addAction:[UIAlertAction 
			actionWithTitle:@"Cancel"
			style:UIAlertActionStyleCancel 
			handler:nil]];

		[self presentViewController:alert 
			animated:YES 
			completion:nil];

		}

		} else {

		UIAlertController *alert = [UIAlertController 
			alertControllerWithTitle:@"Substitute確認" 
			message:@"Substituteが未インストールかつiOS14以下であることを確認しました" 
			preferredStyle:UIAlertControllerStyleAlert];

		[alert addAction:[UIAlertAction 
			actionWithTitle:@"Cancel"
			style:UIAlertActionStyleCancel 
			handler:nil]];

		[self presentViewController:alert 
			animated:YES 
			completion:nil];

		}

		}]];

	//addAlertManager
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"addAlertManager" 
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		[addAlertManager.sharedInstance 
			addAlert:self.addAlert 
			preferredStyle:UIAlertControllerStyleAlert 
			alertControllerWithTitle:@"addAlertManagerテスト" 
			alertMessage:@"Siri" 
			actionWithTitle:@"Siri読み上げ" 
			target:self 
			actionHandler:^(){

			notify_post("com.mikiyan1978.siri");

			}];

		}]];

	//プログレスバー
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

	//スクショ
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"スクショ"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		notify_post("com.mikiyan1978.takeScreenshot");

		}]];

	//Device Information
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

	//画面回転
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"画面回転"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post("com.mikiyan1978.lockandunlock");
		}]];

	//ロック
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"ロック"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		dispatch_after(dispatch_time 
			(DISPATCH_TIME_NOW, 
			(int64_t)(1.0 * NSEC_PER_SEC)), 
			dispatch_get_main_queue(), ^{
			notify_post(klock);
		});

		}]];

//////////////////////////////////////////////////////////////////

	//キャンセル
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
	os_log(OS_LOG_DEFAULT, "再生開始");

	addAvPlayer(avUrl, 1.0, self);

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

- (void)initControllPanel {
	UIView *controlView = [[UIView alloc] 
		initWithFrame:CGRectMake(0, 530, W, 50)];

	controlView.backgroundColor = [UIColor clearColor];
	controlView.layer.cornerRadius = 13.0;
	[self.view addSubview:controlView];

	//startImg, stopImg
	UIView *startImgstopImgview = [UIView new];
	startImgstopImgview.backgroundColor = [UIColor clearColor];
	[startImgstopImgview.heightAnchor 
		constraintEqualToConstant:30].active = true;
	[startImgstopImgview.widthAnchor 
		constraintEqualToConstant:30].active = true;

	//backwardImg
	UIView *backwardImgview = [UIView new];
	backwardImgview.backgroundColor = [UIColor clearColor];
	[backwardImgview.heightAnchor 
		constraintEqualToConstant:30].active = true;
	[backwardImgview.widthAnchor 
		constraintEqualToConstant:30].active = true;

	//forwardImg
	UIView *forwardImgview = [UIView new];
	forwardImgview.backgroundColor = [UIColor clearColor];
	[forwardImgview.heightAnchor 
		constraintEqualToConstant:30].active = true;
	[forwardImgview.widthAnchor 
		constraintEqualToConstant:30].active = true;

	//playBackTime
	UIView *playBackTimeview = [UIView new];
	playBackTimeview.backgroundColor = [UIColor clearColor];
	[playBackTimeview.heightAnchor 
		constraintEqualToConstant:30].active = true;
	[playBackTimeview.widthAnchor 
		constraintEqualToConstant:60].active = true;

	//playBackTotalTime
	UIView *playBackTotalTimeview = [UIView new];
	playBackTotalTimeview.backgroundColor = [UIColor clearColor];
	[playBackTotalTimeview.heightAnchor 
		constraintEqualToConstant:30].active = true;
	[playBackTotalTimeview.widthAnchor 
		constraintEqualToConstant:60].active = true;

	self.startImg = [UIImage 
		imageNamed:@"playback_play.png"];
	self.stopImg = [UIImage 
		imageNamed:@"playback_pause.png"];
	self.backwardImg = [UIImage 
		imageNamed:@"playback_prev.png"];
	self.forwardImg = [UIImage 
		imageNamed:@"playback_ff.png"];

	self.startbtn = [[UIButton alloc] 
		initWithFrame:CGRectMake(0, 0, 30, 30)];
	[self.startbtn 
		setBackgroundImage:self.stopImg 
		forState:UIControlStateNormal];
	[self.startbtn 
		addTarget:self 
		action:@selector(videoPlay) 
		forControlEvents:UIControlEventTouchUpInside];


	self.backbtn = [[UIButton alloc] 
		initWithFrame:CGRectMake(0, 0, 30, 30)];
	[self.backbtn 
		setBackgroundImage:self.backwardImg 
		forState:UIControlStateNormal];
	[self.backbtn 
		addTarget:self 
		action:@selector(backwardPressed) 
		forControlEvents:UIControlEventTouchUpInside];


	self.forwardbtn = [[UIButton alloc] 
		initWithFrame:CGRectMake(0, 0, 30, 30)];
	[self.forwardbtn 
		setBackgroundImage:self.forwardImg 
		forState:UIControlStateNormal];
	[self.forwardbtn 
		addTarget:self 
		action:@selector(forwardPressed) 
		forControlEvents:UIControlEventTouchUpInside];


	[startImgstopImgview addSubview:self.startbtn];
	[backwardImgview addSubview:self.backbtn];
	[forwardImgview addSubview:self.forwardbtn];


	//Stack View
	UIStackView *stackView = [UIStackView new];
	stackView.axis = UILayoutConstraintAxisHorizontal;
	stackView.distribution = UIStackViewDistributionEqualSpacing;
	stackView.alignment = UIStackViewAlignmentCenter;
	stackView.spacing = 35;

	[stackView 
		addArrangedSubview:playBackTimeview];
	[stackView 
		addArrangedSubview:backwardImgview];
	[stackView 
		addArrangedSubview:startImgstopImgview];
	[stackView 
		addArrangedSubview:forwardImgview];
	[stackView 
		addArrangedSubview:playBackTotalTimeview];

	stackView.translatesAutoresizingMaskIntoConstraints = false;
	[controlView addSubview:stackView];


	//Layout for Stack View
	[stackView.centerXAnchor constraintEqualToAnchor:controlView.centerXAnchor].active = true;
	[stackView.centerYAnchor constraintEqualToAnchor:controlView.centerYAnchor].active = true;


	currentT = [player currentTime];

	//現在の時間ラベル
	self.playBackTime = [[UILabel alloc] 
		initWithFrame:CGRectMake(25, 0, 60, 30)];
	self.playBackTime.text = [self getStringFromCMTime:player.currentTime];

//	self.playBackTime.adjustsFontSizeToFitWidth = YES;
	[self.playBackTime setTextColor:[UIColor whiteColor]];
	[playBackTimeview addSubview:self.playBackTime];

    
	//合計時間ラベル
	self.playBackTotalTime = [[UILabel alloc] 
		initWithFrame:CGRectMake(- 10, 0, 60, 30)];
	self.playBackTotalTime.text = [self getStringFromCMTime:player.currentItem.asset.duration];

//	self.playBackTotalTime.adjustsFontSizeToFitWidth = YES;
	[self.playBackTotalTime setTextColor:[UIColor whiteColor]];
	[playBackTotalTimeview addSubview:self.playBackTotalTime];


	CMTime interval = CMTimeMake(1, 1000);
	__weak __typeof(self) weakself = self;

	playbackObserver = [player 
		addPeriodicTimeObserverForInterval:interval 
		queue:dispatch_get_main_queue() 
		usingBlock: ^(CMTime time) {

	CMTime endTime = CMTimeConvertScale (
		player.currentItem.asset.duration, 
		player.currentTime.timescale, 
		kCMTimeRoundingMethod_RoundHalfAwayFromZero);

	if (CMTimeCompare(endTime, kCMTimeZero) != 0) {
		double normalizedTime = (double) player.currentTime.value / (double) endTime.value;
		weakself.progressBar.value = normalizedTime;
	}
	weakself.playBackTime.text = [self getStringFromCMTime:player.currentTime];
    }];
}

- (NSString*)getStringFromCMTime:(CMTime)time {
	Float64 currentSeconds = CMTimeGetSeconds(time);
	int mins = currentSeconds/60.0;
	int secs = fmodf(currentSeconds, 60.0);

	NSString *minsString = mins < 10 ? 
		[NSString stringWithFormat:@"0%d", mins] : 
		[NSString stringWithFormat:@"%d", mins];
	NSString *secsString = secs < 10 ? 
		[NSString stringWithFormat:@"0%d", secs] : 
		[NSString stringWithFormat:@"%d", secs];

	return [NSString stringWithFormat:@"%@:%@", minsString, secsString];
}

- (void)videoPlay {
	if (player.rate > 0) {
		[player pause];
		[self.startbtn 
			setBackgroundImage:self.startImg 
			forState:UIControlStateNormal];
	} else {
		[player play];
		[self.startbtn 
			setBackgroundImage:self.stopImg 
			forState:UIControlStateNormal];
	}
}

- (void)backwardPressed {
	[player seekToTime:CMTimeSubtract(
		player.currentTime, CMTimeMake(5, 1))];
}

- (void)forwardPressed {
	[player seekToTime:CMTimeAdd(
		player.currentTime, CMTimeMake(5, 1))];
}

#pragma mark - CurrentTimeSlider
- (void)initCurrentTimeSlider {
	self.progressBar = [[UISlider alloc] init];
	self.progressBar.frame = CGRectMake(25, 595, W - 50, 10);

	[self.progressBar addTarget:self 
		action:@selector(progressBarChanged:) 
		forControlEvents:UIControlEventValueChanged];

	[self.progressBar addTarget:self 
		action:@selector(proressBarChangeEnded:) 
		forControlEvents:UIControlEventTouchUpInside];

	[self.view addSubview:self.progressBar];
}

- (void)progressBarChanged:(UISlider *)sender {
	if (player.rate > 0) {
		[player pause];
	}

	CMTime seekTime = CMTimeMakeWithSeconds(sender.value * (double)player.currentItem.asset.duration.value / (double)player.currentItem.asset.duration.timescale, player.currentTime.timescale);
	[player seekToTime:seekTime];
}

- (void)proressBarChangeEnded:(UISlider *)sender {
	if (!player.rate) {
		[player play];
 	}
}

#pragma mark - Custom UISlider
- (void)initCustomSlider {
	
	//ツマミの画像
	UIImage *imageForThumb = [UIImage 
		imageNamed:@"love_red.png"];

/*	//Min側の下地画像
	UIImage *imageMinBase = [[UIImage 
		imageNamed:@"slider_left.png"] 
		stretchableImageWithLeftCapWidth:4 
		topCapHeight:0];

	//Max側の下地画像
	UIImage *imageMaxBase = [[UIImage 
		imageNamed:@"slider_right.png"] 
		stretchableImageWithLeftCapWidth:4 
		topCapHeight:0];
*/

	//各画像をセット
	[self.progressBar setThumbImage:imageForThumb 
		forState:UIControlStateNormal];
/*	[self.progressBar 
		setMinimumTrackImage:imageMinBase 
		forState:UIControlStateNormal];
	[self.progressBar 
		setMaximumTrackImage:imageMaxBase 
		forState:UIControlStateNormal];
*/
}

#pragma mark - initPCappAction
- (void)initPCappAction {

	[addButtonManager.sharedInstance 
		addButton:self.pcappButton 
		title:pcapptitle 
		delegate:self 
		action:pcappAction 
		toItem:self.view 
		multiplierX:1.0f 
		constantX:0.0f 
		multiplierY:0.4f 
		constantY:0.0f];
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
			0, 
			H / 2 - 150, 
			W, //wide
			50 //height
		)];

	mainView.backgroundColor = [self randomColor];
	mainView.layer.cornerRadius = 20.0;
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

	self.rightButtonItem2 = [[UIBarButtonItem alloc] 
		initWithTitle:@"🔄" 
		style:UIBarButtonItemStyleDone 
		target:self 
		action:@selector(isLocked)];

	self.leftButtonItem = [[UIBarButtonItem alloc] 
		initWithTitle:@"📱" 
		style:UIBarButtonItemStyleDone 
		target:self 
		action:@selector(leftButtonTapped)];

	self.leftButtonItem1 = [[UIBarButtonItem alloc] 
		initWithTitle:@"log" 
		style:UIBarButtonItemStyleDone 
		target:self 
		action:@selector(logButtonTapped)];

	self.navigationItem.rightBarButtonItems = @[
		self.rightButtonItem2, 
		self.rightButtonItem, 
		self.rightButtonItem1];

	self.navigationItem.leftBarButtonItems = @[
		self.leftButtonItem, 
		self.leftButtonItem1];

	//self.navigationItem.rightBarButtonItem = self.rightButtonItem;
	//self.navigationItem.leftBarButtonItem = self.leftButtonItem;
}

- (void)isLocked {
	notify_post("com.mikiyan1978.lockandunlock");
}

- (void)leftButtonTapped {
	//sleep(5); // #include <unistd.h>

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

- (void)logButtonTapped {
	
	popController = [UIViewController new];
	popController.modalPresentationStyle = UIModalPresentationPopover;
	popController.preferredContentSize = 
		CGSizeMake(150, 80);

	UILabel *respringLabel = [[UILabel alloc] init];
	respringLabel.frame = CGRectMake(0, 10, 150, 50);
	respringLabel.numberOfLines = 2;
	respringLabel.textAlignment = NSTextAlignmentCenter;
	respringLabel.adjustsFontSizeToFitWidth = YES;
	respringLabel.font = [UIFont boldSystemFontOfSize:15];
	respringLabel.textColor = [UIColor labelColor];
	respringLabel.text = @"Are you sure you want to respring?";
	[popController.view addSubview:respringLabel];


	UIButton *yesButton = [UIButton 
		buttonWithType:UIButtonTypeCustom];
	[yesButton 
		addTarget:self 
		action:@selector(handleYesGesture) 
		forControlEvents:UIControlEventTouchUpInside];
	[yesButton setTitle:@"Yes" 
		forState:UIControlStateNormal];
	[yesButton setTitleColor:[UIColor labelColor] 
		forState:UIControlStateNormal];
	yesButton.frame = CGRectMake(75, 60, 75, 30);
	[popController.view addSubview:yesButton];

    
	UIButton *noButton = [UIButton 
		buttonWithType:UIButtonTypeCustom];
	[noButton 
		addTarget:self 
		action:@selector(handleNoGesture) 
		forControlEvents:UIControlEventTouchUpInside];
	[noButton setTitle:@"No" 
		forState:UIControlStateNormal];
	[noButton setTitleColor:[UIColor labelColor] 
		forState:UIControlStateNormal];
	noButton.frame = CGRectMake(0, 60, 75, 30);
	[popController.view addSubview:noButton];

	//UIPopoverPresentationController
	UIPopoverPresentationController *popover = popController.popoverPresentationController;
	[popover setBackgroundColor:[UIColor grayColor]];
	popover.delegate = self;
	popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
	popover.barButtonItem = self.leftButtonItem1;

	[self presentViewController:popController 
		animated:YES 
		completion:nil];

	AudioServicesPlaySystemSound(1025);

}

- (void)handleYesGesture {
	notify_post("com.mikiyan1978.sbreload");
}

- (void)handleNoGesture {
	AudioServicesPlaySystemSound(1025);
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
	return UIModalPresentationNone;
}

//シェア
- (void)shareTapped {
   
	//NSString *shareText = @"#Power Controller App by @mikiyan1978! repo in Cydia for free!";
	
	//UIImage *image = [UIImage imageWithContentsOfFile:PCAImagePath];

	UIImage *image = [UIImage imageNamed:@"box.png"];

	//NSURL *url = [NSURL URLWithString:@"https://kisaragiray.github.io/repo/"];

	//NSURL *imageUrl = [NSURL URLWithString:@"https://www.jailbreakme.com/saffron/icon@2x.png"];

	NSArray *itemsToShare = @[image];



	if (%c(UIActivityViewController)) {
		UIActivityViewController *uiacontroller = [[%c(UIActivityViewController) alloc] 
			initWithActivityItems:itemsToShare 
			applicationActivities:nil];

		[self presentViewController:uiacontroller 
			animated:YES 
			completion:NULL];
	} else {
		/*[[UIApplication sharedApplication] 
			openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/intent/tweet?text=%@%%20%@", URL_ENCODE(shareText), URL_ENCODE(imageUrl.absoluteString)]] 
			options:@{} 
			completionHandler:nil];*/
	}

	/*UIActivityViewController *controller = [[UIActivityViewController alloc] 
		initWithActivityItems:itemsToShare 
		applicationActivities:nil];

	dispatch_async(dispatch_get_main_queue(), ^{
		[self presentActivityController:controller];
	});*/

	//[self presentActivityController:controller];
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

#pragma mark - 穴開きビュー
- (void)initUIViewButtonAction {

	[addButtonManager.sharedInstance 
		addButton:self.uiViewButton 
		title:uiViewButtonTitle 
		delegate:self 
		action:uiViewButtonAction 
		toItem:self.view 
		multiplierX:1.0f 
		constantX:0.0f 
		multiplierY:1.7f 
		constantY:0.0f];
}

- (void)uiViewButtonAction {
	[self makeHoleAt:CGPointMake(W / 2, H / 2) radius:50];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 
		(int64_t)(2.0 * NSEC_PER_SEC)), 
		dispatch_get_main_queue(), ^{
			[cashapeView removeFromSuperview];
	});
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

- (void)initSiri {
	speechSynthesizer = [AVSpeechSynthesizer new];
	NSString* speakingText = @"この度はPower Controller App Xをインストールして頂き、誠にありがとうございます";
	AVSpeechUtterance *utterance = [AVSpeechUtterance 
		speechUtteranceWithString:speakingText];
	utterance.voice = [AVSpeechSynthesisVoice 
		voiceWithLanguage:@"ja-JP"];
	utterance.rate = 0.5; //速度
	utterance.pitchMultiplier = 1.0;
	utterance.volume = 1.0;
	//NSTimeInterval interval = 0.1;
	//utterance.preUtteranceDelay = interval;
	//utterance.postUtteranceDelay = interval;
	[speechSynthesizer speakUtterance:utterance];

	NSString* speakingText2 = @"Power Controller App X";
	AVSpeechUtterance *utterance2 = [AVSpeechUtterance 
		speechUtteranceWithString:speakingText2];
	utterance.voice = [AVSpeechSynthesisVoice 
		voiceWithLanguage:@"ja-JP"];
	utterance2.rate = 0.5;
	utterance2.pitchMultiplier = 1.0;
	utterance2.volume = 1.0;
	[speechSynthesizer speakUtterance:utterance2];
}


- (void)testSnowAndRain{
	// 雪降らす
	UIImageView *snowImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	snowImageView.image = [UIImage imageNamed:@"snow_white"];

	CAEmitterLayerView *snowView = [[SnowView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	//snowView.maskView = snowImageView;
	[self.view addSubview:snowView];
	[snowView show];

	/*// 雨降らす
	UIImageView *rainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	rainImageView.image = [UIImage imageNamed:@"alpha"];

	CAEmitterLayerView *rainView = [[RainView alloc] initWithFrame:CGRectMake(100, 210, 100, 100)];
	rainView.maskView = rainImageView;
	[self.view addSubview:rainView];
	[rainView show];*/

}

- (void)addEmitter {
    //创建粒子的Layer
    CAEmitterLayer* emitterLayer = [CAEmitterLayer layer];
    //显示边框
    emitterLayer.borderWidth = 1.f;
    emitterLayer.borderColor = [UIColor whiteColor].CGColor;
    //给定尺寸
    emitterLayer.frame = CGRectMake(100, 400, 100, 100);
    //发射点
    emitterLayer.emitterPosition = CGPointMake(50, 50);
    //发射模式
    emitterLayer.emitterMode = kCAEmitterLayerSurface;
    //发射形状
    emitterLayer.emitterShape = kCAEmitterLayerLine;
    //添加到父Layer上
    [self.view.layer addSublayer:emitterLayer];
    
    
    //创建粒子
    CAEmitterCell* emitterCell = [CAEmitterCell emitterCell];
    //粒子発生率
    emitterCell.birthRate = 1.f;//这个相当于是某单位时间产生粒子的个数
    //粒子のライフサイクル
    emitterCell.lifetime = 120.f;//这个是单个粒子的生命周期的时间
    //速度值
    emitterCell.velocity = 10;
    //速度値の微調整値
    emitterCell.velocityRange = 3.f;
    //y轴加速度
    emitterCell.yAcceleration = 2.f;//这里的设置表示在y轴正方向有个2.f大小的加速度，模拟重力
    //発射角度
    emitterCell.emissionRange = M_PI * M_1_PI;// 暂时不理解
    //パーティクルの色を設定します
    emitterCell.color = [UIColor blueColor].CGColor;
    //画像を設定する
    emitterCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"snow"].CGImage);// 我暂时不理解图片的要求是什么？
    //让CAEmitterCell与CAEmitterLayer产生关联
    emitterLayer.emitterCells = @[emitterCell];//用的数组，说明一个CAEmitterLayer可以关联多个CAEmitterCell
    
}

- (void)initVersion {
	//バージョンアップした時のアラート
	NSString *bundleVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];

	NSString *loadedVersion = @"1.0";
 
	// show alert view
	if ([loadedVersion compare:bundleVersion options:NSNumericSearch] == NSOrderedAscending) {

		[addAlertManager.sharedInstance 
			addAlert:self.vaddAlert 
			preferredStyle:UIAlertControllerStyleAlert 
			alertControllerWithTitle:[NSString stringWithFormat:@"バージョン%@の変更点", bundleVersion] 
			alertMessage:@"バージョンアップしました！" 
			actionWithTitle:@"そうなんですね！" 
			target:self 
			actionHandler:^(){

		}];
	}
}

- (void)lock {
	notify_post("com.mikiyan1978.lock");
}

- (void)unlock {
	notify_post("com.mikiyan1978.unlock");
}

/////////////////////メモリ警告/////////////////////////////////
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

