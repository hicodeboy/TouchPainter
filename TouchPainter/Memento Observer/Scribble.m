//
//  Scribble.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "Scribble.h"
#import "Stroke.h"

@interface Scribble ()

@property (nonatomic, strong) id <Mark> mark;

@property (nonatomic, strong) id <Mark> incrementalMark;
@end

@implementation Scribble
- (id) init
{
  if (self = [super init])
  {
    // the parent should be a composite
    // object (i.e. Stroke)
    _mark = [[Stroke alloc] init];
  }
  
  return self;
}

#pragma mark -
#pragma mark Methods for Mark management

- (void) addMark:(id <Mark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark
{
  // manual KVO invocation
  [self willChangeValueForKey:@"mark"];
  // if the flag is set to YES
  // then add this aMark to the
  // *PREVIOUS*Mark as part of an
  // aggregate.
  // Based on our design, it's supposed
  // to be the last child of the main
  // parent
  if (shouldAddToPreviousMark)
  {
    [[_mark lastChild] addMark:aMark];
  }
  // otherwise attach it to the parent
  else
  {
    [_mark addMark:aMark];
    _incrementalMark = aMark;
  }
  
  // manual KVO invocation
  [self didChangeValueForKey:@"mark"];
}

- (void) removeMark:(id <Mark>)aMark
{
  // do nothing if aMark is the parent
  if (aMark == _mark) return;
  
  // manual KVO invocation
  [self willChangeValueForKey:@"mark"];
  
  [_mark removeMark:aMark];
  
  // we don't need to keep the
  // incrementalMark_ reference
  // as it's just removed in the parent
  if (aMark == _incrementalMark)
  {
    _incrementalMark = nil;
  }
  
  // manual KVO invocation
  [self didChangeValueForKey:@"mark"];
}

#pragma mark -
#pragma mark Methods for memento

- (id) initWithMemento:(ScribbleMemento*)aMemento
{
  if (self = [super init])
  {
    if ([aMemento hasCompleteSnapshot])
    {
      [self setMark:[aMemento mark]];
    }
    else
    {
      // if the memento contains only
      // incremental mark, then we need to
      // create a parent Stroke object to
      // hold it
      _mark = [[Stroke alloc] init];
      [self attachStateFromMemento:aMemento];
    }
  }
  
  return self;
}

- (void) attachStateFromMemento:(ScribbleMemento *)memento
{
  // attach any mark from a memento object
  // to the main parent
  [self addMark:[memento mark] shouldAddToPreviousMark:NO];
}

- (ScribbleMemento *) scribbleMementoWithCompleteSnapshot:(BOOL)hasCompleteSnapshot
{
  id <Mark> mementoMark = _incrementalMark;
  
  // if the resulting memento asks
  // for a complete snapshot, then
  // set it with parentMark_
  if (hasCompleteSnapshot)
  {
    mementoMark = _mark;
  }
  // but if incrementalMark_
  // is nil then we can't do anything
  // but bail out
  else if (mementoMark == nil)
  {
    return nil;
  }
  
  ScribbleMemento *memento = [[ScribbleMemento alloc]
                               initWithMark:mementoMark];
  [memento setHasCompleteSnapshot:hasCompleteSnapshot];
  
  return memento;
}

- (id <Mark>) newMark {
    return _incrementalMark;
}

- (ScribbleMemento *) scribbleMemento
{
  return [self scribbleMementoWithCompleteSnapshot:YES];
}

+ (Scribble *) scribbleWithMemento:(ScribbleMemento *)aMemento
{
  Scribble *scribble = [[Scribble alloc] initWithMemento:aMemento];
  return scribble;
}

@end
