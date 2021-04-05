//
//  ScribbleMemento.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "ScribbleMemento.h"

#import "Mark.h"
#import"ScribbleMemento.h"

@interface ScribbleMemento ()






@end


@implementation ScribbleMemento
- (NSData *) data
{
//  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_mark];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_mark requiringSecureCoding:NO error:nil];
  return data;
}

+ (ScribbleMemento *) mementoWithData:(NSData *)data
{
  // It raises an NSInvalidArchiveOperationException if data is not a valid archive
  id <Mark> retoredMark = (id <Mark>)[NSKeyedUnarchiver unarchivedObjectOfClass:[ScribbleMemento class] fromData:data error:nil];
  ScribbleMemento *memento = [[ScribbleMemento alloc]
                               initWithMark:retoredMark];
  
  return memento;
}

- (id) initWithMark:(id <Mark>)aMark
{
  if (self = [super init])
  {
    [self setMark:aMark];
  }
  
  return self;
}


@end
