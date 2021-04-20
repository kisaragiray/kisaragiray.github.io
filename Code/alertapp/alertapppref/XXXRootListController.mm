#include "XXXRootListController.h"
#import <libpowercontroller/powercontroller.h>
#import <kblurRespring.h>

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
	blurRespring(self, self.view, 3);
	//notify_post(kFancyRespring);
	//notify_post(krespring);
}
@end
