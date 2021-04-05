//
//  NSMutableArray+Stack.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)
- (void) push:(id)object
{
  if (object != nil)
    [self addObject:object];
}

- (id) pop
{
  if ([self count] == 0) return nil;
  
  id object = [self lastObject];
  [self removeLastObject];
  
  return object;
}

- (void) dropBottom
{
  if ([self count] == 0) return;
  
  [self removeObjectAtIndex:0];
}
@end
