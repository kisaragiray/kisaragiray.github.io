@import UIKit;
#include <dlfcn.h>
#import <libnotifications/libnotifications.h>
#import <JBBulletinManager/JBBulletinManager.h>
#import <notify.h>
#import <huptimeAlert.h>

@interface PSUIPrefsListController : UIViewController
@end

UIBarButtonItem *btn;

int mainInt;
NSTimer *timer;
UIAlertController *alertController;

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
		actionWithTitle:@"iCloud Backup"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		notify_post("com.mikiyan1978.isBackup");
		}]];

	[alert addAction:[UIAlertAction 
		actionWithTitle:@""
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
		
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