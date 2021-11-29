#import "XXAppDelegate.h"
#import "XXRootViewController.h"
#import "SettingViewController.h"
#import "HelpViewController.h"
#import "SceneKitView.h"
#import "SystemSounds.h"
#import "MapViewController.h"
#import "TestviewController.h"
#import "StackViewController.h"


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

	_SystemSoundsview = [[UINavigationController alloc] 
		initWithRootViewController:[SystemSounds new]];
	_SystemSoundsview.tabBarItem.image=[UIImage imageNamed:@""];
	_SystemSoundsview.tabBarItem.title = @"SystemSounds";

	_settingView = [[UINavigationController alloc] initWithRootViewController:[SettingViewController new]];
	_settingView.tabBarItem.image=[UIImage imageNamed:@"setting.png"];
	_settingView.tabBarItem.title = @"設定";

	_SceneKitview = [[UINavigationController alloc] initWithRootViewController:[SceneKitView new]];
	_SceneKitview.tabBarItem.image=[UIImage imageNamed:@"Testview.png"];
	_SceneKitview.tabBarItem.title = @"Testview";

	_mapView = [[UINavigationController alloc] initWithRootViewController:[MapViewController new]];
	_mapView.tabBarItem.image=[UIImage imageNamed:@"mapView.png"];
	_mapView.tabBarItem.title = @"マップ";

	_testView = [[UINavigationController alloc] initWithRootViewController:[TestviewController new]];
	_testView.tabBarItem.image=[UIImage imageNamed:@""];
	_testView.tabBarItem.title = @"test";

	_stackView = [[UINavigationController alloc] initWithRootViewController:[StackViewController new]];
	_stackView.tabBarItem.image=[UIImage imageNamed:@""];
	_stackView.tabBarItem.title = @"stackView";

	[localViewControllersArray 
		addObject:_rootViewController];
	[localViewControllersArray addObject:_settingView];
	[localViewControllersArray addObject:_helpView];
	[localViewControllersArray addObject:_SceneKitview];
	[localViewControllersArray addObject:_SystemSoundsview];
	[localViewControllersArray addObject:_mapView];
	[localViewControllersArray addObject:_testView];
	[localViewControllersArray addObject:_stackView];

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

- (void)applicationWillResignActive:(UIApplication *)application {
    // バックグラウンドに入る前に呼び出されます。これは、データを保存するのに適した場所です。
    //このメソッドを呼び出した後、アプリケーションはUIApplicationWillResignActiveNotification通知も送信して、関心のあるオブジェクトに遷移に応答する機会を与えます。
	os_log(OS_LOG_DEFAULT, "もうすぐバックグラウンドに入るから、データ保存してね");
    // [self saveData];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
//ユーザーがホームボタンを押してアプリケーションを「終了」したときに呼び出されます。 （アプリは一時停止されます。）この方法を使用して、共有リソースの解放、ユーザーデータの保存、タイマーの無効化、およびアプリケーションが後で終了した場合に備えてアプリケーションを現在の状態に復元するのに十分なアプリケーション状態情報を保存します。
    
    //アプリケーションは、このメソッドを呼び出すのとほぼ同時にUIApplicationDidEnterBackgroundNotification通知を送信して、関心のあるオブジェクトに遷移に応答する機会を与えます。
	os_log(OS_LOG_DEFAULT, "バックグラウンドに入りました");
    // [self stopTimers];
}

@end
