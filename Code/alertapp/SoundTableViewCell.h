//
//  SoundTableViewCell.h
//  SystemSoundSample
//
//  Created by hirai.yuki on 2012/11/21.
//  Copyright (c) 2012年 Classmethod, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoundTableViewCell : UITableViewCell

@property (weak, nonatomic) UILabel *nameLabel;
@property (weak, nonatomic) UILabel *soundIdLabel;
@property (weak, nonatomic) UILabel *fileNameIniPhoneLabel;
@property (weak, nonatomic) UILabel *fileNameIniPodLabel;
@property (weak, nonatomic) UILabel *categoryLabel;
@property (weak, nonatomic) UILabel *descLabel;

@end
