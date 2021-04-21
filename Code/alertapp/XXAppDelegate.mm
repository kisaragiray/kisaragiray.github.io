#import "XXAppDelegate.h"
#import "XXRootViewController.h"
#import "SettingViewController.h"
#import "HelpViewController.h"
#import <libpowercontroller/powercontroller.h>

/*@interface XXRootAppApplication : UIViewController
@end

@interface SettingViewController : UIViewController
@end

@interface HelpViewController : UIViewController
@end*/

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

	self.tabBarController = [UITabBarController new];

	XXRootViewController  *homeView  = [XXRootViewController new];
	SettingViewController  *settingView  = [SettingViewController new];
	HelpViewController  *helpView  = [HelpViewController new];

	homeView.title = @"Home";
	settingView.title = @"設定";
	helpView.title = @"Help";

	[[UITabBarItem appearance] 
		setTitleTextAttributes:[NSDictionary 
		dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, nil] 
		forState:UIControlStateNormal];

	[[UITabBarItem appearance] 
		setTitlePositionAdjustment:UIOffsetMake(0, 0)];

	NSArray *items = [NSArray 
		arrayWithObjects:
		settingView, 
		homeView, 
		helpView, nil];

	self.tabBarController.viewControllers = items;

	_window.rootViewController = self.tabBarController;
	[_window addSubview:self.tabBarController.view];
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
