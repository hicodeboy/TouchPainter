//
//  ScribbleMemento.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "ScribbleMemento.h"

#import "Mark.h"
#import"ScribbleMemento.h"
#import "Stroke.h"
#import "Dot.h"

@interface ScribbleMemento ()
@end


@implementation ScribbleMemento
- (NSData *) data
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_mark requiringSecureCoding:NO error:nil];
  return data;
}

+ (ScribbleMemento *) mementoWithData:(NSData *)data
{
  // It raises an NSInvalidArchiveOperationException if data is not a valid archive

    NSSet *st = [[NSSet alloc] initWithArray:@[[Vertex class], [Stroke class], [Dot class]]];

    id <Mark> retoredMark = (id <Mark>)[NSKeyedUnarchiver unarchiveObjectWithData:data];
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
