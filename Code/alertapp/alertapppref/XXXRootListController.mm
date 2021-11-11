#include "XXXRootListController.h"
#import <libpowercontroller/powercontroller.h>
#import <kblurRespring.h>
#import <AltList/AltList.h>

extern "C" void BKSTerminateApplicationForReasonAndReportWithDescription(NSString *bundleID, int reasonID, bool report, NSString *description);

#define KILL_APP BKSTerminateApplicationForReasonAndReportWithDescription(@"com.mikiyan1978.alertapp", 5, false, NULL);

@implementation XXXRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
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
