#import "XXAppDelegate.h"
#import "XXRootViewController.h"

@interface XXRootAppApplication : UIApplication
@end

@implementation XXAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	_rootViewController = [[XXRootViewController alloc] init];
	_window.rootViewController = _rootViewController;
	[_window makeKeyAndVisible];
}

/*
- (void)dealloc {
	[_window release];
	[_rootViewController release];
	[super dealloc];
}
*/
@end
