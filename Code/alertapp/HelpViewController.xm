#import "HelpViewController.h"

@implementation HelpViewController {
	NSArray *images;
	NSArray *titles;
	NSArray *contents;
	UILabel *Label;

	NSArray *cell1images;
	NSArray *cell1titles;
	NSArray *cell1contents;
}

- (void)awakeFromNib {
	[super awakeFromNib];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	[[self navigationItem] setTitle:@"Info"];

	images = @[
		@"twitter.png", 
		@"line.png", 
		@"cydia.png"];

	titles = @[
		@"mikiyan1978", 
		@"LINE", 
		@"リポジトリ"];

	contents = @[
		@"Twitter", 
		@"LINE追加", 
		@"リポジトリ追加"];


	cell1images = @[
		@"blog.png", 
		@"mail.png", 
		@""];

	cell1titles = @[
		@"ブログ", 
		@"テスト", 
		@""];

	cell1contents = @[
		@"mikiyan1978の脱獄日記", 
		@"テストだお", 
		@""];


	[self initAutoScrollLabel];



}

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { //セクション数
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { //セル数
	return 4;
}
*/

- (NSMutableArray *)specifiers {
	if (!_specifiers) {

	NSMutableArray *newSpecs = [NSMutableArray array];
	[newSpecs addObjectsFromArray:[self _makeSpecifiers]];
		_specifiers = newSpecs;
	}
	return _specifiers;
}

- (NSArray*)_makeSpecifiers {
	NSMutableArray *specifiers = [NSMutableArray new];

	[specifiers addObject:({
		PSSpecifier *specifier = [PSSpecifier 
			preferenceSpecifierNamed:@"Developer" 
			target:self 
			set:nil 
			get:nil 
			detail:nil 
			cell:PSGroupCell 
			edit:nil];
			specifier;
		})];

	[specifiers addObject:({
		PSSpecifier *specifier = [PSSpecifier 
			preferenceSpecifierNamed:@"mikiyan1978" 
			target:self 
			set:nil 
			get:nil 
			detail:nil 
			cell:PSButtonCell 
			edit:nil];

	[specifier setIdentifier:@"mikiyan1978"];
	specifier->action = @selector(openTwitter);
	specifier;
	})];

	[specifiers addObject:({
		PSSpecifier *specifier = [PSSpecifier 
			preferenceSpecifierNamed:@"LINE追加" 
			target:self 
			set:nil 
			get:nil 
			detail:nil 
			cell:PSButtonCell 
			edit:nil];

	[specifier setIdentifier:@"line"];
	specifier->action = @selector(addLine);
	specifier;
	})];

	[specifiers addObject:({
		PSSpecifier *specifier = [PSSpecifier 
			preferenceSpecifierNamed:@"リポジトリ追加" 
			target:self 
			set:nil 
			get:nil 
			detail:nil 
			cell:PSButtonCell 
			edit:nil];

	[specifier setIdentifier:@"repo"];
	specifier->action = @selector(addRepo);
	specifier;
	})];

	[specifiers addObject:({
		PSSpecifier *specifier = [PSSpecifier 
			preferenceSpecifierNamed:@"Other" 
			target:self 
			set:nil 
			get:nil 
			detail:nil 
			cell:PSGroupCell 
			edit:nil];
			specifier;
		})];

	[specifiers addObject:({
		PSSpecifier *specifier = [PSSpecifier 
			preferenceSpecifierNamed:@"mikiyan1978の脱獄日記" 
			target:self 
			set:nil 
			get:nil 
			detail:nil 
			cell:PSButtonCell 
			edit:nil];

	[specifier setIdentifier:@"mikiyan1978"];
	specifier->action = @selector(openblog);
	specifier;
	})];

	[specifiers addObject:({
		PSSpecifier *specifier = [PSSpecifier 
			preferenceSpecifierNamed:@"テスト" 
			target:self 
			set:nil 
			get:nil 
			detail:nil 
			cell:PSButtonCell 
			edit:nil];

	[specifier setIdentifier:@"mikiyan1978"];
	specifier->action = @selector(email);
	specifier;
	})];

    return specifiers;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *CellIdentifier = @"tableCell";
	UITableViewCell *cell = [tableView 
		dequeueReusableCellWithIdentifier:CellIdentifier];

	if (indexPath.section == 0) {
		if (!cell) {
			cell = [[UITableViewCell alloc] 
				initWithStyle:UITableViewCellStyleSubtitle 
				reuseIdentifier:CellIdentifier];
		}
		cell.textLabel.text = titles[indexPath.row];
		cell.detailTextLabel.text = contents[indexPath.row];
		cell.imageView.image = [UIImage 
			imageNamed:images[indexPath.row]];
		cell.imageView.layer.cornerRadius = 13.0;
		cell.imageView.clipsToBounds = YES;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	if (indexPath.section == 1) {
		if (!cell) {
			cell = [[UITableViewCell alloc] 
				initWithStyle:UITableViewCellStyleSubtitle 
				reuseIdentifier:CellIdentifier];
		}
		cell.textLabel.text = cell1titles[indexPath.row];
		cell.detailTextLabel.text = cell1contents[indexPath.row];
		cell.imageView.image = [UIImage 
			imageNamed:cell1images[indexPath.row]];
		cell.imageView.layer.cornerRadius = 13.0;
		cell.imageView.clipsToBounds = YES;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

	/*if (indexPath.section == 1) {
		if (!cell) {
			cell = [[UITableViewCell alloc] 
				initWithStyle:UITableViewCellStyleSubtitle 
				reuseIdentifier:CellIdentifier];
		}
		cell.textLabel.text = @"はてなブログ";
		cell.detailTextLabel.text = @"mikiyan1978の脱獄日記";
		cell.imageView.image = [UIImage 
			imageNamed:@"blog.png"];
		cell.imageView.layer.cornerRadius = 13.0;
		cell.imageView.clipsToBounds = YES;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}*/

	cell.selectionStyle = UITableViewCellSelectionStyleNone;

	return cell;

}

/*
- (void)didMoveToSuperview {

	UIView *gView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];

	CAGradientLayer *linGradientView = [CAGradientLayer layer];

	linGradientView.colors = @[
		(id)[UIColor colorWithRed:48.0/255.0 
			green:35.0/255.0 
			blue:174.0/255.0 
			alpha:1.0].CGColor, 
		(id)[UIColor colorWithRed:200.0/255.0 
			green:109.0/255.0 
			blue:215.0/255.0 
			alpha:1.0].CGColor];

	[gView.layer insertSublayer:linGradientView atIndex:0];
	[self.view addSubview:gView];
	[self.view bringSubviewToFront:gView];

}
*/

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}

- (void)openTwitter {
	[self openTwitterForUser:@"ray__kisaragi"];
}

- (void)openblog {
	[[UIApplication sharedApplication] 
		openURL:[NSURL URLWithString:@"http://mikiyan1978.hatenablog.com/"] 
		options:@{} 
		completionHandler:nil];
}

- (void)addRepo {
	[[UIApplication sharedApplication] 
		openURL:[NSURL URLWithString:@"cydia://url/https://cydia.saurik.com/api/share#?source=https://kisaragiray.github.io/repo/"] 
		options:@{} 
		completionHandler:nil];
}

- (void)addLine {
	[[UIApplication sharedApplication] 
		openURL:[NSURL URLWithString:@"http://line.me/ti/p/SRrsblD6WF"] 
		options:@{} 
		completionHandler:nil];
}

- (void)openTwitterForUser:(NSString*)username {

	UIApplication *app = [UIApplication sharedApplication];
    
	NSURL *twitterapp = [NSURL URLWithString:[NSString stringWithFormat:@"twitter:///user?screen_name=%@", username]];

	NSURL *tweetbot = [NSURL URLWithString:[NSString stringWithFormat:@"tweetbot:///user_profile/%@", username]];

	NSURL *twitterweb = [NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@", username]];
    
    
	if ([app canOpenURL:twitterapp])
		[app openURL:twitterapp 
			options:@{} 
			completionHandler:nil];
	else if ([app canOpenURL:tweetbot])
		[app openURL:tweetbot 
			options:@{} 
			completionHandler:nil];
	else
		[app openURL:twitterweb 
			options:@{} 
			completionHandler:nil];
}

- (void)email {
 //NSData *dataForImage = UIImagePNGRepresentation(myNewImage);  Convert the UIImage to data here if adding an a PNG image.
    
	if ([MFMailComposeViewController canSendMail]) {

	MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
	mailVC.mailComposeDelegate = self;
	[mailVC setSubject:@"ここは件名"];
	[mailVC setMessageBody:@"テストメールだお!" isHTML:NO];
        
	[mailVC setToRecipients:@[@"mikiyan1978@gmail.com"]];

	/*[mailVC  addAttachmentData:dataForImage 
		mimeType:@"image/jpeg" 
		fileName:@"My image"];*/

	[self presentViewController:mailVC 
		animated:YES 
		completion:NULL];
	} else {
		NSLog(@"This device cannot send email");
	}
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissViewControllerAnimated:YES 
		completion:nil];
}

- (void)test {
	UIScrollView *scrollView = [[UIScrollView alloc] 
		initWithFrame:CGRectMake(
			W / 2 - 200, 
			H / 2 + 50, 
			400, 50)];

	scrollView.backgroundColor = [UIColor clearColor];
	scrollView.contentSize = CGSizeMake(5000, 50);

	[scrollView setShowsHorizontalScrollIndicator:NO];
	[scrollView setShowsVerticalScrollIndicator:NO];

	Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 5000, 40)];

	Label.lineBreakMode = NSLineBreakByWordWrapping;
	Label.numberOfLines = 0;
	Label.textAlignment = NSTextAlignmentCenter;

	Label.text = @"Keyframe animations offer extraordinary power for developers because they let you set multiple values and have iOS animate between them over times you specify. There are three components: a key path (the property to animate), an array of values (the value you want to use for that property), and an array of key times (when that value should be used for the property).The number of key times needs to match the number of values, because each value is applied in order when its key time is reached. In the example code below, a view will be moved down 300 points then back to its starting point over 2 seconds. It's important that you understand the key times and duration are separate: the key times should be between 0 and 1, where 0 means the start of the animation and 1 means the end of the animation.";

	[self.view addSubview:scrollView];
	[scrollView addSubview:Label];

}

