@import UIKit;
#include <dlfcn.h>
#import <libnotifications/libnotifications.h>
#import <JBBulletinManager/JBBulletinManager.h>
#import <notify.h>
#import <huptimeAlert.h>

@interface UIApplication (Undocumented)
- (void) launchApplicationWithIdentifier: (NSString*)identifier suspended: (BOOL)suspended;
@end

@interface PSUIPrefsListController : UIViewController
@end

@interface BackupController : NSObject
+ (id)sharedInstance;
- (id)init;
- (void)startBackup;
@end

UIBarButtonItem *btn;

int mainInt;
NSTimer *timer;
UIAlertController *alertController;

%hook BackupController
static BackupController *sharedInstance;

- (id)init {
	id original = %orig;
	sharedInstance = original;
	return original;
}

%new
+ (id)sharedInstance {
	return sharedInstance;
}
%end

%hook PSUIPrefsListController

- (void)viewDidLoad {
	%orig;

	btn = [[UIBarButtonItem alloc] 
		initWithTitle:@"🥺押すぜ🥺" 
		style:UIBarButtonItemStyleDone 
		target:self 
		action:@selector(tapbtn)];

	self.navigationItem.rightBarButtonItem = btn;

}

%new
- (void)tapbtn {
	UIAlertController *alert = [UIAlertController 
		alertControllerWithTitle:@"" 
		message:@"" 
		preferredStyle:UIAlertControllerStyleActionSheet];



	[alert addAction:[UIAlertAction 
		actionWithTitle:@"libnotifications通知テスト"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		void *handle = dlopen("/usr/lib/libnotifications.dylib", RTLD_LAZY);
		if (handle != NULL) {                                      

		NSString *uid = [[NSUUID UUID] UUIDString];

		[%c(CPNotification) 
			showAlertWithTitle:@"libnotifications" 
			message:@"libnotifications"
			userInfo:@{@"" : @""}
			badgeCount:0
			soundName:nil
			delay:0.1
			repeats:NO
			bundleId:@"com.mikiyan1978.alertapp"
			uuid:uid
			silent:NO];

		dlclose(handle);
		}

		}]];

	[alert addAction:[UIAlertAction 
		actionWithTitle:@"libbulletin通知テスト"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post("com.mikiyan1978.respaddpreflibbulletinnoti");
		}]];

	[alert addAction:[UIAlertAction 
		actionWithTitle:@"uptimeAlert"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		uptimeAlert(self);
		}]];

	[alert addAction:[UIAlertAction 
		actionWithTitle:@"タップテスト"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		dispatch_after(dispatch_time
			(DISPATCH_TIME_NOW, 
			(int64_t)(5.0 * NSEC_PER_SEC)), 
			dispatch_get_main_queue(), ^{

			[(BackupController *)[%c(BackupController) 
				sharedInstance] startBackup];

			});

		}]];

	[alert addAction:[UIAlertAction 
		actionWithTitle:@"バックグラウンド起動"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		[[UIApplication sharedApplication] 
			launchApplicationWithIdentifier:@"prefs:root=APPLE_ACCOUNT/ICLOUD_SERVICE/BACKUP" 
			suspended:YES];
		}]];

	//キャンセル
	[alert addAction:[UIAlertAction 
		actionWithTitle:@"Cancel"
		style:UIAlertActionStyleCancel 
		handler:nil]];

	[self presentViewController:alert 
		animated:YES 
		completion:nil];

}

%end