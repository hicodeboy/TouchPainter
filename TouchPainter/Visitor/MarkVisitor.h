//
//  MarkVisitor.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Dot, Vertex, Stroke;
@protocol Mark;
@protocol MarkVisitor <NSObject>
- (void) visitMark:(id <Mark>)mark;
- (void) visitDot:(Dot *)dot;
- (void) visitVertex:(Vertex *)vertex;
- (void) visitStroke:(Stroke *)stroke;

@end

NS_ASSUME_NONNULL_END
