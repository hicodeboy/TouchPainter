//
//  Dot.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "Dot.h"

@implementation Dot

- (void) acceptMarkVisitor:(id <MarkVisitor>)visitor
{
  [visitor visitDot:self];
}

#pragma mark -
#pragma mark NSCopying method

// it needs to be implemented for memento
- (id)copyWithZone:(NSZone *)zone
{
  Dot *dotCopy = [[Dot allocWithZone:zone] initWithLocation:self.location];
  
  // copy the color
  [dotCopy setColor:[UIColor colorWithCGColor:[self.color CGColor]]];
  
  // copy the size
  [dotCopy setSize:self.size];
  
  return dotCopy;
}

#pragma mark -
#pragma mark NSCoder methods

- (id)initWithCoder:(NSCoder *)coder
{
  if (self = [super initWithCoder:coder])
  {
    self.color = [coder decodeObjectForKey:@"DotColor"];
    self.size = [coder decodeFloatForKey:@"DotSize"];
  }
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [super encodeWithCoder:coder];
  [coder encodeObject:self.color forKey:@"DotColor"];
  [coder encodeFloat:self.size forKey:@"DotSize"];
}

#pragma mark -
#pragma mark An Extended Direct-draw Example

// for a direct draw example
- (void) drawWithContext:(CGContextRef)context
{
  CGFloat x = self.location.x;
  CGFloat y = self.location.y;
  CGFloat frameSize = self.size;
  CGRect frame = CGRectMake(x - frameSize / 2.0,
                            y - frameSize / 2.0,
                            frameSize,
                            frameSize);
  
  CGContextSetFillColorWithColor (context,[self.color CGColor]);
  CGContextFillEllipseInRect(context, frame);
}

@end
