#import "SystemSounds.h"
#import "SoundInfo.h"
#import "SoundTableViewCell.h"

@interface SystemSounds ()

@property (strong, nonatomic) NSArray *systemSounds;

@end

@implementation SystemSounds

- (void)viewDidLoad {
	[super viewDidLoad];
    
	self.systemSounds = [SoundInfo systemSounds];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.systemSounds.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	//SoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SoundTableViewCell" forIndexPath:indexPath];

	static NSString *CellIdentifier = @"SoundTableViewCell";
	SoundTableViewCell *cell = [tableView 
		dequeueReusableCellWithIdentifier:CellIdentifier];

	if (indexPath.section == 0) {
		if (!cell) {
			cell = [[SoundTableViewCell alloc] 
				initWithStyle:UITableViewCellStyleSubtitle 
				reuseIdentifier:CellIdentifier];
		}
	SoundInfo *soundInfo = self.systemSounds[indexPath.row];
	cell.nameLabel.text = soundInfo.name;
	cell.soundIdLabel.text = soundInfo.soundId.stringValue;
}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	SoundInfo *soundInfo = self.systemSounds[indexPath.row];
	AudioServicesPlaySystemSound(soundInfo.soundId.integerValue);
}
@end