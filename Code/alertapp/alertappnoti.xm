@import Foundation;
#include <dlfcn.h>
#import <objc/runtime.h>
#import <JBBulletinManager/JBBulletinManager.h>
#import <libnotifications/libnotifications.h>
#import <libpowercontroller/powercontroller.h>
#import <NSTask/NSTask.h>
#import <huptimeAlert.h>

NSString *soundPath = @"/System/Library/Audio/UISounds/tweet_sent.caf";

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

void alertapplibbulletinuicachenoti(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

	[[%c(JBBulletinManager) sharedInstance] 
		showBulletinWithTitle:@"libbulletin/uicache" 
		message:@"libbulletin/uicache完了しました" 
		bundleID:@"com.mikiyan1978.alertapp" 
		soundPath:soundPath];

}

void alertapplibbulletin14upnoti(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

	[[%c(JBBulletinManager) sharedInstance] 
		showBulletinWithTitle:@"libbulletin/iOS14以上" 
		message:@"libbulletin/iOS14以上です" 
		bundleID:@"com.mikiyan1978.alertapp"];

}

void alertapplibbulletin14downnoti(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

	[[%c(JBBulletinManager) sharedInstance] 
		showBulletinWithTitle:@"libbulletin/iOS14以下" 
		message:@"libbulletin/iOS14以下です" 
		bundleID:@"com.mikiyan1978.alertapp"];

}

static void alertappsbreload(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

	//uptimeAlert(self);
	NSTask* task = [NSTask new];
	[task setLaunchPath:@"/usr/bin/sbreload"];
	[task launch];
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

}

