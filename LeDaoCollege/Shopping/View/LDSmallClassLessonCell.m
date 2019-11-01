//
//  LDSmallClassLessonCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/23.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDSmallClassLessonCell.h"

@implementation LDSmallClassLessonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshWith:(LDClassChapterSectionModel *)model{
    self.chapterLabel.text = model.sectionContent;
    self.timeLabel.text = [NSString stringWithFormat:@"(%@)",model.duration];
}
@end
