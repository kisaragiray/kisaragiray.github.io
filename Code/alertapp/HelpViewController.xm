#import "HelpViewController.h"
@import UIKit;

@implementation HelpViewController {
	NSArray *images;
	NSArray *titles;
	NSArray *contents;
	UILabel *Label;
	NSArray *photos;
}
 
- (void)viewDidLoad {
	[super viewDidLoad];

	[[self navigationItem] setTitle:@"Info"];

	UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
	_collectionView = [[UICollectionView alloc] 
		initWithFrame:self.view.frame 
		collectionViewLayout:layout];
	[_collectionView setDataSource:self];
	[_collectionView setDelegate:self];

	[_collectionView registerClass:[UICollectionViewCell class] 
		forCellWithReuseIdentifier:@"cellIdentifier"];
	[_collectionView setBackgroundColor:[UIColor redColor]];

	[self.view addSubview:_collectionView];

	//[self test];

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

	photos = @[@"nagi", 
		@"toko", 
		@"saya", 
		@"yumiko"];
    
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

    return specifiers;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *CellIdentifier = @"tableCell";
	UITableViewCell *cell = [tableView 
		dequeueReusableCellWithIdentifier:CellIdentifier];

	if (indexPath.section == 0) {
		if (cell == nil) {
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
		if (cell == nil) {
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
	}
	return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}

- (void)openTwitter {
	[self _openTwitterForUser:@"ray__kisaragi"];
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

- (void)_openTwitterForUser:(NSString*)username {
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

- (void)test {
	UIScrollView *scrollView = [[UIScrollView alloc] 
		initWithFrame:CGRectMake(
			W / 2 - 200, H / 2 + 50, 
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

//UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 15;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];

	cell.backgroundColor=[UIColor greenColor];
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return CGSizeMake(50, 50);
}

@end