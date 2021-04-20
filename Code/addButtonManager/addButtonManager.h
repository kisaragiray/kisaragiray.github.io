@import UIKit;

@interface addButtonManager : NSObject
+ (id)sharedInstance;
- (void)addButton:(UIButton *)button 
	title:(NSString *)title 
	delegate:(id)delegate 
	action:(SEL)action 
	toItem:(id)target 
	multiplierX:(float)multiplierX 
	constantX:(float)constantX 
	multiplierY:(float)multiplierY 
	constantY:(float)constantY;
@end