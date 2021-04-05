//
//  Command.h
//  TouchPainter
//
//  Created by hello on 2021/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Command : NSObject
@property (nonatomic, retain) NSDictionary *userInfo;

- (void) execute;
- (void) undo;
@end

NS_ASSUME_NONNULL_END
