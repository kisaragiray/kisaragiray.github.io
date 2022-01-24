#import "XXAppDelegate.h"
#import "MusicAppController.h"

@implementation XXAppDelegate
- (void)applicationDidFinishLaunching:(UIApplication *)application {
	_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	_rootViewController = [[MusicAppController alloc] init];
	_window.rootViewController = _rootViewController;
	[_window makeKeyAndVisible];
	
	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"changeNowPlayingInfo" object:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}




//2回目以降の起動時に呼び出される(バックグラウンドにアプリがある場合)
- (void)applicationWillEnterForeground:(UIApplication *)application {
	
}
@end
