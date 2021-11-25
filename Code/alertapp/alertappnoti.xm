#import "alertappnoti.h"

extern "C" {
	typedef uint32_t IOHIDEventOptionBits;

	typedef struct __IOHIDEvent *IOHIDEventRef;
//	typedef CFTypeRef IOHIDEventRef;

	IOHIDEventRef IOHIDEventCreateKeyboardEvent(
		CFAllocatorRef allocator, 
		AbsoluteTime timeStamp, 
		uint16_t usagePage, 
		uint16_t usage, 
		Boolean down, 
		IOHIDEventOptionBits flags);
}

//libnotifications
void alertapplibnotificationsuicachenoti(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

	void *handle = dlopen("/usr/lib/libnotifications.dylib", RTLD_LAZY);
	if (handle != NULL) {                                      

	NSString *uid = [[NSUUID UUID] UUIDString];

	[%c(CPNotification) showAlertWithTitle:@"libnotifications/通知テスト" 
		message:@"libnotifications/通知テスト"
		userInfo:@{@"userInfo" : @"libnotifications"}
		badgeCount:0
		soundName:nil
		delay:1.00
		repeats:NO
		bundleId:@"com.mikiyan1978.alertapp"
		uuid:uid
		silent:NO];

		dlclose(handle);
	}

}

//uicache通知
NSString *soundPath = @"/System/Library/Audio/UISounds/tweet_sent.caf";

void alertapplibbulletinuicachenoti(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

	[[%c(JBBulletinManager) sharedInstance] 
		showBulletinWithTitle:@"libbulletin/uicache" 
		message:@"libbulletin/uicache完了しました" 
		bundleID:@"com.mikiyan1978.alertapp" 
		soundPath:soundPath];

}

//iOS14通知
void alertapplibbulletin14upnoti(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

	[[%c(JBBulletinManager) sharedInstance] 
		showBulletinWithTitle:@"libbulletin/iOS14以上" 
		message:@"libbulletin/iOS14以上です" 
		bundleID:@"com.mikiyan1978.alertapp"];

}

//iOS14通知
void alertapplibbulletin14downnoti(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

	[[%c(JBBulletinManager) sharedInstance] 
		showBulletinWithTitle:@"libbulletin/iOS14以下" 
		message:@"libbulletin/iOS14以下です" 
		bundleID:@"com.mikiyan1978.alertapp"];

}

//sbreload
static void alertappsbreload(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSTask* task = [NSTask new];
	[task setLaunchPath:@"/usr/bin/sbreload"];
	[task launch];
}

//sbreload
static void sbreload(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSTask *task = [NSTask new];
	[task setLaunchPath:@"/bin/sh"];
	[task setArguments:[NSArray arrayWithObjects:
		@"-c", 
		@"sbreload", nil]];
	[task launch];
}

//起動通知
static void activeNoti(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	[[%c(JBBulletinManager) sharedInstance] 
		showBulletinWithTitle:@"ApplicationDidBecomeActive" 
		message:@"アプリが起動しました" 
		bundleID:@"com.mikiyan1978.alertapp"];
}

//閉じられた通知
static void noActiveNoti(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	[[%c(JBBulletinManager) sharedInstance] 
		showBulletinWithTitle:@"ApplicationWillResignActive" 
		message:@"アプリが閉じられました" 
		bundleID:@"com.mikiyan1978.alertapp"];
}

//userspace reboot
static void rebootUserspace(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSTask *task = [NSTask new];
	[task setLaunchPath:@"/bin/sh"];
	[task setArguments:[NSArray arrayWithObjects:
		@"-c", 
		@"launchctl reboot userspace", nil]];
	[task launch];
}


//スクショ
static void takeScreenshot(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	[[%c(SpringBoard) sharedApplication] takeScreenshot];
}

//画面回転lock
void lock(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	[[%c(SBOrientationLockManager) sharedInstance] lock];
}

