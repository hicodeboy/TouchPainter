//
//  ScribbleThumbnailView.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import <UIKit/UIKit.h>
#import "Scribble.h"
#import "ScribbleSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScribbleThumbnailView : UIView <ScribbleSource>


@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) Scribble *scribble;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *scribblePath;
@end

NS_ASSUME_NONNULL_END
