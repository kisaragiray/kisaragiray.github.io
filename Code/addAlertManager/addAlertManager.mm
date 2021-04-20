#import "addAlertManager.h"

/*
	[[addAlertManager sharedInstance] 
		addAlert:alert 
		preferredStyle:preferredStyle 
		alertControllerWithTitle:alertControllerWithTitle 
		alertMessage:alertMessage 
		actionWithTitle:actionWithTitle 
		target:target 
		actionHandler:^(){
		//コード
	}];
*/

@interface addAlertManager()
- (id)init;
@end

@implementation addAlertManager

+ (id)sharedInstance {
	static addAlertManager* _instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [addAlertManager new];
	});

	return _instance;
}

- (id)init {
	if (self = [super init]) {
	}
	return self;
}

- (void)addAlert:(UIAlertController *)alert 
	preferredStyle:(UIAlertControllerStyle)preferredStyle 
	alertControllerWithTitle:(NSString *)alertControllerWithTitle 
	alertMessage:(NSString *)alertMessage 
	actionWithTitle:(NSString *)actionWithTitle 
	target:(id)target 
	actionHandler:(actionHandlerBlock)actionHandler {

	alert = [UIAlertController 
		alertControllerWithTitle:alertControllerWithTitle 
		message:alertMessage 
		preferredStyle:preferredStyle];

	[alert addAction:[UIAlertAction 
		actionWithTitle:actionWithTitle
		style:UIAlertActionStyleDefault 
		handler:^(UIAlertAction *action) {
			DispatchMainThread(^(){actionHandler();});
		}]];

	[alert addAction:[UIAlertAction 
		actionWithTitle:@"キャンセル" 
		style:UIAlertActionStyleCancel 
		handler:nil]];

	[target presentViewController:alert 
		animated:YES 
		completion:nil];
}
@end