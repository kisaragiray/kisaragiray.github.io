@interface MusicAppController : UIViewController
@property (nonatomic, retain) UIView *artworkContainerView;
@property (nonatomic, retain) UIImageView *artworkView;
@property (nonatomic, retain) UIImage *artworkImage;

@property (nonatomic, retain) CBAutoScrollLabel *nowPlayingInfoSong;
@property (nonatomic, retain) CBAutoScrollLabel *nowPlayingInfoArtist;
@property (nonatomic, retain) CBAutoScrollLabel *nowPlayingInfoAlbum;

@property (nonatomic, retain) UIImageView *pauseButton;
@property (nonatomic, retain) UIImageView *forwardButton;
@property (nonatomic, retain) UIImageView *backButton;
@end

@interface SBMediaController
+ (id)sharedInstance;
- (void)setNowPlayingInfo:(id)arg1;
- (BOOL)isPlaying;
@end
