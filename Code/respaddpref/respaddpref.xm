#import <Foundation/Foundation.h>
#include <dlfcn.h>
#import <objc/runtime.h>
#import <JBBulletinManager/JBBulletinManager.h>
#import <libnotifications/libnotifications.h>

@interface BackupController : UIApplication
- (void)startBackup;
@end

NSString *soundPath = @"/var/mobile/2021032923253005417ISB_002.mp3";

void respaddpreflibbulletinnoti(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

	[[%c(JBBulletinManager) sharedInstance] 
		showBulletinWithTitle:@"libbulletin" 
		message:@"libbulletin" 
		bundleID:@"com.mikiyan1978.alertapp"
		soundPath:soundPath];

}

static void isBackup(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	[(BackupController *)[%c(BackupController) 
			sharedApplication] startBackup];
}

%dtor {

	CFNotificationCenterRemoveObserver(
		CFNotificationCenterGetDarwinNotifyCenter(), 
		NULL, 
		CFSTR("com.mikiyan1978.respaddpreflibbulletinnoti"), 
		NULL);

	CFNotificationCenterRemoveObserver(
		CFNotificationCenterGetDarwinNotifyCenter(), 
		NULL, 
		CFSTR("com.mikiyan1978.isBackup"), 
		NULL);
}

%ctor {

	CFNotificationCenterAddObserver(
		CFNotificationCenterGetDarwinNotifyCenter(), 
		NULL, 
		(CFNotificationCallback)respaddpreflibbulletinnoti, 
		CFSTR("com.mikiyan1978.respaddpreflibbulletinnoti"), 
		NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);

	CFNotificationCenterAddObserver(
		CFNotificationCenterGetDarwinNotifyCenter(), 
		NULL, 
		(CFNotificationCallback)isBackup, 
		CFSTR("com.mikiyan1978.isBackup"), 
		NULL, 
	CFNotificationSuspensionBehaviorDeliverImmediately);
}

