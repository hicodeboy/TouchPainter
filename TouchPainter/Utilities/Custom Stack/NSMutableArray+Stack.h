//
//  NSMutableArray+Stack.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Stack)
- (void) push:(id)object;
- (id) pop;
- (void) dropBottom;

@end

NS_ASSUME_NONNULL_END