- (void)initAutoScrollLabel {
	self.autoScrollLabel = [[CBAutoScrollLabel alloc] 
		initWithFrame:CGRectMake(
			W / 2 - 185, 50, 400, 50)];

	//self.autoScrollLabel.text = @"Power Controller App Xをインストールして頂き、ありがとうございます😊";

	self.autoScrollLabel.text = @"Keyframe animations offer extraordinary power for developers because they let you set multiple values and have iOS animate between them over times you specify. There are three components: a key path (the property to animate), an array of values (the value you want to use for that property), and an array of key times (when that value should be used for the property).The number of key times needs to match the number of values, because each value is applied in order when its key time is reached. In the example code below, a view will be moved down 300 points then back to its starting point over 2 seconds. It's important that you understand the key times and duration are separate: the key times should be between 0 and 1, where 0 means the start of the animation and 1 means the end of the animation.Keyframe animations offer extraordinary power for developers because they let you set multiple values and have iOS animate between them over times you specify. There are three components: a key path (the property to animate), an array of values (the value you want to use for that property), and an array of key times (when that value should be used for the property).The number of key times needs to match the number of values, because each value is applied in order when its key time is reached. In the example code below, a view will be moved down 300 points then back to its starting point over 2 seconds. It's important that you understand the key times and duration are separate: the key times should be between 0 and 1, where 0 means the start of the animation and 1 means the end of the animation.";

	self.autoScrollLabel.textColor = [UIColor whiteColor];
	self.autoScrollLabel.backgroundColor = [UIColor clearColor];

	self.autoScrollLabel.labelSpacing = 30; // 開始ラベルと終了ラベルの間の距離
	self.autoScrollLabel.pauseInterval = 1.5; // スクロールが再開するまでの数秒の一時停止
	self.autoScrollLabel.scrollSpeed = 40; // ピクセル/秒
	self.autoScrollLabel.textAlignment = NSTextAlignmentCenter;
	self.autoScrollLabel.fadeLength = 0.0f;
	self.autoScrollLabel.scrollDirection = CBAutoScrollDirectionLeft;

	[self.autoScrollLabel observeApplicationNotifications];
	[self.view addSubview:self.autoScrollLabel];
}


@end

%ctor {

}



