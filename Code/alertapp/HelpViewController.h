#import "UIImage+Scale.h"
#import <AutoScrollLabel/CBAutoScrollLabel.h>

@interface HelpViewController : PSListController<UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, retain) CBAutoScrollLabel *autoScrollLabel;

- (void)openTwitterForUser:(NSString*)username;
@end
