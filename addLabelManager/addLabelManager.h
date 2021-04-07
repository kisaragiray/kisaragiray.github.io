@import UIKit;
#import <Foundation/Foundation.h>

@interface addLabelManager : UILabel
+ (void)addLabel:(UILabel *)label 
	labelText:(NSString *)labelText 
	textColor:(UIColor *)textColor
	toItem:(id)toItemtarget 
	target:(UIView *)target 
	multiplierX:(float)multiplierX 
	constantX:(float)constantX 
	multiplierY:(float)multiplierY 
	constantY:(float)constantY;
@end