#import "XXRootViewController.h"
#import "HelpViewController.h"
#import "SettingViewController.h"
@import UIKit;

WKWebView *wkWebView;

/*[[UIApplication sharedApplication] 
		openURL:[NSURL URLWithString:@"cydia://url/https://cydia.saurik.com/api/share#?source=https://kisaragiray.github.io/repo/"] 
		options:@{} 
		completionHandler:nil];*/

@implementation HelpViewController
 
- (void)loadView {
	[super loadView];
	self.view = [[UIView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];
	self.view.backgroundColor = [UIColor cyanColor];

	[self initStackView];
}
/////////////////////////////////////////////////////////////////////////
	//NSLayoutAttributeTop
	//NSLayoutAttributeLeft
	//NSLayoutAttributeRight
	//NSLayoutAttributeBottom
	//NSLayoutAttributeLeading
	//NSLayoutAttributeTrailing
	//NSLayoutAttributeWidth
	//NSLayoutAttributeHeight
	//NSLayoutAttributeCenterX
	//NSLayoutAttributeCenterY

	//UILayoutConstraintAxisVertical
	//UILayoutConstraintAxisHorizontal
/////////////////////////////////////////////////////////////////////////
- (void)initStackView {

	/*UIView *mainView = [[UIView alloc] 
		initWithFrame:CGRectMake(
			0, 30, 
			W, 60)];*/
	UIView *mainView = [[UIView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];
	mainView.backgroundColor = [UIColor whiteColor];
	mainView.layer.cornerRadius = 25.5;
	[self.view addSubview:mainView];


	//view 1
	UIView *view1 = [UIView new];
	view1.backgroundColor = [UIColor cyanColor];
	[view1.heightAnchor 
		constraintEqualToConstant:35].active = true;
	[view1.widthAnchor 
		constraintEqualToConstant:35].active = true;
	view1.layer.cornerRadius = 17.5;
	view1.tag = 1;
	view1.userInteractionEnabled = YES;

	//View 2
	UIView *view2 = [UIView new];
	view2.backgroundColor = [UIColor cyanColor];
	[view2.heightAnchor 
		constraintEqualToConstant:35].active = true;
	[view2.widthAnchor 
		constraintEqualToConstant:35].active = true;
	view2.layer.cornerRadius = 17.5;

	//View 3
	UIView *view3 = [UIView new];
	view3.backgroundColor = [UIColor cyanColor];
	[view3.heightAnchor 
		constraintEqualToConstant:35].active = true;
	[view3.widthAnchor 
		constraintEqualToConstant:35].active = true;
	view3.layer.cornerRadius = 17.5;

	//Stack View
	UIStackView *stackView = [UIStackView new];
	stackView.axis = UILayoutConstraintAxisHorizontal;
	stackView.distribution = UIStackViewDistributionEqualSpacing;
	stackView.alignment = UIStackViewAlignmentCenter;
	stackView.spacing = 120;
	[stackView addArrangedSubview:view1];
	[stackView addArrangedSubview:view2];
	[stackView addArrangedSubview:view3];
	stackView.translatesAutoresizingMaskIntoConstraints = false;
	[mainView addSubview:stackView];


	//Layout for Stack View
	[stackView.centerXAnchor constraintEqualToAnchor:mainView.centerXAnchor].active = true;
	[stackView.centerYAnchor constraintEqualToAnchor:mainView.centerYAnchor].active = true;
}
 
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

	UITouch *touch = [touches anyObject];
	switch (touch.view.tag) {
		case 1:

		[[UIApplication sharedApplication] 
			openURL:[NSURL URLWithString:@"cydia://url/https://cydia.saurik.com/api/share#?source=https://kisaragiray.github.io/repo/"] 
			options:@{} 
			completionHandler:nil];

			break;
		case 2:
			
			break;
		case 3:
			
			break;
		default:
			break;
	}
}
@end