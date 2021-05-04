#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListItemsController.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "UIImage+Scale.h"
#import <os/log.h>
#import <spawn.h>
//@import UIKit;
@import WebKit;

@interface HelpViewController : PSListController<UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) UICollectionView *collectionView;
- (void)_openTwitterForUser:(NSString*)username;
@end

