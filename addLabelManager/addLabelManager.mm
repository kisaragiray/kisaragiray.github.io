#import "addLabelManager.h"

/*
	[addLabelManager addLabel:label 
		labelText:labelText 
		textColor:[UIColor magentaColor] 
		toItem:toItemtarget 
		target:target  
		multiplierX:1.0f 
		constantX:0.0f 
		multiplierY:0.2f 
		constantY:0.0f];
*/

@implementation addLabelManager

+ (void)addLabel:(UILabel *)label 
	labelText:(NSString *)labelText 
	textColor:(UIColor *)textColor
	toItem:(id)toItemtarget 
	target:(UIView *)target 
	multiplierX:(float)multiplierX 
	constantX:(float)constantX 
	multiplierY:(float)multiplierY 
	constantY:(float)constantY {

	label = [UILabel new];
	label.text = labelText;
	[label setTranslatesAutoresizingMaskIntoConstraints:NO];
	label.lineBreakMode = NSLineBreakByWordWrapping;
	label.numberOfLines = 0;
	label.textAlignment = NSTextAlignmentCenter;
	label.textColor = textColor;
	[target addSubview:label];

	//X軸(横方向)
	NSLayoutConstraint *labelX = [NSLayoutConstraint 
		constraintWithItem:label 
		attribute:NSLayoutAttributeCenterX 
		relatedBy:NSLayoutRelationGreaterThanOrEqual 
		toItem:toItemtarget 
		attribute:NSLayoutAttributeCenterX 
		multiplier:multiplierX 
		constant:constantX];

	//Y軸(縦方向)
	NSLayoutConstraint *labelY = [NSLayoutConstraint 
		constraintWithItem:label 
		attribute:NSLayoutAttributeCenterY 
		relatedBy:NSLayoutRelationEqual 
		toItem:toItemtarget 
		attribute:NSLayoutAttributeCenterY 
		multiplier:multiplierY 
		constant:constantY];

	[target addConstraints:@[labelX, labelY]];

}
@end