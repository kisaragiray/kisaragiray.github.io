#import "XXAppDelegate.h"
#import "MusicAppController.h"

@implementation XXAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	_rootViewController = [[MusicAppController alloc] init];
	_window.rootViewController = _rootViewController;
	[_window makeKeyAndVisible];
}

@end
