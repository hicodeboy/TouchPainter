//
//  OpenScribbleCommand.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/5.
//

#import "Command.h"
#import "ScribbleSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface OpenScribbleCommand : Command
@property (nonatomic, strong) id <ScribbleSource> scribbleSource;

- (id) initWithScribbleSource:(id <ScribbleSource>) aScribbleSource;
- (void) execute;
@end

NS_ASSUME_NONNULL_END
