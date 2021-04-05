//
//  CanvasView.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import <UIKit/UIKit.h>
@protocol Mark;

NS_ASSUME_NONNULL_BEGIN

@interface CanvasView : UIView
@property (nonatomic, weak) id <Mark> mark;
@end

NS_ASSUME_NONNULL_END
