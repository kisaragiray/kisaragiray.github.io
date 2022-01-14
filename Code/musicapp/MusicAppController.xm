#import "MusicAppController.h"

@implementation MusicAppController
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
	self.view.backgroundColor = [UIColor cyanColor];
	
	[[NSDistributedNotificationCenter defaultCenter] removeObserver:self];
	
	[[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(updateImage:) name:@"changeNowPlayingInfo" object:nil];
	
	//[[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTransition:) name:@"changeNowPlayingInfo" object:nil];
}

- (void)viewDidLoad {
	[self initArtworkView];
	[self initNowPlayingInfoSong];
	[self initNowPlayingInfoArtist];
	[self initNowPlayingInfoAlbum];
	
	[self initPlayPauseButton];
}

- (void)initArtworkView {
	_artworkContainerView = [UIView new];
	_artworkContainerView.backgroundColor = [UIColor clearColor];
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
	_artworkView.layer.cornerRadius = 330 / 8;
	//_artworkView.layer.cornerRadius = _artworkView.frame.size.height / 8;
	[_artworkContainerView insertSubview:_artworkView atIndex:1];

	_artworkView.translatesAutoresizingMaskIntoConstraints = NO;
	[_artworkView.widthAnchor constraintEqualToConstant:330].active = YES;
	[_artworkView.heightAnchor constraintEqualToConstant:330].active = YES;
	[_artworkView.centerXAnchor constraintEqualToAnchor:_artworkContainerView.centerXAnchor constant:0].active = YES;
	[_artworkView.centerYAnchor constraintEqualToAnchor:_artworkContainerView.centerYAnchor constant:0].active = YES;
}

- (void)initNowPlayingInfoSong {
	_nowPlayingInfoSong = [CBAutoScrollLabel new];
	_nowPlayingInfoSong.textColor = [UIColor redColor];
	_nowPlayingInfoSong.textAlignment = NSTextAlignmentCenter;
	_nowPlayingInfoSong.font = [UIFont fontWithName:@"HoeflerText-BlackItalic" size:22];
	_nowPlayingInfoSong.clipsToBounds = NO;
	[self.view addSubview:_nowPlayingInfoSong];
	_nowPlayingInfoSong.translatesAutoresizingMaskIntoConstraints = NO;
	[_nowPlayingInfoSong.widthAnchor constraintEqualToConstant:300].active = YES;
	[_nowPlayingInfoSong.heightAnchor constraintEqualToConstant:30].active = YES;
	[_nowPlayingInfoSong.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
	[_nowPlayingInfoSong.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:50].active = YES;
}

- (void)initNowPlayingInfoArtist {
	_nowPlayingInfoArtist = [CBAutoScrollLabel new];
	_nowPlayingInfoArtist.textColor = [UIColor blueColor];
	_nowPlayingInfoArtist.textAlignment = NSTextAlignmentCenter;
	_nowPlayingInfoArtist.font = [UIFont fontWithName:@"AvenirNextCondensed-HeavyItalic" size:18];
	_nowPlayingInfoArtist.clipsToBounds = NO;
	[self.view addSubview:_nowPlayingInfoArtist];
	_nowPlayingInfoArtist.translatesAutoresizingMaskIntoConstraints = NO;
	[_nowPlayingInfoArtist.widthAnchor constraintEqualToConstant:300].active = YES;
	[_nowPlayingInfoArtist.heightAnchor constraintEqualToConstant:30].active = YES;
	[_nowPlayingInfoArtist.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
	[_nowPlayingInfoArtist.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:80].active = YES;
}

- (void)initNowPlayingInfoAlbum {
	_nowPlayingInfoAlbum = [CBAutoScrollLabel new];
	_nowPlayingInfoAlbum.textColor = [UIColor purpleColor];
	_nowPlayingInfoAlbum.textAlignment = NSTextAlignmentCenter;
	_nowPlayingInfoAlbum.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:20];
	_nowPlayingInfoAlbum.clipsToBounds = NO;
	[self.view addSubview:_nowPlayingInfoAlbum];
	
	_nowPlayingInfoAlbum.translatesAutoresizingMaskIntoConstraints = NO;
		[_nowPlayingInfoAlbum.widthAnchor constraintEqualToConstant:300].active = YES;
		[_nowPlayingInfoAlbum.heightAnchor constraintEqualToConstant:30].active = YES;
		[_nowPlayingInfoAlbum.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0].active = YES;
		[_nowPlayingInfoAlbum.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:110].active = YES;
}

- (void)initPlayPauseButton {
	_pauseButton = [[UIImageView alloc] initWithFrame:CGRectMake(W / 2, H / 2 + 130, 40, 40)];
	_pauseButton.clipsToBounds = YES;
	_pauseButton.layer.cornerRadius = 6;
	_pauseButton.userInteractionEnabled = YES;
	[self.view addSubview:_pauseButton];
}



- (void)playPause {
	MRMediaRemoteSendCommand(kMRTogglePlayPause, nil);
	AudioServicesPlaySystemSound(1519);
}

- (void)playingDidChange:(NSNotification *)notification {
	AudioServicesPlaySystemSound(1025);
}

- (void)updateTransition:(NSNotification *)notification {
	CATransition *transition = [CATransition animation];
	transition.duration = 1.0;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	transition.type = kCATransitionReveal;
	transition.subtype = kCATransitionFromRight;
	[_artworkView.layer addAnimation:transition forKey:nil];
}

- (void)updateImage:(NSNotification *)notification {
	MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {
		if (information) {
			NSDictionary* dict = (__bridge NSDictionary *)information;
			NSString *songName = dict[(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle];
			NSString *artistName = dict[(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtist];
			NSString *albumName = dict[(__bridge NSString *)kMRMediaRemoteNowPlayingInfoAlbum];
			NSData *artworkData = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtworkData];
			
			if(artworkData != nil) {
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
		}
	});
}
@end
