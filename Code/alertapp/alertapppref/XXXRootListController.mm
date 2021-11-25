#include "XXXRootListController.h"
#import <libpowercontroller/powercontroller.h>
#import <kblurRespring.h>
#import <AltList/AltList.h>

extern "C" void BKSTerminateApplicationForReasonAndReportWithDescription(NSString *bundleID, int reasonID, bool report, NSString *description);

#define KILL_APP BKSTerminateApplicationForReasonAndReportWithDescription(@"com.mikiyan1978.alertapp", 5, false, NULL);

@implementation XXXRootListController

- (NSArray *)specifiers {

	directoryContent = [[NSFileManager defaultManager] 
		contentsOfDirectoryAtPath:@"/var/mobile/Library/Preferences/MusicVideo/" 
		error:NULL];

	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}
	return _specifiers;
	[self apply];
}

- (void)previewAndSet:(id)value forSpecifier:(id)specifier{
	AudioServicesDisposeSystemSoundID(selectedSound);

	AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[NSString stringWithFormat:@"/var/mobile/Library/Preferences/MusicVideo/%@", value]], &selectedSound);

	AudioServicesPlaySystemSound(selectedSound);
    
	[super setPreferenceValue:value specifier:specifier];
}

- (NSArray *)getValues:(id)target{
	NSMutableArray *listing = [NSMutableArray arrayWithObjects:@"None", nil];

	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension != ''"];

	for (NSURL *fileURL in [directoryContent filteredArrayUsingPredicate:predicate]) {
		[listing addObject:fileURL];
	}
	return listing;
}


- (void)_returnKeyPressed:(id)arg1 {
	[self.view endEditing:YES];
	[self apply];
}

/*
- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	[super setPreferenceValue:value specifier:specifier];
	[self.view endEditing:YES];

}
*/

- (void)apply {
	KILL_APP
}
@end
