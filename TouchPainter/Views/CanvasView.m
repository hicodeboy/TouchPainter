//
//  CanvasView.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "CanvasView.h"
#import "Mark.h"
#import "MarkRenderer.h"

@interface CanvasView()
@property (nonatomic, strong) UIImage *currentImage;

@end

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

//- (void)setMark:(id<Mark>)mark {
//    _mark = mark;
//    
//}

- (void)displayLayer:(CALayer *)layer {
    NSLog(@"%s", __func__);
    
    CGSize size = self.bounds.size;
        CGFloat scale = [UIScreen mainScreen].scale;
        // 异步绘制，切换至子线程
    __weak CanvasView *weakSelf = self;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIGraphicsBeginImageContextWithOptions(size, NO, scale);
            // 获取当前上下文
            CGContextRef context = UIGraphicsGetCurrentContext();
            UIImage *backgroundImage = [UIImage imageNamed:@"fengjing"];
            [backgroundImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
            
            // create a renderer visitor
             MarkRenderer *markRenderer = [[MarkRenderer alloc] initWithCGContext:context] ;

            // pass this renderer along the mark composite structure
            [weakSelf.mark acceptMarkVisitor:markRenderer];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 子线程完成工作，切换至主线程显示
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.currentImage = image;
                weakSelf.layer.contents = (__bridge id)image.CGImage;
            });
        });
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  
  // Drawing code
//  CGContextRef context = UIGraphicsGetCurrentContext();
//  
//  // create a renderer visitor
//  MarkRenderer *markRenderer = [[MarkRenderer alloc] initWithCGContext:context] ;
//  
//  // pass this renderer along the mark composite structure
//  [_mark acceptMarkVisitor:markRenderer];
  
}

- (UIImage *)getImage {
    return _currentImage;
}


@end
