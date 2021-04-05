//
//  CanvasView.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "CanvasView.h"
#import "Mark.h"
#import "MarkRenderer.h"

@implementation CanvasView

- (id)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame]))
  {
    // Initialization code
    [self setBackgroundColor:[UIColor whiteColor]];
      _mark = nil;
  }
  return self;
}

- (void)setMark:(id<Mark>)mark {
    _mark = mark;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  
  // Drawing code
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  // create a renderer visitor
  MarkRenderer *markRenderer = [[MarkRenderer alloc] initWithCGContext:context] ;
  
  // pass this renderer along the mark composite structure
  [_mark acceptMarkVisitor:markRenderer];
  
}

@end
