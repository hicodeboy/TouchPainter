//
//  MarkEnumerator.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarkEnumerator : NSEnumerator

@property (nonatomic, strong) NSMutableArray *stack;
- (NSArray *)allObjects;
- (id)nextObject;
@end

NS_ASSUME_NONNULL_END
