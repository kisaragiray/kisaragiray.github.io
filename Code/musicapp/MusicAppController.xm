#import "MusicAppController.h"

NSData *artworkData;
static UIEdgeInsets const kMargin = {10, 10, 10, 10};

@implementation MusicAppController
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];

	
	//_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	
	[NSDistributedNotificationCenter.defaultCenter removeObserver:self];
	
	[NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(updateImage) name:@"changeNowPlayingInfo" object:nil];
	
	[NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(playingDidChange:) name:@"changeNowPlayingInfo" object:nil];
	
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(orientationAction) name:UIDeviceOrientationDidChangeNotification object:nil];
	
	//artwork回転
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(initArtworkViewRotateAnimation) name:UIApplicationDidBecomeActiveNotification object:nil];
	
	//バックグラウンド処理
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(willResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
	
	//[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(playPause) name:UIApplicationDidBecomeActiveNotification object:nil];
	
	//[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(enabledAudioSession) name:UIApplicationDidEnterBackgroundNotification object:nil];
	
	//[NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(updateTransition:) name:@"changeNowPlayingInfo" object:nil];
	

}

- (void)viewDidLoad {//一度だけ
	[self initEffectView];
	[self initArtworkView];
	[self initArtworkViewRotateAnimation];
	//[self initArtworkViewMask];
	[self initSwipeGestureView];
	//[self initCurrentAppImageView];
	[self initControllView];
	[self initNowPlayingInfoSong];
	[self initNowPlayingInfoArtist];
	[self initNowPlayingInfoAlbum];
	[self initPlayPauseButton];
	[self initnextButton];
	[self initpreviousButton];
	
	//[self initVolumeView];
	
	[self initLongPressGesture];
	//[self initPanGesture];
	[self initDoubleTapGesture];
	[self initSwipeRightGesture];
	[self initSwipeLeftGesture];
	[self initSwipeUpDownGesture];
	
	//[self initblackBall];
	//[self demoGravity];
	
	//[self initPlayPauseButton];
	
	//[self setVolumeNotification];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
}

- (void)viewWillAppear:(BOOL)animated {
	//viewが表示される直前に呼ばれる
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	//完全に遷移が行われ、スクリーン上に表示された時に呼ばれる
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	//viewが表示されなくなる直前に呼び出される
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	//完全に遷移が行われ、スクリーン上からViewControllerが表示されなくなったときに呼ばれる
	[super viewDidDisappear:animated];
}

- (void)willResignActive:(NSNotification *)notification {
	UIApplication *app = UIApplication.sharedApplication;
	_bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
		[app endBackgroundTask:_bgTask];
		_bgTask = UIBackgroundTaskInvalid;
	}];
}

- (void)didBecomeActive:(NSNotification *)notification {
	[UIApplication.sharedApplication endBackgroundTask:_bgTask];
}

