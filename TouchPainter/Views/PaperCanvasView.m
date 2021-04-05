//
//  PaperCanvasView.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "PaperCanvasView.h"

@implementation PaperCanvasView

- (id)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame]))
  {
    // Add a paper image view on top
    // as the canvas background
    UIImage *backgroundImage = [UIImage imageNamed:@"paper"];
    UIImageView *backgroundView = [[UIImageView alloc]
                                    initWithImage:backgroundImage];
    [self addSubview:backgroundView];
  }
  
  return self;
}

@end
