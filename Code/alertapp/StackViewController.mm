#import "StackViewController.h"

UIView *mainView;

//-Wunused-functionエラー無視
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
static inline UIWindow *currentWindow() {
    UIWindow* window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.firstObject;
                break;
            }
        }
    } else {
//-Wdeprecated-declarationsエラー無視
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        window = [UIApplication sharedApplication].keyWindow;
#pragma clang diagnostic pop
    }
    return window;
}
#pragma clang diagnostic pop

@implementation StackViewController

- (void)loadView { // 1番初めに呼ばれる
	self.view = [[UIView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];
	self.view.backgroundColor = [UIColor cyanColor];
}

- (void)viewDidLoad { // loadViewの次に呼ばれ、一度だけ生成される

	//UIStackView
	[self initStackView];

	//AutoLayout
	[self initSampleView];
//	[self fadeOut:self.sampleView];
//	[self fadeOut:self.sampleView2];

}

- (void)viewDidAppear:(BOOL)animated {
	[NSNotificationCenter.defaultCenter 
		addObserver:self 
		selector:@selector(orientationAction:) 
		name:UIDeviceOrientationDidChangeNotification 
		object:nil];
}

- (void)orientationAction:(NSNotification *)notification {
	[mainView removeFromSuperview];
	[self initStackView];
}


//UIStackView
- (void)initStackView {
	mainView = [[UIView alloc] 
		initWithFrame:CGRectMake(
			0, 
			H / 6, 
			W, //wide
			100 //height
		)];

	mainView.backgroundColor = [UIColor clearColor];
	mainView.layer.cornerRadius = 20.0;
	[self.view addSubview:mainView];

	//view 1
	UIView *view1 = [UIView new];
	view1.backgroundColor = [UIColor redColor];
	view1.layer.cornerRadius = 7.5;
	[view1.heightAnchor 
		constraintEqualToConstant:15].active = true;
	[view1.widthAnchor 
		constraintEqualToConstant:W - 30].active = true;

	//View 2
	UIView *view2 = [UIView new];
	view2.backgroundColor = [UIColor blueColor];
	view2.layer.cornerRadius = 7.5;
	[view2.heightAnchor 
		constraintEqualToConstant:15].active = true;
	[view2.widthAnchor 
		constraintEqualToConstant:W - 30].active = true;

	//View 3
	UIView *view3 = [UIView new];
	view3.backgroundColor = [UIColor blackColor];
	view3.layer.cornerRadius = 7.5;
	[view3.heightAnchor 
		constraintEqualToConstant:15].active = true;
	[view3.widthAnchor 
		constraintEqualToConstant:W - 30].active = true;

	//Stack View
	UIStackView *stackView = [UIStackView new];
	stackView.axis = UILayoutConstraintAxisVertical;
	stackView.distribution = UIStackViewDistributionEqualSpacing;
	stackView.alignment = UIStackViewAlignmentCenter;
	stackView.spacing = 15;
	[stackView addArrangedSubview:view1];
	[stackView addArrangedSubview:view2];
	[stackView addArrangedSubview:view3];
	stackView.translatesAutoresizingMaskIntoConstraints = false;
	[mainView addSubview:stackView];

	//Layout for Stack View
	[stackView.centerXAnchor constraintEqualToAnchor:mainView.centerXAnchor].active = true;
	[stackView.centerYAnchor constraintEqualToAnchor:mainView.centerYAnchor].active = true;
}



//AutoLayout
- (void)initSampleView {
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
/////////////////////////////////////////////////////////////////////////
	self.sampleView = [UIView new];
	self.sampleView2 = [UIView new];

	self.sampleView.translatesAutoresizingMaskIntoConstraints = NO;
	self.sampleView2.translatesAutoresizingMaskIntoConstraints = NO;

	self.sampleView.backgroundColor = RGBA(255, 0, 0, 1.0);
	self.sampleView.layer.cornerRadius = 75.0;
//	self.sampleView.layer.cornerRadius = self.sampleView.frame.size.width * 0.5;
	[self.view addSubview:self.sampleView];

	self.sampleView2.backgroundColor = RGBA(0, 0, 255, 1.0);
	self.sampleView2.layer.cornerRadius = 75.0;
//	self.sampleView2.layer.cornerRadius = self.sampleView2.frame.size.width * 0.5;
	[self.view addSubview:self.sampleView2];


//	[self.sampleView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
	[self.sampleView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = true;

//	[self.sampleView2.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
	[self.sampleView2.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = true;

	//必ずaddSubviewしてから
	NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:1.0];

	//高さ
	[array addObject:[NSLayoutConstraint 
		constraintWithItem:self.sampleView 
		attribute:NSLayoutAttributeHeight 
		relatedBy:NSLayoutRelationEqual 
		toItem:nil 
		attribute:NSLayoutAttributeHeight 
		multiplier:1.0 
		constant:150.0]];

	//幅
	[array addObject:[NSLayoutConstraint 
		constraintWithItem:self.sampleView 
		attribute:NSLayoutAttributeWidth 
		relatedBy:NSLayoutRelationEqual 
		toItem:nil 
		attribute:NSLayoutAttributeWidth 
		multiplier:1.0 
		constant:150.0]];

	//左
	[array addObject:[NSLayoutConstraint 
		constraintWithItem:self.sampleView 
		attribute:NSLayoutAttributeLeading 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeLeading 
		multiplier:1.0 
		constant:10.0]];

/*	//下から
	[array addObject:[NSLayoutConstraint 
		constraintWithItem:self.sampleView 
		attribute:NSLayoutAttributeBottom 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeBottom 
		multiplier:1.0 
		constant:- 200.0]];*/


	//高さ
	[array addObject:[NSLayoutConstraint 
		constraintWithItem:self.sampleView2 
		attribute:NSLayoutAttributeHeight 
		relatedBy:NSLayoutRelationEqual 
		toItem:nil 
		attribute:NSLayoutAttributeHeight 
		multiplier:1.0 
		constant:150.0]];

	//幅
	[array addObject:[NSLayoutConstraint 
		constraintWithItem:self.sampleView2 
		attribute:NSLayoutAttributeWidth 
		relatedBy:NSLayoutRelationEqual 
		toItem:nil 
		attribute:NSLayoutAttributeWidth 
		multiplier:1.0 
		constant:150.0]];

	//右
	[array addObject:[NSLayoutConstraint 
		constraintWithItem:self.sampleView2 
		attribute:NSLayoutAttributeTrailing 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeTrailing 
		multiplier:1.0 
		constant:- 10.0]];

/*	//下から
	[array addObject:[NSLayoutConstraint 
		constraintWithItem:self.sampleView2 
		attribute:NSLayoutAttributeBottom 
		relatedBy:NSLayoutRelationEqual 
		toItem:self.view 
		attribute:NSLayoutAttributeBottom 
		multiplier:1.0 
		constant:- 200.0]];*/

	[self.view addConstraints:array];
}

- (void)fadeOut:(UIView *)target {
	[UIView animateWithDuration:0.1f 
		delay:0.0 
		options:UIViewAnimationOptionCurveEaseIn 
		animations:^{
			//self.sampleView.backgroundColor = RandomColor;
			target.alpha = 0.0;
	} completion:^(BOOL finished) {
		[self fadeIn:target];
	}];
}

- (void)fadeIn:(UIView *)target {
	[UIView animateWithDuration:0.1f 
		delay:0.0 
		options:UIViewAnimationOptionCurveEaseIn 
		animations:^{
			//self.sampleView.backgroundColor = RandomColor;
			target.alpha = 1.0;
	} completion:^(BOOL finished) {
		[self fadeOut:target];
	}];
}

@end