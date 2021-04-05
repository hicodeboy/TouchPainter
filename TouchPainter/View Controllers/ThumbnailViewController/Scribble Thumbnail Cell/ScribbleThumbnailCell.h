//
//  ScribbleThumbnailCell.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/5.
//

#import <UIKit/UIKit.h>
#import "ScribbleThumbnailView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScribbleThumbnailCell : UITableViewCell
+ (NSInteger) numberOfPlaceHolders;
- (void) addThumbnailView:(UIView *)thumbnailView
                      atIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
