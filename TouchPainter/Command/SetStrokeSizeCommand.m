//
//  SetStrokeSizeCommand.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/5.
//

#import "SetStrokeSizeCommand.h"
#import "CoordinatingController.h"
#import "CanvasViewController.h"


@implementation SetStrokeSizeCommand

- (void) execute
{
  // get the current stroke size
  // from whatever it's my delegate
  CGFloat strokeSize = 1;
  [_delegate command:self didRequestForStrokeSize:&strokeSize];
  
  // get a hold of the current
  // canvasViewController from
  // the coordinatingController
  // (see the Mediator pattern chapter
  // for details)
  CoordinatingController *coordinator = [CoordinatingController sharedInstance];
  CanvasViewController *controller = [coordinator canvasViewController];
  
  // assign the stroke size to
  // the canvasViewController
  [controller setStrokeSize:strokeSize];
}


@end
