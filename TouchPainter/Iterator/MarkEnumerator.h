//
//  MarkEnumerator.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol Mark;

@interface MarkEnumerator : NSEnumerator

@property (nonatomic, strong) NSMutableArray *stack;

- (id) initWithMark:(id <Mark>)mark;
- (void) traverseAndBuildStackWithMark:(id <Mark>)mark;

- (NSArray *)allObjects;
- (id)nextObject;
@end

NS_ASSUME_NONNULL_END
