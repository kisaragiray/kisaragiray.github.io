#import <JBBulletinManager/JBBulletinManager.h>
#import <libnotifications/libnotifications.h>
#import <libpowercontroller/powercontroller.h>

@interface SBOrientationLockManager
+ (id)sharedInstance;
- (void)lock:(UIInterfaceOrientation)arg1;
- (BOOL)isUserLocked;
- (BOOL)isLocked;
- (void)lock;
- (void)unlock;
@end

