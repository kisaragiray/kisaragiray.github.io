#import <JBBulletinManager/JBBulletinManager.h>
#import <libnotifications/libnotifications.h>
#import <libpowercontroller/powercontroller.h>
 
@interface alertappnoti : NSObject
@end

@interface SBOrientationLockManager
+ (id)sharedInstance;
- (void)lock:(UIInterfaceOrientation)arg1;
- (BOOL)isUserLocked;
- (BOOL)isLocked;
- (void)lock;
- (void)unlock;
@end

@interface SBHomeHardwareButton
- (_Bool)emulateHomeButtonEventsIfNeeded:(struct __IOHIDEvent *)arg1;
@end

@interface UIApplication (Z)
@property(readonly, nonatomic) SBHomeHardwareButton *homeHardwareButton;
@end












