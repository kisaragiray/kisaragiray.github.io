#import "MusicAppController.h"

@interface LXScrollingLyricsViewControllerPresenter: NSObject
- (void)present;
@end

SBApplication* nowPlayingApp = nil;
NSString *cachedSongName;
void SendNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef result) {
		
		if(result) {
			NSDictionary *dict = (__bridge NSDictionary *)result;
			NSString *title = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle];
			NSString *artist = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtist];
			NSString *album = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoAlbum];
			
			NSString  *albumName = [NSString stringWithFormat: @"Album : %@", album];
			
			//NSString *bundleId= [[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier];
			
			if(!title || [title isEqualToString:cachedSongName]) return;
			cachedSongName = title;
			
			NSString  *message = [NSString stringWithFormat: @"Song title : %@\nArtist : %@", title, artist];
			
			[[%c(JBBulletinManager) sharedInstance] showBulletinWithTitle:albumName message:message bundleID:[nowPlayingApp bundleIdentifier] hasSound:false soundID:0 vibrateMode:0 soundPath:@"" attachmentImage:nil overrideBundleImage:nil];
		}
	});
}

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

void openMusic(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	
	SBApplication *app = [[%c(SBMediaController) sharedInstance] nowPlayingApplication];
	
	[[%c(LSApplicationWorkspace) defaultWorkspace] openApplicationWithBundleIdentifier:app.bundleIdentifier configuration:nil completionHandler:nil];
	
	//NSString *nowPlayingID = [[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier];
	
	//[[UIApplication sharedApplication] launchApplicationWithIdentifier:nowPlayingID suspended:NO];
}

void togglePlayPause(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	[[%c(SBMediaController) sharedInstance] togglePlayPauseForEventSource:0];
}

void mute(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	
}

void loadEneko(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	
	@try {
		AudioServicesPlaySystemSound(1002);
	
		void *handle = dlopen("/Library/MobileSubstrate/DynamicLibraries/Eneko.dylib", RTLD_NOW | RTLD_GLOBAL);
		
		dlclose(handle);
	}
	
	@catch (NSException *exception) {
		
	}
}

void xxxxx(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	
}

%hook SBMediaController
- (void)setNowPlayingInfo:(id)arg1 {
	%orig;
	
	SendNotification(CFNotificationCenterGetDarwinNotifyCenter(), NULL, NULL, NULL, NULL);
	
	[NSDistributedNotificationCenter.defaultCenter postNotificationName:@"changeNowPlayingInfo" object:nil];
	
	notify_post("screenshot");
}

- (void)_setNowPlayingApplication:(id)arg1 { // get the current playing app
	%orig;
	nowPlayingApp = arg1;
}
%end


%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)showLyrics, CFSTR("showLyrics"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)openMusic, CFSTR("openMusic"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)togglePlayPause, CFSTR("togglePlayPause"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)mute, CFSTR("mute"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)SendNotification, CFSTR("SendNotification"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, loadEneko, CFSTR("loadEneko"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)xxxxx, CFSTR("xxxxx"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);

	
}