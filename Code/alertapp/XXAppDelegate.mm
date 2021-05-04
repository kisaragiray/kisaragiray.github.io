#import "XXAppDelegate.h"
#import "XXRootViewController.h"
#import "SettingViewController.h"
#import "HelpViewController.h"
#import "SceneKitView.h"
#import <libpowercontroller/powercontroller.h>

/*@interface XXRootAppApplication : UIViewController
@end

@interface SettingViewController : UIViewController
@end

@interface HelpViewController : UIViewController
@end*/

@implementation XXAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	UITabBarController *tabBars = [UITabBarController new];
	NSMutableArray *localViewControllersArray = [[NSMutableArray alloc] initWithCapacity:1];

	_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	_rootViewController = [[UINavigationController alloc] initWithRootViewController:[[XXRootViewController alloc] init]];

	_rootViewController.tabBarItem.image=[UIImage imageNamed:@"home.png"];
	_rootViewController.tabBarItem.title = @"HOME";

	_helpView = [[UINavigationController alloc] initWithRootViewController:[HelpViewController new]];
	_helpView.tabBarItem.image=[UIImage imageNamed:@"help.png"];
    _helpView.tabBarItem.title = @"HELP";

	//_settingView = [[UINavigationController alloc] initWithRootViewController:[SettingViewController new]];
	//_settingView.tabBarItem.image=[UIImage imageNamed:@"settings.png"];
	//_settingView.tabBarItem.title = @"設定";

	//_SceneKitview = [[UINavigationController alloc] initWithRootViewController:[SceneKitView new]];
	//_SceneKitview.tabBarItem.image=[UIImage imageNamed:@"SceneKitview.png"];
	//_SceneKitview.tabBarItem.title = @"SceneKitview";


	[localViewControllersArray 
		addObject:_rootViewController];

	//[localViewControllersArray addObject:_settingView];
	//[localViewControllersArray addObject:_SceneKitview];
	[localViewControllersArray addObject:_helpView];

	tabBars.viewControllers = localViewControllersArray;
	tabBars.view.autoresizingMask=(UIViewAutoresizingFlexibleHeight);    

	_window.rootViewController = tabBars;
	[_window makeKeyAndVisible];
}

- (void)ShortcutItem {
    
	UIApplicationShortcutIcon *respringIcon = [UIApplicationShortcutIcon 
		iconWithTemplateImageName:@"Respring"];

	UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] 
		initWithType:@"Respring" 
		localizedTitle:@"PowerControllerApp" 
		localizedSubtitle:@"Respring" 
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

- (void)initNotic {

	[[NSNotificationCenter defaultCenter] 
		addObserver:self 
		selector:@selector(applicationDidBecomeActive) 
		name:UIApplicationDidBecomeActiveNotification 
		object:nil];

	[[NSNotificationCenter defaultCenter] 
		addObserver:self 
		selector:@selector(applicationWillResignActive) 
		name:UIApplicationWillResignActiveNotification 
		object:nil];
}

- (void)applicationDidBecomeActive {
	// Activeになった時の処理.
	notify_post("com.mikiyan1978.activenoti");
}

- (void)applicationWillResignActive {
	// Activeでなくなる時の処理.
	notify_post("com.mikiyan1978.noactivenoti");
}


@end
