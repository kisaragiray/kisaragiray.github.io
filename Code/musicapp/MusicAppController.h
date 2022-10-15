@interface MusicAppController : UIViewController <MPMediaPickerControllerDelegate>
@property (nonatomic, retain) UIImageView *backgroundView;
@property (nonatomic, retain) UIView *artworkContainerView;
@property (nonatomic, retain) UIView *controllView;
@property (nonatomic, retain) MPVolumeView *mpVolumeView;
@property (nonatomic, retain) UIView *swipeGestureView;
@property (nonatomic, retain) UIImageView *currentAppImageView;
@property (nonatomic, retain) UIImageView *artworkView;
@property (nonatomic, retain) UIImage *artworkImage;

@property (nonatomic, retain) CBAutoScrollLabel *nowPlayingInfoSong;
@property (nonatomic, retain) CBAutoScrollLabel *nowPlayingInfoArtist;
@property (nonatomic, retain) CBAutoScrollLabel *nowPlayingInfoAlbum;
@property (nonatomic, retain) CBAutoScrollLabel *currentAppLabel;

@property (nonatomic, retain) UIButton *pauseButton;
@property (nonatomic, retain) UIButton *forwardButton;
@property (nonatomic, retain) UIButton *nextButton;
@property (nonatomic, retain) UIProgressView *volumeBar;
@property (nonatomic, retain) AVAudioSession *audioSession;
@property (nonatomic, retain) MPMusicPlayerController *player;
@property (nonatomic, retain) UIButton *musicPickerButton;
@property (nonatomic, retain) UIButton *playPauseButton;

@property (nonatomic, retain) UIView *blackBall;
@property (nonatomic, retain) UIDynamicAnimator *animator;

@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTask;
@end

@interface SBApplication: NSObject 
@property NSString *bundleIdentifier;
-(NSString *)displayName;
@end

@interface SBMediaController
+(id)sharedInstance;
+(void)sendResetPlaybackTimeoutCommand;
+(BOOL)applicationCanBeConsideredNowPlaying:(id)arg1 ;
-(void)routingControllerAvailableRoutesDidChange:(id)arg1 ;
-(void)cancelVolumeEvent;
-(id)init;
-(BOOL)pauseForEventSource:(long long)arg1 ;
-(void)_updateScreenSharingStatusBarStyleOverrideSuppressionPreference:(id)arg1 ;
-(BOOL)likeTrackForEventSource:(long long)arg1 ;
-(BOOL)toggleShuffleForEventSource:(long long)arg1 ;
-(BOOL)isPlaying;
-(void)displayMonitor:(id)arg1 willDisconnectIdentity:(id)arg2 ;
-(void)_clearScreenSharingStatusBarStyleOverride;
-(void)_updateDisplayMonitorState;
-(BOOL)playForEventSource:(long long)arg1 ;
-(BOOL)hasTrack;
-(BOOL)banTrackForEventSource:(long long)arg1 ;
-(void)setSuppressHUD:(BOOL)arg1 ;
-(BOOL)_displayMonitorHasAConnectedExternalIdentity;
-(void)_applicationActivityStatusDidChange:(id)arg1 ;
-(void)_mediaRemoteNowPlayingInfoDidChange:(id)arg1 ;
-(void)_setNowPlayingApplication:(id)arg1 ;
-(void)setNowPlayingProcessPID:(int)arg1 ;
-(id)nameOfPickedRoute;
-(BOOL)isFirstTrack;
-(BOOL)beginSeek:(int)arg1 eventSource:(long long)arg2 ;
-(BOOL)routeOtherThanHandsetIsAvailable;
-(void)cache:(id)arg1 didUpdateAirplayDisplayActive:(BOOL)arg2 ;
-(void)updateScreenSharingStatusBarStyleOverride;
-(void)_mediaRemoteNowPlayingApplicationIsPlayingDidChange:(id)arg1 ;
-(BOOL)setPlaybackSpeed:(int)arg1 eventSource:(long long)arg2 ;
-(BOOL)volumeControlIsAvailable;
-(BOOL)isApplicationActivityActive;
-(BOOL)isLastTrack;
-(void)_unregisterForNotifications;
-(void)cacheDidRebuildAfterServerDeath:(id)arg1 ;
-(BOOL)togglePlayPauseForEventSource:(long long)arg1 ;
-(void)_notifyThatScreenSharingChanged;
-(SBApplication *)nowPlayingApplication;
-(void)displayMonitor:(id)arg1 didConnectIdentity:(id)arg2 withConfiguration:(id)arg3 ;
-(NSDate *)lastActivityDate;
-(int)nowPlayingProcessPID;
-(BOOL)wirelessDisplayRouteIsPicked;
-(void)_startVideoOutStatusBarStyleOverride;
-(void)_nowPlayingAppDidExit:(id)arg1 ;
-(BOOL)handsetRouteIsSelected;
-(BOOL)_sendMediaCommand:(unsigned)arg1 options:(id)arg2 ;
-(BOOL)endSeek:(int)arg1 eventSource:(long long)arg2 ;
-(BOOL)addTrackToWishListForEventSource:(long long)arg1 ;
-(void)dealloc;
-(void)_updateLastRecentActivityDate;
-(void)_authenticationStateChanged:(id)arg1 ;
-(BOOL)isPaused;
-(void)setNowPlayingInfo:(id)arg1 ;
-(void)_updateAVRoutes;
-(BOOL)suppressHUD;
-(void)_registerForNotifications;
-(void)_clearVideoOutStatusBarStyleOverride;
-(BOOL)changeTrack:(int)arg1 eventSource:(long long)arg2 ;
-(BOOL)isScreenSharing;
-(BOOL)toggleRepeatForEventSource:(long long)arg1 ;
-(id)_nowPlayingInfo;
-(BOOL)stopForEventSource:(long long)arg1 ;
-(void)_mediaRemoteNowPlayingApplicationDidChange:(id)arg1 ;
@end

@interface UIApplication (musicapp)
+ (id)sharedApplication;
- (BOOL)launchApplicationWithIdentifier:(id)arg1 suspended:(BOOL)arg2;
@end

@interface UIImage (musicapp)
+ (id)_applicationIconImageForBundleIdentifier:(id)arg1 format:(int)arg2 scale:(double)arg3;
@end

@interface LSApplicationWorkspace : NSObject
+ (id)defaultWorkspace;
- (void)openApplicationWithBundleIdentifier:(id)arg1 configuration:(id)arg2 completionHandler:(/*^block*/id)arg3;
@end

@interface VolumeControl
+(id)sharedVolumeControl;
-(void)cancelVolumeEvent;
-(void)increaseVolume;
-(void)decreaseVolume;
-(void)toggleMute;
@end

