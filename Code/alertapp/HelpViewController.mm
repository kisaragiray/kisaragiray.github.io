#import "HelpViewController.h"
#import "XXRootViewController.h"
@import UIKit;

WKWebView *wkWebView;

@implementation HelpViewController
 
- (void)loadView {
	[super loadView];
	self.view = [[UIView alloc] 
		initWithFrame:[UIScreen mainScreen].bounds];

	[self wkWebViewHandler];
}

- (void)wkWebViewHandler {
	wkWebView = [WKWebView new];
	wkWebView.navigationDelegate = self;
	wkWebView.UIDelegate = self;
	CGRect rect = self.view.frame;
	wkWebView.frame = rect;
	[self.view addSubview:wkWebView];

	NSURL *url = [NSURL 
		URLWithString:@"https://kisaragiray.github.io/repo/"];

	NSURLRequest *request = [NSURLRequest 
		requestWithURL:url];
	[wkWebView loadRequest:request];

	wkWebView.allowsBackForwardNavigationGestures = YES;

	
	//[wkWebView canGoBack];
	//[wkWebView canGoForward];
	//[wkWebView reload];
	//[wkWebView goForward];
	//[wkWebView goBack];
}
 
@end