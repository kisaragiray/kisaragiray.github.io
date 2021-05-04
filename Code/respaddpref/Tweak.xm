@import UIKit;
#include <dlfcn.h>
#import <libnotifications/libnotifications.h>
#import <JBBulletinManager/JBBulletinManager.h>
#import <notify.h>
#import <NSTask/NSTask.h>
#import <JGProgressHUD/JGProgressHUD.h>

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface UIApplication (Undocumented)
- (void) launchApplicationWithIdentifier: (NSString*)identifier suspended: (BOOL)suspended;
@end

@interface SBDisplayItem : NSObject
@property(nonatomic, copy, readonly)NSString* bundleIdentifier;
@end

@interface SBMainSwitcherViewController : UIViewController
+ (id)sharedInstance;
- (id)recentAppLayouts;
- (BOOL)deleteAppLayoutForDisplayItem:(id)arg1;
- (void)_removeAppLayout:(id)arg1 forReason:(long long)arg2;
- (void)_deleteAppLayout:(id)arg1 forReason:(long long)arg2;
- (void)_deleteAppLayoutsMatchingBundleIdentifier:(id)arg1;
@end

@interface SBAppLayout : NSObject
- (id)allItems;
- (BOOL)containsItemWithBundleIdentifier:(id)arg1;
@end

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
		actionWithTitle:@"HUD"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    HUD.indicatorView = [[JGProgressHUDRingIndicatorView alloc] init]; 
    HUD.progress = 0.5f;
    [HUD showInView:self.view];
    [HUD dismissAfterDelay:3.0];

		}]];

	[alert addAction:[UIAlertAction 
		actionWithTitle:@"killallapptest"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		SBMainSwitcherViewController* mainSwitcher = [%c(SBMainSwitcherViewController) sharedInstance];

		NSArray* items = [mainSwitcher recentAppLayouts];

		for (SBAppLayout* item in items)
			[mainSwitcher _removeAppLayout:item forReason:1];

		}]];

	[alert addAction:[UIAlertAction 
		actionWithTitle:@"バックグラウンド起動"
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {

		[[UIApplication sharedApplication] 
			launchApplicationWithIdentifier:@"jp.naver.line" 
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

