//
//  MarkEnumerator.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "MarkEnumerator.h"
#import "Mark.h"
#import "NSMutableArray+Stack.h"

@interface MarkEnumerator ()

- (id) initWithMark:(id <Mark>)mark;
- (void) traverseAndBuildStackWithMark:(id <Mark>)mark;

@end


@implementation MarkEnumerator
- (NSArray *)allObjects
{
  // returns an array of yet-visited Mark nodes
  // i.e. the remaining elements in the stack
  return [[_stack reverseObjectEnumerator] allObjects];
}

- (id)nextObject
{
  return [_stack pop];
}



#pragma mark -
#pragma mark Private Methods

- (id) initWithMark:(id <Mark>)aMark
{
  if (self = [super init])
  {
      _stack = [[NSMutableArray alloc] initWithCapacity:[aMark count]];
    
    // post-orderly traverse the whole Mark aggregate
    // and add individual Marks in a private stack
    [self traverseAndBuildStackWithMark:aMark];
  }
  
  return self;
}

- (void) traverseAndBuildStackWithMark:(id <Mark>)mark
{
  // push post-order traversal
  // into the stack
  if (mark == nil) return;
  
  [_stack push:mark];
  
  NSUInteger index = [mark count];
  id <Mark> childMark = nil;
    while (childMark = [mark childMarkAtIndex:--index] )
  {
    [self traverseAndBuildStackWithMark:childMark];
  }
}
@end
