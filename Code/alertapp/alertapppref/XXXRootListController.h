#import <Preferences/PSListController.h>

@interface XXXRootListController : PSListController {
	NSMutableDictionary *prefs;
	NSArray *directoryContent;
	SystemSoundID selectedSound;
}

@end
