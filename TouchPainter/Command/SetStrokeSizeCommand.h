//
//  SetStrokeSizeCommand.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/5.
//

#import "Command.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class SetStrokeSizeCommand;

@protocol SetStrokeSizeCommandDelegate

- (void) command:(SetStrokeSizeCommand *)command
                didRequestForStrokeSize:(CGFloat *)size;

@end
@interface SetStrokeSizeCommand : Command
@property (nonatomic, weak) id <SetStrokeSizeCommandDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
