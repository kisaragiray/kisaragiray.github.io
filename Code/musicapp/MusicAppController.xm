#import "MusicAppController.h"

@implementation MusicAppController
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];

	[[NSDistributedNotificationCenter defaultCenter] removeObserver:self];
	
	[[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(updateImage) name:@"changeNowPlayingInfo" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateImage) name:UIApplicationDidBecomeActiveNotification object:nil];
	
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playPause) name:UIApplicationDidBecomeActiveNotification object:nil];
	
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enabledAudioSession) name:UIApplicationDidEnterBackgroundNotification object:nil];
	
	//[[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTransition:) name:@"changeNowPlayingInfo" object:nil];
}

- (void)viewDidLoad {//一度だけ
	[self initArtworkView];
	[self initSwipeGestureView];
	[self initNowPlayingInfoSong];
	[self initNowPlayingInfoArtist];
	[self initNowPlayingInfoAlbum];
	
	[self initVolumeView];
	
	[self initDoubleTapGesture];
	[self initSwipeRightGesture];
	[self initSwipeLeftGesture];
	//[self initPlayPauseButton];
	
	//[self setVolumeNotification];
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	[_artworkContainerView removeFromSuperview];
	[self initArtworkView];
	[self updateImage];
		
	[_mpVolumeView removeFromSuperview];
	[self initVolumeView];
	
	[_nowPlayingInfoSong removeFromSuperview];
	[self initNowPlayingInfoSong];
	
	[_nowPlayingInfoArtist removeFromSuperview];
	[self initNowPlayingInfoArtist];
	
	[_nowPlayingInfoAlbum removeFromSuperview];
	[self initNowPlayingInfoAlbum];
}

