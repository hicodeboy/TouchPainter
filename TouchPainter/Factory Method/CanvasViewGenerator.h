//
//  CanvasViewGenerator.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import <Foundation/Foundation.h>
#import "CanvasView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CanvasViewGenerator : NSObject
- (CanvasView *) canvasViewWithFrame:(CGRect) aFrame;
@end

NS_ASSUME_NONNULL_END
