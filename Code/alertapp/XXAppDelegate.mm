#import "XXAppDelegate.h"
#import "XXRootViewController.h"
#import "SettingViewController.h"
#import "HelpViewController.h"
#import <libpowercontroller/powercontroller.h>

UITabBarController *tbc;

@interface XXRootAppApplication : UIViewController
@end

@implementation XXAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	_rootViewController = [[XXRootViewController alloc] init];
	_window.rootViewController = _rootViewController;

	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_rootViewController];

	self.window.rootViewController = navigationController;
	
	[navigationController 
		setToolbarHidden:NO 
		animated:YES];

	/*tbc = [UITabBarController new];

	XXRootViewController  *XXVC  = [XXRootViewController new];
	SettingViewController  *sVC  = [SettingViewController new];
	HelpViewController  *hVC  = [HelpViewController new];

	XXVC.title = @"Home";
	sVC.title = @"設定";
	hVC.title = @"Help";

	[[UITabBarItem appearance] 
		setTitleTextAttributes:[NSDictionary 
		dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, nil] 
		forState:UIControlStateNormal];

	[[UITabBarItem appearance] 
		setTitlePositionAdjustment:UIOffsetMake(0, - 15)];

	tbc.viewControllers = [NSArray 
		arrayWithObjects:XXVC, sVC, hVC, nil];

	_window.rootViewController = tbc;
	[_window addSubview:tbc.view];*/
	[_window makeKeyAndVisible];

	[self ShortcutItem];
}

- (void)ShortcutItem {
    
	UIApplicationShortcutIcon *respringIcon = [UIApplicationShortcutIcon 
		iconWithTemplateImageName:@"Respring"];

	UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] 
		initWithType:@"Respring" 
		localizedTitle:@"PowerControllerApp" 
		localizedSubtitle:@"Respringします" 
		icon:respringIcon 
		userInfo:nil];

	UIApplicationShortcutIcon *safeIcon = [UIApplicationShortcutIcon 
		iconWithTemplateImageName:@"SafeMode"];

	UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] 
		initWithType:@"Safe" 
		localizedTitle:@"PowerControllerApp" 
		localizedSubtitle:@"Safe Mode" 
		icon:safeIcon 
		userInfo:nil];

	UIApplicationShortcutIcon *ldrestartIcon = [UIApplicationShortcutIcon 
		iconWithTemplateImageName:@"ldrestart"];

	UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] 
		initWithType:@"ldrestart" 
		localizedTitle:@"PowerControllerApp" 
		localizedSubtitle:@"ldrestart" 
		icon:ldrestartIcon 
		userInfo:nil];

	UIApplicationShortcutIcon *uicacheIcon = [UIApplicationShortcutIcon 
		iconWithTemplateImageName:@"uicache"];

	UIApplicationShortcutItem *item4 = [[UIApplicationShortcutItem alloc] 
		initWithType:@"uicache" 
		localizedTitle:@"PowerControllerApp" 
		localizedSubtitle:@"uicache" 
		icon:uicacheIcon 
		userInfo:nil];

	[[UIApplication sharedApplication] 
		setShortcutItems:@[item3, item4, item2, item1]];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {

	if ([shortcutItem.type isEqualToString:@"Respring"]) {
		notify_post(krespring);
	} 
	else if ([shortcutItem.type isEqualToString:@"Safe"]) {
		notify_post(ksafemode);
	} 
	else if ([shortcutItem.type isEqualToString:@"ldrestart"]) {
		notify_post(klibpowercontrollerldrestart);
	} 
	else if ([shortcutItem.type isEqualToString:@"uicache"]) {
		notify_post(kuicache);
		notify_post("com.mikiyan1978.alertapplibbulletinuicachenoti");
	}
}
@end
