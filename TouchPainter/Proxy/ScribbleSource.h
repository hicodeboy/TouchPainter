//
//  ScribbleSource.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import <Foundation/Foundation.h>
#import "Scribble.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ScribbleSource <NSObject>
- (Scribble *) scribble;
@end

NS_ASSUME_NONNULL_END
