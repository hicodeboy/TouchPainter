//
//  SetStrokeColorCommand.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/5.
//

#import "Command.h"
#import <UIKit/UIKit.h>

typedef void (^RGBValuesProvider)(CGFloat *red, CGFloat *green, CGFloat *blue);
typedef void (^PostColorUpdateProvider)(UIColor *color);

@class SetStrokeColorCommand;

@protocol SetStrokeColorCommandDelegate

- (void) command:(SetStrokeColorCommand *) command
                didRequestColorComponentsForRed:(CGFloat *) red
                                          green:(CGFloat *) green
                                           blue:(CGFloat *) blue;

- (void) command:(SetStrokeColorCommand *) command
                didFinishColorUpdateWithColor:(UIColor *) color;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SetStrokeColorCommand : Command
@property (nonatomic, weak) id <SetStrokeColorCommandDelegate> delegate;
@property (nonatomic, copy) RGBValuesProvider RGBValuesProvider;
@property (nonatomic, copy) PostColorUpdateProvider postColorUpdateProvider;
@end

NS_ASSUME_NONNULL_END
