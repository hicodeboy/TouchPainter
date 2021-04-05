//
//  ScribbleManager.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import <Foundation/Foundation.h>
#import "Scribble.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScribbleManager : NSObject
- (void) saveScribble:(Scribble *)scribble thumbnail:(UIImage *)image;
- (NSInteger) numberOfScribbles;
- (Scribble *) scribbleAtIndex:(NSInteger)index;
- (UIView *) scribbleThumbnailViewAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
