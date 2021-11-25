#import "TestviewController.h"


@interface TestviewController () {
}
@end

@implementation TestviewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[[self navigationItem] setTitle:@"TEST"];


/*
	UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
	[refreshControl addTarget:self 
		action:@selector(action) 
		forControlEvents:UIControlEventValueChanged];

	self.refreshControl = refreshControl;
*/

	UIImage* image = [UIImage imageNamed:@"tableViewImage.png"];
	UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
	[self.tableView setBackgroundView:imageView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [NSString stringWithFormat:@"セクション:%ld", (long)section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 20;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *CellIdentifier = @"TestviewController";
	UITableViewCell *cell = [tableView 
		dequeueReusableCellWithIdentifier:CellIdentifier];

//	if (indexPath.section == 0) {
		if (!cell) {
			cell = [[UITableViewCell alloc] 
			initWithStyle:UITableViewCellStyleValue1 
			reuseIdentifier:CellIdentifier];
		}


	UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectZero];

	[sw addTarget:self action:@selector(tapSwich:) forControlEvents:UIControlEventTouchUpInside];

	cell.selectionStyle = UITableViewCellSelectionStyleNone;

	cell.accessoryView = sw;

	cell.imageView.image = [UIImage imageNamed:@"box.png"];
//	cell.imageView.backgroundColor = [UIColor grayColor];

	cell.textLabel.text = [NSString stringWithFormat:@"メインタイトル:%ld", indexPath.row];
	cell.textLabel.textColor = [UIColor blackColor];
	cell.textLabel.shadowColor = [UIColor grayColor];
	cell.textLabel.shadowOffset = CGSizeMake(1.0, 1.0);
	[cell.textLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
	cell.textLabel.numberOfLines = 0;


	cell.detailTextLabel.text = [NSString stringWithFormat:@"サブタイトル:%ld", indexPath.row];
	cell.detailTextLabel.textColor = [UIColor blueColor];
	cell.detailTextLabel.shadowColor = [UIColor grayColor];
	cell.detailTextLabel.shadowOffset = CGSizeMake(1.0, 1.0);
	[cell.detailTextLabel setFont:[UIFont boldSystemFontOfSize:11.0]];
	cell.detailTextLabel.numberOfLines = 0;

//	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;


/*
	UIListContentConfiguration *content = [cell defaultContentConfiguration];

	content.image = [UIImage imageNamed:@"box.png"];

	content.text = [NSString stringWithFormat:@"メインタイトル:%ld", indexPath.row];
	content.textProperties.color = [UIColor blackColor];
	content.textProperties.font = [UIFont boldSystemFontOfSize:18.0];


	content.secondaryText = [NSString stringWithFormat:@"サブタイトル:%ld", indexPath.row];
	content.secondaryTextProperties.color = [UIColor blackColor];
	content.secondaryTextProperties.font = [UIFont boldSystemFontOfSize:10.0];

	[cell setContentConfiguration:content];
*/

//	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];

//	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
}

/*
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self.tableView reloadData];
}
*/

- (void)tapSwich:(id)sender {
	UISwitch *sw = (UISwitch *)sender;

	os_log(OS_LOG_DEFAULT, "switch tapped. value = %@", (sw.on ? @"ON" : @"OFF"));
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row % 2 == 0) {
		// 偶数セル
		cell.backgroundColor = RGBA(255.0, 0.0, 255.0, 0.3);
	} else {
		// 奇数セル
		cell.backgroundColor = RGBA(0.0, 0.0, 0.0, 0.1);
	}
}

- (void)action {
}

@end