//
//  CanvasViewController.h
//  TouchPainter
//
//  Created by hello on 2021/4/3.
//

#import <UIKit/UIKit.h>
#import "Scribble.h"
#import "CanvasView.h"
#import "CanvasViewGenerator.h"
#import "CommandBarButton.h"
#import "NSMutableArray+Stack.h"


NS_ASSUME_NONNULL_BEGIN

@interface CanvasViewController : UIViewController


@property (nonatomic, retain) CanvasView *canvasView;
@property (nonatomic, retain) Scribble *scribble;
@property (nonatomic, retain) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeSize;
@property (nonatomic, assign) CGPoint startPoint;

- (void) loadCanvasViewWithGenerator:(CanvasViewGenerator *)generator;

- (IBAction) onBarButtonHit:(id) button;
- (IBAction) onCustomBarButtonHit:(CommandBarButton *)barButton;

- (NSInvocation *) drawScribbleInvocation;
- (NSInvocation *) undrawScribbleInvocation;

- (void) executeInvocation:(NSInvocation *)invocation withUndoInvocation:(NSInvocation *)undoInvocation;
- (void) unexecuteInvocation:(NSInvocation *)invocation withRedoInvocation:(NSInvocation *)redoInvocation;



@end

NS_ASSUME_NONNULL_END
