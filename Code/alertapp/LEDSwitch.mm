#import "LEDSwitch.h"

@implementation LEDSwitch

- (void)initSwitch:(UIView *)target {

	UISwitch *sw = [[UISwitch alloc] 
		initWithFrame:CGRectZero];
	sw.translatesAutoresizingMaskIntoConstraints = NO;
	sw.on = NO;

	[sw addTarget:self 
		action:@selector(isOn:) 
		forControlEvents:UIControlEventValueChanged];

	[target addSubview:sw];

	NSLayoutConstraint *swX = [NSLayoutConstraint 
		constraintWithItem:sw 
		attribute:NSLayoutAttributeCenterX 
		relatedBy:NSLayoutRelationGreaterThanOrEqual 
		toItem:target 
		attribute:NSLayoutAttributeCenterX 
		multiplier:1.0f 
		constant:0.0f];

	NSLayoutConstraint *swY = [NSLayoutConstraint 
		constraintWithItem:sw 
		attribute:NSLayoutAttributeCenterY 
		relatedBy:NSLayoutRelationEqual 
		toItem:target 
		attribute:NSLayoutAttributeCenterY 
		multiplier:1.8f 
		constant:0.0f];

	[target addConstraints:@[swX, swY]];
}
@end