//
//  Command.m
//  TouchPainter
//
//  Created by hello on 2021/4/4.
//

#import "Command.h"

@implementation Command
- (void) execute
{
  // should throw an exception.
}

- (void) undo
{
  // do nothing
  // subclasses need to override this
  // method to perform actual undo.
}
@end