//画面回転unlock
void unlock(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	[[%c(SBOrientationLockManager) sharedInstance] unlock];
}

//画面回転
void lockandunlock(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

	if ([[%c(SBOrientationLockManager) sharedInstance] isUserLocked]) {
		[[%c(SBOrientationLockManager) sharedInstance] unlock];
	} else {
		[[%c(SBOrientationLockManager) sharedInstance] lock];
	}
}

//kMRNextTrack
void kNextTrack(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	MRMediaRemoteSendCommand(kMRNextTrack, nil);
}

//kMRPreviousTrack
void kPreviousTrack(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	MRMediaRemoteSendCommand(kMRPreviousTrack, nil);
}

//Home Button Click
void khomebutton(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

	uint64_t abTime = mach_absolute_time();

	IOHIDEventRef event = IOHIDEventCreateKeyboardEvent(
		kCFAllocatorDefault, 
		*(AbsoluteTime *)&abTime, 
		0xC, 0x40, YES, 0);

	[[[UIApplication sharedApplication] homeHardwareButton] emulateHomeButtonEventsIfNeeded:event];

	CFRelease(event);
}

//xxxxxxxxxx
void xxx(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	
}

%dtor {

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.alertapplibnotificationsuicachenoti"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.alertapplibbulletinuicachenoti"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.alertapplibbulletin14upnoti"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.alertapplibbulletin14downnoti"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.alertappsbreload"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.activenoti"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.noactivenoti"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.rebootUserspace"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.sbreload"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.takeScreenshot"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.lock"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.unlock"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.lockandunlock"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.kNextTrack"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.kPreviousTrack"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.khomebutton"), NULL);

	CFNotificationCenterRemoveObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
	CFSTR("com.mikiyan1978.xxx"), NULL);

}



%ctor {

	//uicache完了
	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		(CFNotificationCallback)alertapplibnotificationsuicachenoti, 
		CFSTR("com.mikiyan1978.alertapplibnotificationsuicachenoti"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);

	//libbulletin
	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		(CFNotificationCallback)alertapplibbulletinuicachenoti, 
		CFSTR("com.mikiyan1978.alertapplibbulletinuicachenoti"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);


	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		(CFNotificationCallback)alertapplibbulletin14upnoti, 
		CFSTR("com.mikiyan1978.alertapplibbulletin14upnoti"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);


	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		(CFNotificationCallback)alertapplibbulletin14downnoti, 
		CFSTR("com.mikiyan1978.alertapplibbulletin14downnoti"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);


	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		alertappsbreload, 
		CFSTR("com.mikiyan1978.alertappsbreload"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);


	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		activeNoti, 
		CFSTR("com.mikiyan1978.activenoti"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);


	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		noActiveNoti, 
		CFSTR("com.mikiyan1978.noactivenoti"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);


	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		rebootUserspace, 
		CFSTR("com.mikiyan1978.rebootUserspace"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);


	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		sbreload, 
		CFSTR("com.mikiyan1978.sbreload"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);


	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		takeScreenshot, 
		CFSTR("com.mikiyan1978.takeScreenshot"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);

	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		lock, 
		CFSTR("com.mikiyan1978.lock"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);

	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		unlock, 
		CFSTR("com.mikiyan1978.unlock"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);


	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		lockandunlock, 
		CFSTR("com.mikiyan1978.lockandunlock"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);

	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		kNextTrack, 
		CFSTR("com.mikiyan1978.kNextTrack"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);

	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		kPreviousTrack, 
		CFSTR("com.mikiyan1978.kPreviousTrack"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);

	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		khomebutton, 
		CFSTR("com.mikiyan1978.khomebutton"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);


	CFNotificationCenterAddObserver(
	CFNotificationCenterGetDarwinNotifyCenter(), NULL, 
		xxx, 
		CFSTR("com.mikiyan1978.xxx"), NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);
}

