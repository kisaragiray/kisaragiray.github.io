#import "SceneKitView.h"
#import "XXRootViewController.h"
#import "HelpViewController.h"
#import "SettingViewController.h"
#import "DataSaveHelper.h"
#import <os/log.h>
#import <HBLog.h>
#import <LikeButton/LikeButton.h>

//#define W [UIScreen mainScreen].bounds.size.width
//#define H [UIScreen mainScreen].bounds.size.height

UITextField *tf;
UILabel *label;
DataSaveHelper *helper;

@implementation SceneKitView

- (void)viewDidLoad {
	[super viewDidLoad];

	self.view = [[UIView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];
	self.view.backgroundColor = [UIColor clearColor];

	[self initCAGLayer];
	[self initTF];
	[self initHelper];
	[self initLabel];
	[self initLikeButton];

}

- (void)initTF {
	tf = [[UITextField alloc] 
		initWithFrame:CGRectMake(W / 2 - 150, H - 100, 300, 30)];

	tf.borderStyle = UITextBorderStyleRoundedRect;
	tf.layer.borderWidth = 1.0f;    // 枠線の幅
	tf.layer.cornerRadius = 5.0f;   // 角の丸み
	tf.layer.shadowOpacity = 0.5f;  // 影の濃さ
	tf.layer.masksToBounds = NO;
	tf.textColor = [UIColor redColor];
	tf.placeholder = @"killall -9 SpringBoard";
	tf.keyboardType = UIKeyboardTypeDefault;
	[tf addTarget:self 
		action:@selector(hoge:) 
		forControlEvents:UIControlEventEditingDidEndOnExit];

	[self.view addSubview:tf];

	[NSNotificationCenter.defaultCenter 
		addObserver:self 
		selector:@selector(slideUpView:) 
		name:UIKeyboardWillShowNotification 
		object:nil];

	[NSNotificationCenter.defaultCenter 
		addObserver:self 
		selector:@selector(slideDownView:) 
		name:UIKeyboardWillHideNotification 
		object:nil];
}

- (void)hoge:(UITextField*)textfield{
	
}

- (void)initLabel {
	label = [[UILabel alloc] 
		initWithFrame:CGRectMake(
			0, 
			H / 8 - 15, 
			W, 
			30)];
	label.text = [NSString stringWithFormat:@"起動回数 : %ld 回", helper.howManyTimesAppLaunched];
	label.textAlignment = NSTextAlignmentCenter;

	label.textColor = [UIColor whiteColor];
	[label setFont:[UIFont boldSystemFontOfSize:25]];
	[self.view addSubview:label];
}

- (void)slideUpView:(NSNotification*)notification {
	HBLogDebug(@" = %@", label.text);

	os_log(OS_LOG_DEFAULT, "上にあがりました");

	AudioServicesPlaySystemSound(1003);

	tf.frame = CGRectMake(
		W / 2 - 150, 
		H / 2 + 80, 
		300, 
		30);
}

- (void)slideDownView:(NSNotification*)notification {
	tf.frame = CGRectMake(
		W / 2 - 150, 
		H - 100, 
		300, 
		30);
}

- (void)initHelper {
	helper = [DataSaveHelper new];
    
    if (helper.initialized) {
        NSLog(@"初回起動時の初期化は済んでいます");
    } else {
        helper.initialized = YES;
    }
    
    helper.howManyTimesAppLaunched ++;
    
    NSLog(@"%ld", helper.howManyTimesAppLaunched);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (tf.isFirstResponder) {
		//[tf resignFirstResponder];
		[self.view endEditing:YES];
	} else {
		[tf becomeFirstResponder];
	}
}

- (void)initCAGLayer {
	UIView* view = [[UIView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];

	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.frame = self.view.bounds;
	gradientLayer.colors = @[
		(id)RGBA(48.0, 35.0, 174.0, 1.0).CGColor, 
		(id)RGBA(200, 110, 215.0, 1.0).CGColor];

	/*gradientLayer.locations = @[
		@0, 
		@0.1, 
		@0.6, 
		@0.7, 
		@1];*/

	//gradientLayer.startPoint = CGPointMake(0, 0);
	//gradientLayer.endPoint = CGPointMake(1, 0);

	[view.layer insertSublayer:gradientLayer atIndex:0];
	[self.view addSubview:view];
}

- (void)initLikeButton {
    
	LikeButton * btn = [LikeButton buttonWithType:UIButtonTypeCustom];

	btn.frame = CGRectMake(100, 100, 30, 130);
	[self.view addSubview:btn];

	[btn setImage:[UIImage 
		imageNamed:@"dislike"] 
		forState:UIControlStateNormal];

	[btn setImage:[UIImage 
		imageNamed:@"liek_orange"] 
		forState:UIControlStateSelected];

	[btn addTarget:self 
		action:@selector(btnClick:) 
		forControlEvents:UIControlEventTouchUpInside];

}

- (void)btnClick:(UIButton *)button {
	if (!button.selected) {
		button.selected = !button.selected;
	} else {
		button.selected = !button.selected;
	}
}
@end