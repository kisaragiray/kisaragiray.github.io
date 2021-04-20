@import UIKit;

#define DispatchMainThread(block, ...) if(block) dispatch_async(dispatch_get_main_queue(), ^{ block(__VA_ARGS__); })

typedef void(^actionHandlerBlock)();

@interface addAlertManager : NSObject
+ (id)sharedInstance;
- (void)addAlert:(UIAlertController *)alert 
	preferredStyle:(UIAlertControllerStyle)preferredStyle 
	alertControllerWithTitle:(NSString *)alertControllerWithTitle 
	alertMessage:(NSString *)alertMessage 
	actionWithTitle:(NSString *)actionWithTitle 
	target:(id)target 
	actionHandler:(actionHandlerBlock)actionHandler;
@end