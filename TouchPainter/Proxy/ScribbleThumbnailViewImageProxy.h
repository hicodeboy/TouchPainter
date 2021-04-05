//
//  ScribbleThumbnailViewImageProxy.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "ScribbleThumbnailView.h"
#import "Command.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScribbleThumbnailViewImageProxy : ScribbleThumbnailView

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) Scribble *scribble;
@property (nonatomic, retain) Command *touchCommand;


- (void) forwardImageLoadingThread;
@end

NS_ASSUME_NONNULL_END
