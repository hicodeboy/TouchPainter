//
//  UIView+UIImage.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "UIView+UIImage.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (UIImage)
- (UIImage*)image
{
  // Create a graphics context with the target size
  // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
  // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
  CGSize imageSize = [self bounds].size;// [[UIScreen mainScreen] bounds].size;
  
  
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
 
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  // Iterate over every window from back to front
  for (UIWindow *window in [[UIApplication sharedApplication] windows])
  {
    if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
    {
      // -renderInContext: renders in the coordinate space of the layer,
      // so we must first apply the layer's geometry to the graphics context
      CGContextSaveGState(context);
      // Center the context around the window's anchor point
      CGContextTranslateCTM(context, [window center].x, [window center].y);
      // Apply the window's transform about the anchor point
      CGContextConcatCTM(context, [window transform]);
      // Offset by the portion of the bounds left of and above the anchor point
      CGContextTranslateCTM(context,
                            -[window bounds].size.width *[[window layer] anchorPoint].x,
                            -[window bounds].size.height *[[window layer] anchorPoint].y);
      
      // Render the layer hierarchy to the current context
      [[window layer] renderInContext:context];
      
      // Restore the context
      CGContextRestoreGState(context);
    }
  }
  
  // Retrieve the screenshot image
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  
  UIGraphicsEndImageContext();
  
  return image;
}

@end
