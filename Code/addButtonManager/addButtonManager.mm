#import "addButtonManager.h"

/*
	[[addButtonManager sharedInstance] 
		addButton:button 
		title:title 
		delegate:self 
		action:action 
		toItem:self.view 
		multiplierX:1.0f 
		constantX:0.0f 
		multiplierY:0.4f 
		constantY:0.0f];
*/

@interface addButtonManager()
- (id)init;
@end

@implementation addButtonManager

+ (id)sharedInstance {
	static addButtonManager* _instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [[addButtonManager alloc] init];
	});

	return _instance;
}

- (id)init {
	if (self = [super init]) {
	}
	return self;
}

- (void)addButton:(UIButton *)button 
	title:(NSString *)title 
	delegate:(id)delegate 
	action:(SEL)action 
	toItem:(id)target 
	multiplierX:(float)multiplierX 
	constantX:(float)constantX 
	multiplierY:(float)multiplierY 
	constantY:(float)constantY {

	button = [UIButton 
		buttonWithType:UIButtonTypeRoundedRect];

	[button setTranslatesAutoresizingMaskIntoConstraints:NO];

	[button setTitle:title 
		forState:UIControlStateNormal];

	[button sizeToFit];

	[button addTarget:delegate 
		action:action 
		forControlEvents:UIControlEventTouchUpInside];

	[target addSubview:button];

	//X軸(横方向)
	NSLayoutConstraint *buttonX = [NSLayoutConstraint 
		constraintWithItem:button 
		attribute:NSLayoutAttributeCenterX 
		relatedBy:NSLayoutRelationGreaterThanOrEqual 
		toItem:target 
		attribute:NSLayoutAttributeCenterX 
		multiplier:multiplierX 
		constant:constantX];

	//Y軸(縦方向)
	NSLayoutConstraint *buttonY = [NSLayoutConstraint 
		constraintWithItem:button 
		attribute:NSLayoutAttributeCenterY 
		relatedBy:NSLayoutRelationEqual 
		toItem:target 
		attribute:NSLayoutAttributeCenterY 
		multiplier:multiplierY 
		constant:constantY];

	[target addConstraints:@[buttonX, buttonY]];

}
@end