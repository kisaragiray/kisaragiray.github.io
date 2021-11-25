#import "SystemSounds.h"
#import "SoundInfo.h"
#import "SoundTableViewCell.h"

@interface SystemSounds ()

@property (strong, nonatomic) NSArray *systemSounds;

@end

@implementation SystemSounds

- (void)viewDidLoad {
	[super viewDidLoad];

/*
	UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
	[refreshControl addTarget:self 
		action:@selector(startDownload) 
		forControlEvents:UIControlEventValueChanged];

	self.refreshControl = refreshControl;
*/

	UIImage* image = [UIImage imageNamed:@"tableViewImage.png"];
	UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
	[self.tableView setBackgroundView:imageView];

	self.systemSounds = [SoundInfo systemSounds];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.systemSounds.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 38;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	//SoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SoundTableViewCell" forIndexPath:indexPath];

	static NSString *CellIdentifier = @"SoundTableViewCell";
	SoundTableViewCell *cell = [tableView 
		dequeueReusableCellWithIdentifier:CellIdentifier];

	if (indexPath.section == 0) {
		if (!cell) {
			cell = [[SoundTableViewCell alloc] 
			initWithStyle:UITableViewCellStyleValue1 
			reuseIdentifier:CellIdentifier];
		}
	UIListContentConfiguration *content = [cell defaultContentConfiguration];

	SoundInfo *soundInfo = self.systemSounds[indexPath.row];

	content.image = [UIImage imageNamed:@"box.png"];
	content.text = soundInfo.name;
	content.textProperties.color = [UIColor blackColor];
	content.textProperties.font = [UIFont boldSystemFontOfSize:18.0];

//	cell.textLabel.text = soundInfo.name;
//	cell.textLabel.textColor = [UIColor blackColor];
	cell.textLabel.shadowColor = [UIColor grayColor];
	cell.textLabel.shadowOffset = CGSizeMake(1.0, 1.0);
//	[cell.textLabel setFont:[UIFont boldSystemFontOfSize:18.0]];



	content.secondaryText = soundInfo.soundId.stringValue;
	content.secondaryTextProperties.color = [UIColor blackColor];
	content.secondaryTextProperties.font = [UIFont boldSystemFontOfSize:14.0];

//	cell.detailTextLabel.text = soundInfo.soundId.stringValue;
//	cell.detailTextLabel.textColor = [UIColor blackColor];
	cell.detailTextLabel.shadowColor = [UIColor grayColor];
	cell.detailTextLabel.shadowOffset = CGSizeMake(1.0, 1.0);
//	[cell.detailTextLabel setFont:[UIFont boldSystemFontOfSize:12.0]];

	[cell setContentConfiguration:content];

}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	SoundInfo *soundInfo = self.systemSounds[indexPath.row];
	AudioServicesPlaySystemSound(soundInfo.soundId.integerValue);
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


@end