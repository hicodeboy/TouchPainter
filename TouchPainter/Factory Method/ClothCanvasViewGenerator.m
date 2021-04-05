//
//  ClothCanvasViewGenerator.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "ClothCanvasViewGenerator.h"
#import "ClothCanvasView.h"
@implementation ClothCanvasViewGenerator
- (CanvasView *) canvasViewWithFrame:(CGRect) aFrame
{
    return [[ClothCanvasView alloc] initWithFrame:aFrame];
}
@end
