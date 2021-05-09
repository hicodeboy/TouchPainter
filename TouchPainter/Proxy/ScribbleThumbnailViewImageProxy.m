//
//  ScribbleThumbnailViewImageProxy.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "ScribbleThumbnailViewImageProxy.h"
#import "Command.h"
@interface ScribbleThumbnailViewImageProxy()


@end

@implementation ScribbleThumbnailViewImageProxy {
    UIImage *_realImage;
    BOOL _loadingThreadHasLaunched;
}
@synthesize scribble = _scribble;

- (Scribble *) scribble
{
  if (_scribble == nil)
  {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *scribbleData = [fileManager contentsAtPath:self.scribblePath];
    ScribbleMemento *scribbleMemento = [ScribbleMemento mementoWithData:scribbleData];
      _scribble= [Scribble scribbleWithMemento:scribbleMemento];
  }
  
  return _scribble;
}

- (UIImage *) image
{
  if (_realImage == nil)
  {
      _realImage = [[UIImage alloc] initWithContentsOfFile:self.imagePath];
  }
  
  return _realImage;
}

- (void)drawRect:(CGRect)rect
{
  // if is no real image available
  // from realImageView_,
  // then just draw a blank frame
  // as a placeholder image
  if (_realImage == nil)
  {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();

    // draw a placeholder frame
    // with a 10-user-space-unit-long painted
    // segment and a 3-user-space-unit-long
    // unpainted segment of a dash line
    CGContextSetLineWidth(context, 10.0);
    const CGFloat dashLengths[2] = {10,3};
    CGContextSetLineDash (context, 3, dashLengths, 2);
    CGContextSetStrokeColorWithColor(context, [[UIColor darkGrayColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // launch a thread to load the real
    // payload if it hasn't done yet
    if (!_loadingThreadHasLaunched)
    {
      [self performSelectorInBackground:@selector(forwardImageLoadingThread)
                             withObject:nil];
        _loadingThreadHasLaunched = YES;
    }
  }
  // otherwise pass the draw*: message
  // along to realImage_ and let it
  // draw the real image
  else
  {
    [_realImage drawInRect:rect];
  }
}

#pragma mark Touch event handlers

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [_touchCommand execute];
}

#pragma mark -
#pragma mark A private method for loading a real image in a thread

- (void) forwardImageLoadingThread
{
    
    @autoreleasepool {
        // forward the message to load
        // the real image payload
        [self image];
        
        // redraw itself with the newly loaded image
        [self performSelectorInBackground:@selector(setNeedsDisplay) withObject:nil];
    }
}

@end
