//
//  ClothCanvasView.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "ClothCanvasView.h"

@implementation ClothCanvasView

- (id)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame]))
  {
    // Add a cloth image view on top
    // as the canvas background
    UIImage *backgroundImage = [UIImage imageNamed:@"placeholder"];
    UIImageView *backgroundView = [[UIImageView alloc]
                                    initWithImage:backgroundImage];
    [self addSubview:backgroundView];
  }
  
  return self;
}

@end
