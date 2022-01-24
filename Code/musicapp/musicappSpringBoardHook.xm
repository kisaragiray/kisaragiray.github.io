@interface SBMediaController
+ (id)sharedInstance;
- (void)setNowPlayingInfo:(id)arg1;
- (BOOL)isPlaying;
@end

@interface LXScrollingLyricsViewControllerPresenter: NSObject
- (void)present;
@end

static void ShowMessage(NSString *title, NSString *message) {
	UIWindow *currentAlertWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	currentAlertWindow.windowLevel = UIWindowLevelAlert + 13;
	
	currentAlertWindow.rootViewController = [UIViewController new];
	
	UIAlertController *currentAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
		currentAlertWindow.hidden = YES;
	}];
	
	[currentAlert addAction:cancel];
	[currentAlertWindow makeKeyAndVisible];
	[currentAlertWindow.rootViewController presentViewController:currentAlert animated:YES completion:nil];
}

void showLyrics(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
		if (dlopen("/Library/MobileSubstrate/DynamicLibraries/LyricationFloatingOverlay.dylib", RTLD_LAZY)) {
		LXScrollingLyricsViewControllerPresenter *lyrics = [[%c(LXScrollingLyricsViewControllerPresenter) alloc] init];
		if (lyrics) {
			[lyrics present];
		}
	} else {
		ShowMessage(@"Lyricationが未インストール", @"Lyricationがインストールされていません。repo.basepack.coからインストールしてください");
	}
}

void xxxxx(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	
}

%hook SBMediaController
- (void)setNowPlayingInfo:(id)arg1 {
	%orig;
	
	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"changeNowPlayingInfo" object:nil];
}
%end

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)showLyrics, CFSTR("showLyrics"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)xxxxx, CFSTR("xxxxx"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	

}