#import "SceneKitView.h"
#import "XXRootViewController.h"
#import "HelpViewController.h"
#import "SettingViewController.h"
#import "DataSaveHelper.h"
#import <os/log.h>
#import <HBLog.h>

//#define W [UIScreen mainScreen].bounds.size.width
//#define H [UIScreen mainScreen].bounds.size.height

UITextField *tf;
UILabel *label;
DataSaveHelper *helper;

@implementation SceneKitView

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initHelper];
	self.view = [[UIView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];
	self.view.backgroundColor = [UIColor cyanColor];

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
	[self initLabel];

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
		initWithFrame:CGRectMake(0, H / 6, W, 30)];
	label.text = [NSString stringWithFormat:@"起動回数 : %ld 回", helper.howManyTimesAppLaunched];
	label.textAlignment = NSTextAlignmentCenter;

	label.textColor = [UIColor redColor];
	[label setFont:[UIFont boldSystemFontOfSize:30]];
	[self.view addSubview:label];
}

- (void)slideUpView:(NSNotification*)notification {
	HBLogDebug(@" = %@", label.text);

	os_log(OS_LOG_DEFAULT, "上にあがりました❗️");

	AudioServicesPlaySystemSound(1003);

	tf.frame = CGRectMake(W / 2 - 150, H / 2 + 100, 300, 30);
}

- (void)slideDownView:(NSNotification*)notification {
	tf.frame = CGRectMake(W / 2 - 150, H - 100, 300, 30);
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
@end