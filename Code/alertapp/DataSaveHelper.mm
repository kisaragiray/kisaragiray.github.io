#import "DataSaveHelper.h"

static NSString *const kKeyInitialized = @"initialized";
static NSString *const kKeyHowManyTimesAppLaunched = @"howManyTimesAppLaunched";

@implementation DataSaveHelper

- (BOOL)initialized {

	return [[NSUserDefaults standardUserDefaults] boolForKey:kKeyInitialized];

}

- (void)setInitialized:(BOOL)initialized {

	[[NSUserDefaults standardUserDefaults] setBool:initialized forKey:kKeyInitialized];

}

- (NSInteger)howManyTimesAppLaunched {

	return [[NSUserDefaults standardUserDefaults] integerForKey:kKeyHowManyTimesAppLaunched];

}

- (void)setHowManyTimesAppLaunched:(NSInteger)howManyTimesAppLaunched {

	[[NSUserDefaults standardUserDefaults] setInteger:howManyTimesAppLaunched forKey:kKeyHowManyTimesAppLaunched];

}
@end