//
//  PaperCanvasViewGenerator.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "PaperCanvasViewGenerator.h"
#import "PaperCanvasView.h"
@implementation PaperCanvasViewGenerator
- (CanvasView *) canvasViewWithFrame:(CGRect) aFrame
{
    return [[PaperCanvasView alloc] initWithFrame:aFrame];
}
@end
