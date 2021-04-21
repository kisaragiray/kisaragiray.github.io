#define F #import <Foundation/Foundation.h>
#define DL #include <dlfcn.h> 
#define O #import <objc/runtime.h>
#define N #import <notify.h>

#define UMA_MUSUME [[%c(JBBulletinManager) sharedInstance] showBulletinWithTitle:@"libbulletin" message:@"libbulletin" bundleID:@"com.mikiyan1978.alertapp" soundPath:@"/System/Library/Audio/UISounds/tweet_sent.caf"];

#define ABC void respaddpreflibbulletinnoti(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {UMA_MUSUME}

#define D %dtor{CFNotificationCenterRemoveObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, CFSTR("com.mikiyan1978.respaddpreflibbulletinnoti"), NULL);}

#define C %ctor{CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)respaddpreflibbulletinnoti, CFSTR("com.mikiyan1978.respaddpreflibbulletinnoti"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);}