- (void)initArtworkView {
	_artworkContainerView = [UIView new];
	_artworkContainerView.contentMode = UIViewContentModeScaleAspectFill;
	_artworkContainerView.layer.masksToBounds = YES;
	[self.view addSubview:_artworkContainerView];
	_artworkContainerView.translatesAutoresizingMaskIntoConstraints = NO;
	[_artworkContainerView.widthAnchor constraintEqualToConstant:W].active = YES;
	[_artworkContainerView.heightAnchor constraintEqualToConstant:H / 2].active = YES;
	[_artworkContainerView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
	[_artworkContainerView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;


	_artworkView = [UIImageView new];
	_artworkView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/MusicApp/DefaultContainerArtwork.png"];
	_artworkView.backgroundColor = [UIColor clearColor];
	_artworkView.layer.borderColor = [[UIColor grayColor] CGColor];
	_artworkView.layer.borderWidth = 3.0f;
	_artworkView.contentMode = UIViewContentModeScaleAspectFill;
	_artworkView.layer.masksToBounds = YES;
	_artworkView.layer.cornerRadius = (H / 2) / 2;
	[_artworkContainerView insertSubview:_artworkView atIndex:1];

	_artworkView.translatesAutoresizingMaskIntoConstraints = NO;
	[_artworkView.widthAnchor constraintEqualToConstant:H / 2].active = YES;
	[_artworkView.heightAnchor constraintEqualToConstant:H / 2].active = YES;
	[_artworkView.centerXAnchor constraintEqualToAnchor:_artworkContainerView.centerXAnchor constant:0].active = YES;
	[_artworkView.centerYAnchor constraintEqualToAnchor:_artworkContainerView.centerYAnchor constant:0].active = YES;
}

- (void)initSwipeGestureView {
	_swipeGestureView = [UIView new];
	_swipeGestureView.contentMode = UIViewContentModeScaleAspectFill;
	_swipeGestureView.layer.masksToBounds = YES;
	[self.view addSubview:_swipeGestureView];
	_swipeGestureView.translatesAutoresizingMaskIntoConstraints = NO;
	[_swipeGestureView.widthAnchor constraintEqualToConstant:W].active = YES;
	[_swipeGestureView.heightAnchor constraintEqualToConstant:H / 2].active = YES;
	[_swipeGestureView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
	[_swipeGestureView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20].active = YES;
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

- (void)doubleTapGesture:(UISwipeGestureRecognizer *)sender {
	[self playPause];
}

- (void)swipeRightGesture:(UISwipeGestureRecognizer *)sender {
	[self previousTrack];
}

- (void)swipeLeftGesture:(UISwipeGestureRecognizer *)sender {
	[self nextTrack];
}

- (void)initVolumeView {
	_mpVolumeView = [MPVolumeView new];
	[self.view addSubview:_mpVolumeView];
	_mpVolumeView.backgroundColor = [UIColor clearColor];
	
	_mpVolumeView.translatesAutoresizingMaskIntoConstraints = NO;
	[_mpVolumeView.widthAnchor constraintEqualToConstant:W * 0.9].active = YES;
	[_mpVolumeView.heightAnchor constraintEqualToConstant:30].active = YES;
	[_mpVolumeView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
	[_mpVolumeView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:- 8].active = YES;
	
	//[NSLayoutConstraint activateConstraints:@[[_mpVolumeView.widthAnchor constraintEqualToConstant:W / 2], [_mpVolumeView.heightAnchor constraintEqualToConstant:30], [_mpVolumeView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0], [_mpVolumeView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:300]]];
}

- (void)initNowPlayingInfoSong {
	_nowPlayingInfoSong = [CBAutoScrollLabel new];
	_nowPlayingInfoSong.textColor = [UIColor redColor];
	_nowPlayingInfoSong.textAlignment = NSTextAlignmentCenter;
	_nowPlayingInfoSong.font = [UIFont fontWithName:@"851MkPOP" size:24];
	//_nowPlayingInfoSong.font = [UIFont fontWithName:@"HoeflerText-BlackItalic" size:22];
	_nowPlayingInfoSong.clipsToBounds = NO;
	[self.view addSubview:_nowPlayingInfoSong];
	_nowPlayingInfoSong.translatesAutoresizingMaskIntoConstraints = NO;
	[_nowPlayingInfoSong.widthAnchor constraintEqualToConstant:W * 0.9].active = YES;
	[_nowPlayingInfoSong.heightAnchor constraintEqualToConstant:30].active = YES;
	[_nowPlayingInfoSong.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
	[_nowPlayingInfoSong.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:50].active = YES;
}

- (void)initNowPlayingInfoArtist {
	_nowPlayingInfoArtist = [CBAutoScrollLabel new];
	_nowPlayingInfoArtist.textColor = [UIColor blueColor];
	_nowPlayingInfoArtist.textAlignment = NSTextAlignmentCenter;
	_nowPlayingInfoArtist.font = [UIFont fontWithName:@"851MkPOP" size:18];
	_nowPlayingInfoArtist.clipsToBounds = NO;
	[self.view addSubview:_nowPlayingInfoArtist];
	_nowPlayingInfoArtist.translatesAutoresizingMaskIntoConstraints = NO;
	[_nowPlayingInfoArtist.widthAnchor constraintEqualToConstant:W * 0.9].active = YES;
	[_nowPlayingInfoArtist.heightAnchor constraintEqualToConstant:30].active = YES;
	[_nowPlayingInfoArtist.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
	[_nowPlayingInfoArtist.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:80].active = YES;
}

- (void)initNowPlayingInfoAlbum {
	_nowPlayingInfoAlbum = [CBAutoScrollLabel new];
	_nowPlayingInfoAlbum.textColor = [UIColor purpleColor];
	_nowPlayingInfoAlbum.textAlignment = NSTextAlignmentCenter;
	_nowPlayingInfoAlbum.font = [UIFont fontWithName:@"851MkPOP" size:22];
	_nowPlayingInfoAlbum.clipsToBounds = NO;
	[self.view addSubview:_nowPlayingInfoAlbum];
	
	_nowPlayingInfoAlbum.translatesAutoresizingMaskIntoConstraints = NO;
	[_nowPlayingInfoAlbum.widthAnchor constraintEqualToConstant:W * 0.9].active = YES;
	[_nowPlayingInfoAlbum.heightAnchor constraintEqualToConstant:30].active = YES;
	[_nowPlayingInfoAlbum.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
	[_nowPlayingInfoAlbum.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:110].active = YES;
}

- (void)play {
	MRMediaRemoteSendCommand(kMRPlay, nil);
	AudioServicesPlaySystemSound(1519);
}

- (void)pause {
	MRMediaRemoteSendCommand(kMRPause, nil);
	AudioServicesPlaySystemSound(1519);
}

- (void)playPause {
	MRMediaRemoteSendCommand(kMRTogglePlayPause, nil);
	AudioServicesPlaySystemSound(1519);
}

- (void)nextTrack {
	MRMediaRemoteSendCommand(kMRNextTrack, nil);
	AudioServicesPlaySystemSound(1519);
}

- (void)previousTrack {
	MRMediaRemoteSendCommand(kMRPreviousTrack, nil);
	AudioServicesPlaySystemSound(1519);
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
			NSData *artworkData = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtworkData];
			
			if(artworkData != nil) {
				_artworkView.image = [UIImage imageWithData:artworkData];
				[self initRotateAnimation];
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
				self.view.backgroundColor = [self averageColor:_artworkView.image withAlpha:1];
			} else {
				self.view.backgroundColor = [UIColor cyanColor];
			}
		}
	});
}

- (void)initRotateAnimation {
	CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	rotationAnimation.toValue = [NSNumber numberWithFloat:(M_PI / 180) * 360];
	rotationAnimation.duration = 30.0f;
	rotationAnimation.repeatCount = HUGE_VALF;
	[_artworkView.layer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
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

-(void)dealloc {
//オブジェクトが解放されるときに呼ばれる
}
@end