- (void)orientationAction {
	[_artworkContainerView removeFromSuperview];
	if (ORIENTATION == LANDSCAPERIGHT || ORIENTATION == LANDSCAPELEFT) {
		[self initLandscapeArtworkView];
		[self updateImage];
		[self initArtworkViewRotateAnimation];
	} else if (ORIENTATION == POTRAIT) {
		[self initArtworkView];
		[self updateImage];
		[self initArtworkViewRotateAnimation];
	}
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	
	[super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	[_artworkContainerView removeFromSuperview];
	[self initArtworkView];
	[self initArtworkViewRotateAnimation];
	[self updateImage];
	
	[_swipeGestureView removeFromSuperview];
	[self initSwipeGestureView];
	//[self initCurrentAppImageView];
	[self initLongPressGesture];
	//[self initPanGesture];
	[self initDoubleTapGesture];
	[self initSwipeRightGesture];
	[self initSwipeLeftGesture];
	[self initSwipeUpDownGesture];
	
	//[_controllView removeFromSuperview];
	//[self initControllView];
	[_nowPlayingInfoSong removeFromSuperview];
	[self initNowPlayingInfoSong];
	[_nowPlayingInfoArtist removeFromSuperview];
	[self initNowPlayingInfoArtist];
	[_nowPlayingInfoAlbum removeFromSuperview];
	[self initNowPlayingInfoAlbum];
	[_currentAppLabel removeFromSuperview];
	[self initPlayPauseButton];
	[self initnextButton];
	[self initpreviousButton];

	
	if (ORIENTATION == LANDSCAPERIGHT || ORIENTATION == LANDSCAPELEFT) {
		[_artworkContainerView removeFromSuperview];
		[self initLandscapeArtworkView];
		[self initArtworkViewRotateAnimation];
			
		[_swipeGestureView removeFromSuperview];
		[self initSwipeGestureView];
		//[self initCurrentAppImageView];
		[self initLongPressGesture];
		//[self initPanGesture];
		[self initDoubleTapGesture];
		[self initSwipeRightGesture];
		[self initSwipeLeftGesture];
		[self initSwipeUpDownGesture];
			
	} else if (ORIENTATION == POTRAIT) {
		[_artworkContainerView removeFromSuperview];
		[self initArtworkView];
		[self initArtworkViewRotateAnimation];
		[self updateImage];
	
		[_swipeGestureView removeFromSuperview];
		[self initSwipeGestureView];
		//[self initCurrentAppImageView];
		[self initLongPressGesture];
		//[self initPanGesture];
		[self initDoubleTapGesture];
		[self initSwipeRightGesture];
		[self initSwipeLeftGesture];
		[self initSwipeUpDownGesture];
	}
	
	[_mpVolumeView removeFromSuperview];
	//[self initVolumeView];
}


- (void)initEffectView {
	_backgroundView = [UIImageView new];
	_backgroundView.frame = UIScreen.mainScreen.bounds;
	
	[_backgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
	_backgroundView.contentMode = UIViewContentModeScaleAspectFill;
	[self.view addSubview:_backgroundView];
	
	[NSLayoutConstraint activateConstraints:@[
		[_backgroundView.topAnchor constraintEqualToAnchor:self.view.topAnchor], 
		[_backgroundView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor], 
		[_backgroundView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor], 
		[_backgroundView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor], 
		[_backgroundView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor]
		]];
	
	UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
	UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
	
	UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
	[effectView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[_backgroundView addSubview:effectView];
	
	[NSLayoutConstraint activateConstraints:@[
		[effectView.topAnchor constraintEqualToAnchor:self.view.topAnchor], 
		[effectView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor], 
		[effectView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor], 
		[effectView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor], 
		[effectView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor]
		]];

	UIVisualEffectView *vibrantView = [[UIVisualEffectView alloc] initWithEffect:vibrancy];
	[vibrantView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[_backgroundView addSubview:vibrantView];

	
	[NSLayoutConstraint activateConstraints:@[
		[vibrantView.topAnchor constraintEqualToAnchor:self.view.topAnchor], 
		[vibrantView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor], 
		[vibrantView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor], 
		[vibrantView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor], 
		[vibrantView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor]
		]];
}

- (void)initArtworkView {
	_artworkContainerView = [UIView new];
	[_artworkContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
	_artworkContainerView.contentMode = UIViewContentModeScaleAspectFill;
	_artworkContainerView.layer.masksToBounds = YES;
	[self.view addSubview:_artworkContainerView];
	
	[_artworkContainerView.widthAnchor constraintEqualToConstant:sW].active = YES;
	[_artworkContainerView.heightAnchor constraintEqualToConstant:sH / 2].active = YES;
	[_artworkContainerView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
	[_artworkContainerView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;


	_artworkView = [UIImageView new];
	[_artworkView setTranslatesAutoresizingMaskIntoConstraints:NO];
	_artworkView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/MusicApp/DefaultContainerArtwork.png"];
	_artworkView.backgroundColor = [UIColor clearColor];
	_artworkView.layer.borderColor = [[UIColor grayColor] CGColor];
	_artworkView.layer.borderWidth = 3.0f;
	_artworkView.contentMode = UIViewContentModeScaleAspectFill;
	_artworkView.layer.masksToBounds = YES;
	_artworkView.layer.cornerRadius = (sH / 2) / 2;
	[_artworkContainerView insertSubview:_artworkView atIndex:1];
	
	
	[_artworkView.widthAnchor constraintEqualToConstant:sH / 2].active = YES;
	[_artworkView.heightAnchor constraintEqualToConstant:sH / 2].active = YES;
	[_artworkView.centerXAnchor constraintEqualToAnchor:_artworkContainerView.centerXAnchor constant:0].active = YES;
	[_artworkView.centerYAnchor constraintEqualToAnchor:_artworkContainerView.centerYAnchor constant:0].active = YES;
}

- (void)initLandscapeArtworkView {
	_artworkContainerView = [UIView new];
	_artworkContainerView.contentMode = UIViewContentModeScaleAspectFill;
	_artworkContainerView.layer.masksToBounds = YES;
	[self.view addSubview:_artworkContainerView];
	_artworkContainerView.translatesAutoresizingMaskIntoConstraints = NO;
	[_artworkContainerView.widthAnchor constraintEqualToConstant:sW].active = YES;
	[_artworkContainerView.heightAnchor constraintEqualToConstant:sH * 0.8].active = YES;
	[_artworkContainerView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
	[_artworkContainerView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;


	_artworkView = [UIImageView new];
	_artworkView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/MusicApp/DefaultContainerArtwork.png"];
	_artworkView.backgroundColor = [UIColor clearColor];
	_artworkView.layer.borderColor = [[UIColor grayColor] CGColor];
	_artworkView.layer.borderWidth = 3.0f;
	_artworkView.contentMode = UIViewContentModeScaleAspectFill;
	_artworkView.layer.masksToBounds = YES;
	_artworkView.layer.cornerRadius = (sH * 0.8) / 2;
	[_artworkContainerView insertSubview:_artworkView atIndex:1];

	_artworkView.translatesAutoresizingMaskIntoConstraints = NO;
	[_artworkView.widthAnchor constraintEqualToConstant:sH * 0.8].active = YES;
	[_artworkView.heightAnchor constraintEqualToConstant:sH * 0.8].active = YES;
	[_artworkView.centerXAnchor constraintEqualToAnchor:_artworkContainerView.centerXAnchor constant:- sW / 4].active = YES;
	[_artworkView.centerYAnchor constraintEqualToAnchor:_artworkContainerView.centerYAnchor constant:0].active = YES;
}

- (void)initControllView {
	_controllView = [UIView new];
	[_controllView setTranslatesAutoresizingMaskIntoConstraints:NO];
	_controllView.backgroundColor = UIColor.clearColor;
	[self.view addSubview:_controllView];
	
	[NSLayoutConstraint activateConstraints:@[
		[_controllView.topAnchor constraintEqualToAnchor:self.view.topAnchor], 
		[_controllView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor], 
		[_controllView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor], 
		[_controllView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor], 
		[_controllView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:0]
		]];
	
}

- (void)initArtworkViewMask {
	UIImage *maskImage = [UIImageMask resize:[UIImageMask getUIImageFromResources:@"mask" ext:@"png"] rect:CGRectMake(0, 0, sH / 2, sH / 2)];
	UIImage *maskedImage = [UIImageMask mask:_artworkView.image withMask:maskImage];
	
	UIImage *dstImage = nil;
	UIImage *overlayImage = [UIImage imageNamed:@"Overlay"];
	CGSize size = maskedImage.size;
	
	UIGraphicsBeginImageContextWithOptions(size, 0.0f, [[UIScreen mainScreen] scale]);
	
	[maskedImage drawInRect:CGRectMake(0,0,size.width,size.height)];
	
	[overlayImage drawInRect:CGRectMake(0,0,size.width,size.height)];
	dstImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	_artworkView.image = dstImage;
}

- (void)initSwipeGestureView {
	if (ORIENTATION == LANDSCAPERIGHT || ORIENTATION == LANDSCAPELEFT) {
		_swipeGestureView = [UIView new];
		_swipeGestureView.contentMode = UIViewContentModeScaleAspectFill;
		_swipeGestureView.layer.masksToBounds = YES;
		[self.view addSubview:_swipeGestureView];
	_swipeGestureView.translatesAutoresizingMaskIntoConstraints = NO;
		[_swipeGestureView.widthAnchor constraintEqualToConstant:sW / 2].active = YES;
		[_swipeGestureView.heightAnchor constraintEqualToConstant:sH - 50].active = YES;
		[_swipeGestureView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0].active = YES;
		[_swipeGestureView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0].active = YES;
		
	} else if (ORIENTATION == POTRAIT) {
		_swipeGestureView = [UIView new];
		_swipeGestureView.contentMode = UIViewContentModeScaleAspectFill;
		_swipeGestureView.layer.masksToBounds = YES;
		[self.view addSubview:_swipeGestureView];
	_swipeGestureView.translatesAutoresizingMaskIntoConstraints = NO;
		[_swipeGestureView.widthAnchor constraintEqualToConstant:sW].active = YES;
		[_swipeGestureView.heightAnchor constraintEqualToConstant:sH / 2].active = YES;
		[_swipeGestureView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
		[_swipeGestureView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;
	}
}

- (void)initCurrentAppImageView {
	//SBApplication *app = [[%c(SBMediaController) sharedInstance] nowPlayingApplication];
	
	if (ORIENTATION == LANDSCAPERIGHT || ORIENTATION == LANDSCAPELEFT) {
		_currentAppImageView = [UIImageView new];
		_currentAppImageView.image = [UIImage _applicationIconImageForBundleIdentifier:[NSBundle mainBundle].bundleIdentifier format:2 scale:[UIScreen mainScreen].scale];
		//_currentAppImageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/MusicApp/DefaultContainerArtwork.png"];
		_currentAppImageView.contentMode = UIViewContentModeScaleAspectFill;
		_currentAppImageView.layer.masksToBounds = YES;
		_currentAppImageView.layer.cornerRadius = 50 / 4;
		[_swipeGestureView addSubview:_currentAppImageView];
	_currentAppImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[_currentAppImageView.widthAnchor constraintEqualToConstant:50].active = YES;
		[_currentAppImageView.heightAnchor constraintEqualToConstant:50].active = YES;
		[_currentAppImageView.trailingAnchor constraintEqualToAnchor:_swipeGestureView.trailingAnchor constant:- 15].active = YES;
		[_currentAppImageView.bottomAnchor constraintEqualToAnchor:_swipeGestureView.bottomAnchor constant:- 15].active = YES;
		
	} else if (ORIENTATION == POTRAIT) {
		_currentAppImageView = [UIImageView new];
		_currentAppImageView.image = [UIImage _applicationIconImageForBundleIdentifier:[NSBundle mainBundle].bundleIdentifier format:2 scale:[UIScreen mainScreen].scale];
		//_currentAppImageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/MusicApp/DefaultContainerArtwork.png"];
		_currentAppImageView.contentMode = UIViewContentModeScaleAspectFill;
		_currentAppImageView.layer.masksToBounds = YES;
		_currentAppImageView.layer.cornerRadius = 50 / 4;
		[_swipeGestureView addSubview:_currentAppImageView];
	_currentAppImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[_currentAppImageView.widthAnchor constraintEqualToConstant:50].active = YES;
		[_currentAppImageView.heightAnchor constraintEqualToConstant:50].active = YES;
		[_currentAppImageView.trailingAnchor constraintEqualToAnchor:_swipeGestureView.trailingAnchor constant:- 15].active = YES;
		[_currentAppImageView.bottomAnchor constraintEqualToAnchor:_swipeGestureView.bottomAnchor constant:- 15].active = YES;
	}
}

//プレイポーズボタン
- (void)initPlayPauseButton {
	if (ORIENTATION == LANDSCAPERIGHT || ORIENTATION == LANDSCAPELEFT) {
		_playPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_playPauseButton setTitle:@"" forState:UIControlStateNormal];
		[_playPauseButton addTarget:self action:@selector(playPause) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_playPauseButton];
		
	_playPauseButton.translatesAutoresizingMaskIntoConstraints = NO;
		[_playPauseButton.widthAnchor constraintEqualToConstant:40].active = YES;
		[_playPauseButton.heightAnchor constraintEqualToConstant:40].active = YES;
		[_playPauseButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:0].active = YES;
		[_playPauseButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
		
	} else if (ORIENTATION == POTRAIT) {
		_playPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_playPauseButton setTitle:@"" forState:UIControlStateNormal];
		[_playPauseButton addTarget:self action:@selector(playPause) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_playPauseButton];
		
	_playPauseButton.translatesAutoresizingMaskIntoConstraints = NO;
		[_playPauseButton.widthAnchor constraintEqualToConstant:40].active = YES;
		[_playPauseButton.heightAnchor constraintEqualToConstant:40].active = YES;
		[_playPauseButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
		[_playPauseButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:250].active = YES;
	}
}

//進むボタン
- (void)initnextButton {
	if (ORIENTATION == LANDSCAPERIGHT || ORIENTATION == LANDSCAPELEFT) {
		_nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_nextButton setTitle:@"" forState:UIControlStateNormal];
		[_nextButton setImage:[[UIImage systemImageNamed:@"forward.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
		[_nextButton addTarget:self action:@selector(nextTrack) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_nextButton];
		
	_nextButton.translatesAutoresizingMaskIntoConstraints = NO;
		[_nextButton.widthAnchor constraintEqualToConstant:70].active = YES;
		[_nextButton.heightAnchor constraintEqualToConstant:70].active = YES;
		[_nextButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:70].active = YES;
		[_nextButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;
		
	} else if (ORIENTATION == POTRAIT) {
		_nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_nextButton setTitle:@"" forState:UIControlStateNormal];
		[_nextButton setImage:[[UIImage systemImageNamed:@"forward.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
		[_nextButton addTarget:self action:@selector(nextTrack) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_nextButton];
		
	_nextButton.translatesAutoresizingMaskIntoConstraints = NO;
		[_nextButton.widthAnchor constraintEqualToConstant:50].active = YES;
		[_nextButton.heightAnchor constraintEqualToConstant:50].active = YES;
		[_nextButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:80].active = YES;
		[_nextButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:250].active = YES;
	}
}

//戻るボタン
- (void)initpreviousButton {
	if (ORIENTATION == LANDSCAPERIGHT || ORIENTATION == LANDSCAPELEFT) {
		_forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_forwardButton setTitle:@"" forState:UIControlStateNormal];
		[_forwardButton setImage:[[UIImage systemImageNamed:@"backward.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
		[_forwardButton addTarget:self action:@selector(previousTrack) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_forwardButton];
		
	_forwardButton.translatesAutoresizingMaskIntoConstraints = NO;
		[_forwardButton.widthAnchor constraintEqualToConstant:40].active = YES;
		[_forwardButton.heightAnchor constraintEqualToConstant:40].active = YES;
		[_forwardButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
		[_forwardButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;
		
	} else if (ORIENTATION == POTRAIT) {
		_forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_forwardButton setTitle:@"" forState:UIControlStateNormal];
		[_forwardButton setImage:[[UIImage systemImageNamed:@"backward.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
		[_forwardButton addTarget:self action:@selector(previousTrack) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_forwardButton];
		
	_forwardButton.translatesAutoresizingMaskIntoConstraints = NO;
		[_forwardButton.widthAnchor constraintEqualToConstant:50].active = YES;
		[_forwardButton.heightAnchor constraintEqualToConstant:50].active = YES;
		[_forwardButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-80].active = YES;
		[_forwardButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:250].active = YES;
	}
}


- (void)initLongPressGesture {
	UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
	longPressGesture.minimumPressDuration = 0.5;
	longPressGesture.numberOfTouchesRequired = 1;
	[_swipeGestureView addGestureRecognizer:longPressGesture];
}

- (void)initPanGesture {
	UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
	[self.view addGestureRecognizer:panGesture];
}

- (void)initDoubleTapGesture {
	UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGesture:)];
	doubleTapGesture.numberOfTapsRequired = 2;
	[_swipeGestureView addGestureRecognizer:doubleTapGesture];
}

- (void)initSwipeRightGesture {
	UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightGesture:)];
	swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
	[_swipeGestureView addGestureRecognizer:swipeRightGesture];
}

- (void)initSwipeLeftGesture {
	UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftGesture:)];
	swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
	[_swipeGestureView addGestureRecognizer:swipeLeftGesture];
}

- (void)initSwipeUpDownGesture {
	UISwipeGestureRecognizer* swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUpGesture:)];
	swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
	[_swipeGestureView addGestureRecognizer:swipeUpGesture];
	
	UISwipeGestureRecognizer* swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownGesture:)];
	swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
	[_swipeGestureView addGestureRecognizer:swipeDownGesture];
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)sender {
	if (sender.state == UIGestureRecognizerStateBegan) {
			//notify_post("openMusic");
		notify_post("showLyrics");
			
	} else if (sender.state == UIGestureRecognizerStateEnded) {
		//離された処理
	}
}

- (void)panGesture:(UIPanGestureRecognizer *)sender {
	CGPoint p = [sender translationInView:self.view];
	CGPoint movedPoint = CGPointMake(_blackBall.center.x + p.x, _blackBall.center.y + p.y);
	_blackBall.center = movedPoint;
	[sender setTranslation:CGPointZero inView:self.view];
}

- (void)doubleTapGesture:(UITapGestureRecognizer *)sender {
	[self playPause];
}

- (void)swipeRightGesture:(UISwipeGestureRecognizer *)sender {
	[self previousTrack];
}

- (void)swipeLeftGesture:(UISwipeGestureRecognizer *)sender {
	[self nextTrack];
}

- (void)swipeUpGesture:(UISwipeGestureRecognizer *)sender {
	AudioServicesPlaySystemSound(1025);
}

- (void)swipeDownGesture:(UISwipeGestureRecognizer *)sender {
	AudioServicesPlaySystemSound(1026);
}

- (void)initVolumeView {
	_mpVolumeView = [MPVolumeView new];	
	_mpVolumeView.backgroundColor = [UIColor clearColor];
	_mpVolumeView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:_mpVolumeView];
	
	[_mpVolumeView.widthAnchor constraintEqualToConstant:sW * 0.9].active = YES;
	[_mpVolumeView.heightAnchor constraintEqualToConstant:35].active = YES;
	[_mpVolumeView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active = YES;
	[_mpVolumeView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
	
	//[NSLayoutConstraint activateConstraints:@[[_mpVolumeView.widthAnchor constraintEqualToConstant:W / 2], [_mpVolumeView.heightAnchor constraintEqualToConstant:30], [_mpVolumeView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0], [_mpVolumeView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:300]]];
}

- (void)initNowPlayingInfoSong {
	if (ORIENTATION == LANDSCAPERIGHT || ORIENTATION == LANDSCAPELEFT) {
		_nowPlayingInfoSong = [CBAutoScrollLabel new];
		_nowPlayingInfoSong.textColor = [UIColor redColor];
		_nowPlayingInfoSong.textAlignment = NSTextAlignmentCenter;
		_nowPlayingInfoSong.font = [UIFont fontWithName:@"pricedown" size:25];
		//_nowPlayingInfoSong.font = [UIFont fontWithName:@"HoeflerText-BlackItalic" size:22];
		_nowPlayingInfoSong.clipsToBounds = NO;
		[self.view addSubview:_nowPlayingInfoSong];
	_nowPlayingInfoSong.translatesAutoresizingMaskIntoConstraints = NO;
		[_nowPlayingInfoSong.widthAnchor constraintEqualToConstant:sW * 0.4].active = YES;
		[_nowPlayingInfoSong.heightAnchor constraintEqualToConstant:30].active = YES;
		[_nowPlayingInfoSong.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:sW / 4].active = YES;
		[_nowPlayingInfoSong.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:- sH / 4].active = YES;
	
	} else if (ORIENTATION == POTRAIT) {
		_nowPlayingInfoSong = [CBAutoScrollLabel new];
		_nowPlayingInfoSong.textColor = [UIColor redColor];
		_nowPlayingInfoSong.textAlignment = NSTextAlignmentCenter;
		_nowPlayingInfoSong.font = [UIFont fontWithName:@"pricedown" size:25];
		//_nowPlayingInfoSong.font = [UIFont fontWithName:@"HoeflerText-BlackItalic" size:22];
		_nowPlayingInfoSong.clipsToBounds = NO;
		[self.view addSubview:_nowPlayingInfoSong];
		_nowPlayingInfoSong.translatesAutoresizingMaskIntoConstraints = NO;
		[_nowPlayingInfoSong.widthAnchor constraintEqualToConstant:sW * 0.9].active = YES;
		[_nowPlayingInfoSong.heightAnchor constraintEqualToConstant:30].active = YES;
		[_nowPlayingInfoSong.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
		[_nowPlayingInfoSong.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:120].active = YES;
	}
	
}

- (void)initNowPlayingInfoArtist {
	if (ORIENTATION == LANDSCAPERIGHT || ORIENTATION == LANDSCAPELEFT) {
		_nowPlayingInfoArtist = [CBAutoScrollLabel new];
		_nowPlayingInfoArtist.textColor = [UIColor blueColor];
		_nowPlayingInfoArtist.textAlignment = NSTextAlignmentCenter;
		_nowPlayingInfoArtist.font = [UIFont fontWithName:@"pricedown" size:19];
		_nowPlayingInfoArtist.clipsToBounds = NO;
		[self.view addSubview:_nowPlayingInfoArtist];
		_nowPlayingInfoArtist.translatesAutoresizingMaskIntoConstraints = NO;
		[_nowPlayingInfoArtist.widthAnchor constraintEqualToConstant:sW * 0.4].active = YES;
		[_nowPlayingInfoArtist.heightAnchor constraintEqualToConstant:30].active = YES;
		[_nowPlayingInfoArtist.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:sW / 4].active = YES;
		[_nowPlayingInfoArtist.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:0].active = YES;
		
	} else if (ORIENTATION == POTRAIT) {
		_nowPlayingInfoArtist = [CBAutoScrollLabel new];
		_nowPlayingInfoArtist.textColor = [UIColor blueColor];
		_nowPlayingInfoArtist.textAlignment = NSTextAlignmentCenter;
		_nowPlayingInfoArtist.font = [UIFont fontWithName:@"pricedown" size:19];
		_nowPlayingInfoArtist.clipsToBounds = NO;
		[self.view addSubview:_nowPlayingInfoArtist];
		_nowPlayingInfoArtist.translatesAutoresizingMaskIntoConstraints = NO;
		[_nowPlayingInfoArtist.widthAnchor constraintEqualToConstant:sW * 0.9].active = YES;
		[_nowPlayingInfoArtist.heightAnchor constraintEqualToConstant:30].active = YES;
		[_nowPlayingInfoArtist.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
		[_nowPlayingInfoArtist.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:160].active = YES;
	}
}

- (void)initNowPlayingInfoAlbum {
	if (ORIENTATION == LANDSCAPERIGHT || ORIENTATION == LANDSCAPELEFT) {
		_nowPlayingInfoAlbum = [CBAutoScrollLabel new];
		_nowPlayingInfoAlbum.textColor = [UIColor purpleColor];
		_nowPlayingInfoAlbum.textAlignment = NSTextAlignmentCenter;
		_nowPlayingInfoAlbum.font = [UIFont fontWithName:@"pricedown" size:23];
		_nowPlayingInfoAlbum.clipsToBounds = NO;
		[self.view addSubview:_nowPlayingInfoAlbum];
	
		_nowPlayingInfoAlbum.translatesAutoresizingMaskIntoConstraints = NO;
		[_nowPlayingInfoAlbum.widthAnchor constraintEqualToConstant:sW * 0.4].active = YES;
		[_nowPlayingInfoAlbum.heightAnchor constraintEqualToConstant:30].active = YES;
		[_nowPlayingInfoAlbum.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:sW / 4].active = YES;
		[_nowPlayingInfoAlbum.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:sH / 4].active = YES;
		
	} else if (ORIENTATION == POTRAIT) {
		_nowPlayingInfoAlbum = [CBAutoScrollLabel new];
		_nowPlayingInfoAlbum.textColor = [UIColor purpleColor];
		_nowPlayingInfoAlbum.textAlignment = NSTextAlignmentCenter;
		_nowPlayingInfoAlbum.font = [UIFont fontWithName:@"pricedown" size:23];
		_nowPlayingInfoAlbum.clipsToBounds = NO;
		[self.view addSubview:_nowPlayingInfoAlbum];
	
		_nowPlayingInfoAlbum.translatesAutoresizingMaskIntoConstraints = NO;
		[_nowPlayingInfoAlbum.widthAnchor constraintEqualToConstant:sW * 0.9].active = YES;
		[_nowPlayingInfoAlbum.heightAnchor constraintEqualToConstant:30].active = YES;
		[_nowPlayingInfoAlbum.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
		[_nowPlayingInfoAlbum.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:200].active = YES;
	}
}

- (void)play {
	MRMediaRemoteSendCommand(kMRPlay, nil);
	[self playHapticFeedback];
	//AudioServicesPlaySystemSound(1519);
}

- (void)pause {
	MRMediaRemoteSendCommand(kMRPause, nil);
	[self playHapticFeedback];
	//AudioServicesPlaySystemSound(1519);
}

- (void)playPause {
	notify_post("togglePlayPause");
	//MRMediaRemoteSendCommand(kMRTogglePlayPause, nil);
	[self playHapticFeedback];
	//AudioServicesPlaySystemSound(1519);
}

- (void)nextTrack {
	MRMediaRemoteSendCommand(kMRNextTrack, nil);
	[self playHapticFeedback];
	//AudioServicesPlaySystemSound(1519);
}

- (void)previousTrack {
	MRMediaRemoteSendCommand(kMRPreviousTrack, nil);
	[self playHapticFeedback];
	//AudioServicesPlaySystemSound(1519);
}

- (void)mute {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ArtWork保存" message:@"ArtWork保存しますか？" preferredStyle:UIAlertControllerStyleActionSheet];
	
	[alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
		UIImageWriteToSavedPhotosAlbum(_artworkView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
	}]];

	[alert addAction:[UIAlertAction actionWithTitle:@"キャンセル" style:UIAlertActionStyleCancel handler:nil]];

	[self presentViewController:alert animated:YES completion:nil];
	
	os_log(OS_LOG_DEFAULT, "xxxxxxxxxxxxxxxxxxxxx");
}

- (void)image:(UIImage *)image 
didFinishSavingWithError:(NSError *)error 
contextInfo:(void *)contextInfo {
	
}

- (void)enabledAudioSession {
	_audioSession = [AVAudioSession sharedInstance];
	[_audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
	//[_audioSession setMode:AVAudioSessionModeSpokenAudio error:nil];
	[_audioSession setActive:YES error:nil];
}

- (void)volumeChanged:(NSNotification *)notification {
	
	if ([[[notification userInfo] objectForKey:@"AVSystemController_AudioVolumeChangeReasonNotificationParameter"] isEqualToString:@"ExplicitVolumeChange"]) {
		AudioServicesPlaySystemSound(1025);

		[[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
		
		[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setVolumeNotification) object:nil];
		
		[self performSelector:@selector(setVolumeNotification) withObject:nil afterDelay:0.2];
	}
}

- (void)setVolumeNotification {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
}

- (void)updateTransition:(NSNotification *)notification {
	CATransition *transition = [CATransition animation];
	transition.duration = 1.0;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	transition.type = kCATransitionReveal;
	transition.subtype = kCATransitionFromRight;
	[_artworkView.layer addAnimation:transition forKey:nil];
}

- (void)updateImage {
	MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {
		if (information) {
			NSDictionary* dict = (__bridge NSDictionary *)information;
			NSString *songName = dict[(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle];
			NSString *artistName = dict[(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtist];
			NSString *albumName = dict[(__bridge NSString *)kMRMediaRemoteNowPlayingInfoAlbum];
			artworkData = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtworkData];
			
			if(artworkData != nil) {
				//UIImage *maskImage = [UIImageMask resize:[UIImageMask getUIImageFromResources:@"mask" ext:@"png"] rect:CGRectMake(0, 0, H / 2, H / 2)];
				//UIImage *maskedImage = [UIImageMask mask:[UIImage imageWithData:artworkData] withMask:maskImage];
				
				/*UIImage *dstImage = nil;
				UIImage *overlayImage = [UIImage imageNamed:@"Overlay"];
				CGSize size = maskedImage.size;
				UIGraphicsBeginImageContextWithOptions(size, 0, [[UIScreen mainScreen] scale]);
				[maskedImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
				[overlayImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
				dstImage = UIGraphicsGetImageFromCurrentImageContext();
				UIGraphicsEndImageContext();
	
				_artworkView.image = dstImage;*/
				
				//_artworkView.image = maskedImage;
				
				_artworkView.image = [UIImage imageWithData:artworkData];
				
			} else {
				_artworkView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/MusicApp/DefaultContainerArtwork.png"];
			}
			
			if (songName != nil) {
				_nowPlayingInfoSong.text = [NSString stringWithFormat:@"%@", songName];
			} else {
				_nowPlayingInfoSong.text = @" ";
			}
			
			if (artistName != nil) {
				_nowPlayingInfoArtist.text = [NSString stringWithFormat:@"%@", artistName];
			} else {
				_nowPlayingInfoArtist.text = @" ";
			}
			
			if (albumName != nil) {
				_nowPlayingInfoAlbum.text = [NSString stringWithFormat:@"%@", albumName];
			} else {
				_nowPlayingInfoAlbum.text = @" ";
			}
			
			if (artworkData != nil) {
				_backgroundView.image = [UIImage imageWithData:artworkData];
				
				//self.view.backgroundColor = [self getPrimaryColor:_artworkView.image];
				
				//self.view.backgroundColor = [self averageColor:_artworkView.image withAlpha:1];
			} else {
				self.view.backgroundColor = [UIColor cyanColor];
			}
		}
	});
}

- (void)playingDidChange:(NSNotification *)notification {
	
MRMediaRemoteGetNowPlayingApplicationIsPlaying(dispatch_get_main_queue(), ^(Boolean isPlayingNow){
	if (isPlayingNow == YES) {
		[_playPauseButton setBackgroundImage:[[UIImage systemImageNamed:@"pause.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
	} else {
		[_playPauseButton setBackgroundImage:[[UIImage systemImageNamed:@"play.fill"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
	}
});
}

- (void)playHapticFeedback {
	AudioServicesPlaySystemSound(1521);
}

- (void)initArtworkViewRotateAnimation {
	CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.toValue = [NSNumber numberWithFloat:(M_PI / 180) * 360];
	rotationAnimation.duration = 30.0f;
	rotationAnimation.repeatCount = HUGE_VALF;
	[_artworkView.layer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
}

- (void)initblackBall {
	_blackBall = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 50, 50)];
	_blackBall.backgroundColor = [UIColor redColor];
	_blackBall.layer.cornerRadius = 25.0;
	_blackBall.layer.borderColor = [UIColor blackColor].CGColor;
	_blackBall.layer.borderWidth = 0.0;
	[self.view addSubview:_blackBall];
}

- (void)demoGravity {
	_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	
	UIGravityBehavior *gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[self.blackBall]];

	gravityBeahvior.magnitude = 0.1;

	[_animator addBehavior:gravityBeahvior];
	UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.blackBall]];
	collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
	[_animator addBehavior:collisionBehavior];
}

- (void)recordPlayerMask {
	
}




- (UIColor *)averageColor:(UIImage *)image withAlpha:(CGFloat)alphaValue {
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	unsigned char rgba[4];
	CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	
	CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), image.CGImage);
	CGColorSpaceRelease(colorSpace);
	CGContextRelease(context);
	
	if(rgba[3] > 0) {
		CGFloat alpha = alphaValue;
		
		if (alphaValue == 1) alpha = ((CGFloat)rgba[3]) / 255.0;
		CGFloat multiplier = alpha / 255.0;
		return [UIColor colorWithRed:((CGFloat)rgba[0]) * multiplier green:((CGFloat)rgba[1]) * multiplier blue:((CGFloat)rgba[2]) * multiplier alpha:alpha];
		
	} else {
		return [UIColor colorWithRed:((CGFloat)rgba[0]) / 255.0 green:((CGFloat)rgba[1]) / 255.0 blue:((CGFloat)rgba[2]) / 255.0 alpha:((CGFloat)rgba[3]) / 255.0];
	}
}

//平均色
- (UIColor *)getPrimaryColor:(UIImage*) image {
	if(!image) return [UIColor whiteColor];
	
	CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
	CIVector *extentVector = [CIVector vectorWithX:inputImage.extent.origin.x Y:inputImage.extent.origin.y Z:inputImage.extent.size.width W:inputImage.extent.size.height];
	
	CIFilter *filter = [CIFilter filterWithName:@"CIAreaAverage" withInputParameters:@{@"inputImage": inputImage, @"inputExtent": extentVector}];
	CIImage *outputImage = filter.outputImage;

	UInt8 bitmap[4] = {0};
	CIContext *context = [[CIContext alloc] initWithOptions:@{kCIContextWorkingColorSpace: [NSNull null]}];

	[context render:outputImage toBitmap:&bitmap rowBytes:4 bounds:CGRectMake(0, 0, 1, 1) format:kCIFormatRGBA8 colorSpace:nil];

	return [UIColor colorWithRed:bitmap[0]/ 255.0 green:bitmap[1] / 255.0 blue:bitmap[2]/255.0 alpha:bitmap[3]/255.0];

}

- (BOOL)isDarkImage:(UIImage*) inputImage {
	if(!inputImage) return [UIColor whiteColor];
	BOOL isDark = FALSE;
	
	CFDataRef imageData = CGDataProviderCopyData(CGImageGetDataProvider(inputImage.CGImage));
	const UInt8 *pixels = CFDataGetBytePtr(imageData);
	
	int darkPixels = 0;
	
	int length = CFDataGetLength(imageData);
	int const darkPixelThreshold = (inputImage.size.width*inputImage.size.height)*.45;
	
	for(int i=0; i<length; i+=4) {
		int r = pixels[i];
		int g = pixels[i+1];
		int b = pixels[i+2];

	//輝度計算により、人間の目の r と b により多くの重みが与えられます
		float luminance = (0.299*r + 0.587*g + 0.114*b);
		if (luminance<150) darkPixels ++;
	}
	
	if (darkPixels >= darkPixelThreshold)
	isDark = YES;
	CFRelease(imageData);
	return isDark;
}

- (void)dealloc {
//オブジェクトが解放されるときに呼ばれる
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}
@end

%ctor {
	BOOL shouldLoad = NO;
	
	NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
	
	NSUInteger count = args.count;
	
	if (count != 0) {
		NSString *executablePath = args[0];
		
		if (executablePath) {
			NSString *processName = [executablePath lastPathComponent];
			
			BOOL isSpringBoard = [processName isEqualToString:@"SpringBoard"];
			BOOL isPreferences = [processName isEqualToString:@"Preferences"];
			BOOL isApplication = [executablePath rangeOfString:@"/Application/"].location != NSNotFound || [executablePath rangeOfString:@"/Applications/"].location != NSNotFound;
			BOOL isFileProvider = [[processName lowercaseString] rangeOfString:@"fileprovider"].location != NSNotFound;
			BOOL skip = [processName isEqualToString:@"AdSheet"] || [processName isEqualToString:@"CoreAuthUI"] || [processName isEqualToString:@"InCallService"] || [processName isEqualToString:@"MessagesNotificationViewService"] || [executablePath rangeOfString:@".appex/"].location != NSNotFound;
			
			if (!isFileProvider && (isSpringBoard || isApplication || isPreferences) && !skip) {
				shouldLoad = YES;
			}
		}
	}
}