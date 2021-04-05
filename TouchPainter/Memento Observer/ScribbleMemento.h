//
//  ScribbleMemento.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import <Foundation/Foundation.h>
#import "Mark.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScribbleMemento : NSObject
@property (nonatomic, assign) BOOL hasCompleteSnapshot;
@property (nonatomic, copy) id <Mark> mark;

- (id) initWithMark:(id <Mark>)aMark;
+ (ScribbleMemento *) mementoWithData:(NSData *)data;
- (NSData *) data;

@end

NS_ASSUME_NONNULL_END
