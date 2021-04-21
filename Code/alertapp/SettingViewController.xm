#import "XXRootViewController.h"
#import "HelpViewController.h"
#import "SettingViewController.h"

@implementation SettingViewController
 
- (void)loadView {
	[super loadView];
	self.view = [[UIView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];

	self.view.backgroundColor = [UIColor cyanColor];
}
@end