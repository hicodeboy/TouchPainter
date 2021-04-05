//
//  CanvasViewController.m
//  TouchPainter
//
//  Created by hello on 2021/4/3.
//

#import "CanvasViewController.h"
#import "CoordinatingController.h"
#import "Stroke.h"
#import "Dot.h"
#import "DeleteScribbleCommand.h"
#import "SaveScribbleCommand.h"
#import "ClothCanvasViewGenerator.h"

@interface CanvasViewController () <UIToolbarDelegate>
@property (weak, nonatomic) IBOutlet CommandBarButton *trashBar;

@property (weak, nonatomic) IBOutlet CommandBarButton *saveBar;

@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [CoordinatingController sharedInstance].activeViewController = self;
    [CoordinatingController sharedInstance].canvasViewController = self;
    
    _trashBar.command = [[DeleteScribbleCommand alloc] init];
    
    _saveBar.command = [[SaveScribbleCommand alloc] init];
    
    // Get a default canvas view
    // with the factory method of
    // the CanvasViewGenerator
    CanvasViewGenerator *defaultGenerator = [[CanvasViewGenerator alloc] init];
    [self loadCanvasViewWithGenerator:defaultGenerator];
    
    // initialize a Scribble model
    Scribble *scribble = [[Scribble alloc] init];
    [self setScribble:scribble];
    
    // setup default stroke color and size
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat redValue = [userDefaults floatForKey:@"red"];
    CGFloat greenValue = [userDefaults floatForKey:@"green"];
    CGFloat blueValue = [userDefaults floatForKey:@"blue"];
    CGFloat sizeValue = [userDefaults floatForKey:@"size"];
    
    [self setStrokeSize:sizeValue];
    [self setStrokeColor:[UIColor colorWithRed:redValue
                                         green:greenValue
                                          blue:blueValue
                                         alpha:1.0]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (IBAction)toolBarAction:(UIBarButtonItem *)sender {
    NSLog(@"tag = %ld", sender.tag);
    switch (sender.tag) {
        case 1:
        case 2: {
            [self onCustomBarButtonHit:sender];
        }
            break;
        case 5:
        case 6: {
            [self onBarButtonHit:sender];
        }
            break;
            
        default:
            [[CoordinatingController sharedInstance] requestViewChangeByObject:sender];
            break;
    }
   
    
}

- (void) onBarButtonHit:(id)sender {
    UIBarButtonItem *barButton = sender;
    
    if ([barButton tag] == 4)
    {
      [self.undoManager undo];
    }
    else if ([barButton tag] == 5)
    {
      [self.undoManager redo];
    }
}

- (void) onCustomBarButtonHit:(CommandBarButton *)barButton
{
  [[barButton command] execute];
}



- (void) setScribble:(Scribble *)aScribble
{
  if (_scribble != aScribble)
  {
    
    _scribble = aScribble ;
    
    // add itself to the scribble as
    // an observer for any changes to
    // its internal state - mark
    [_scribble addObserver:self
                forKeyPath:@"mark"
                   options:NSKeyValueObservingOptionInitial |
                           NSKeyValueObservingOptionNew
                   context:nil];
  }
}

#pragma mark -
#pragma mark Stroke color and size accessor methods

- (void) setStrokeSize:(CGFloat) aSize
{
  // enforce the smallest size
  // allowed
  if (aSize < 5.0)
  {
    _strokeSize = 5.0;
  }
  else
  {
      _strokeSize = aSize;
  }
}

#pragma mark -
#pragma mark Loading a CanvasView from a CanvasViewGenerator

- (void) loadCanvasViewWithGenerator:(CanvasViewGenerator *)generator
{
  [_canvasView removeFromSuperview];
  CGRect aFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
  CanvasView *aCanvasView = [generator canvasViewWithFrame:aFrame];
  [self setCanvasView:aCanvasView];
  NSInteger viewIndex = [[[self view] subviews] count] - 1;
  [[self view] insertSubview:_canvasView atIndex:viewIndex];
}

#pragma mark -
#pragma mark Touch Event Handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  _startPoint = [[touches anyObject] locationInView:_canvasView];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint lastPoint = [[touches anyObject] previousLocationInView:_canvasView];
  
  // add a new stroke to scribble
  // if this is indeed a drag from
  // a finger
  if (CGPointEqualToPoint(lastPoint, _startPoint))
  {
    id <Mark> newStroke = [[Stroke alloc] init];
    [newStroke setColor:_strokeColor];
    [newStroke setSize:_strokeSize];
    
    //[scribble_ addMark:newStroke shouldAddToPreviousMark:NO];
    
    // retrieve a new NSInvocation for drawing and
    // set new arguments for the draw command
    NSInvocation *drawInvocation = [self drawScribbleInvocation];
    [drawInvocation setArgument:&newStroke atIndex:2];
    
    // retrieve a new NSInvocation for undrawing and
    // set a new argument for the undraw command
    NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
    [undrawInvocation setArgument:&newStroke atIndex:2];
    
    // execute the draw command with the undraw command
    [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
  }
  
  // add the current touch as another vertex to the
  // temp stroke
  CGPoint thisPoint = [[touches anyObject] locationInView:_canvasView];
  Vertex *vertex = [[Vertex alloc]
                     initWithLocation:thisPoint];
  
  // we don't need to undo every vertex
  // so we are keeping this
  [_scribble addMark:vertex shouldAddToPreviousMark:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  CGPoint lastPoint = [[touches anyObject] previousLocationInView:_canvasView];
  CGPoint thisPoint = [[touches anyObject] locationInView:_canvasView];

  // if the touch never moves (stays at the same spot until lifted now)
  // just add a dot to an existing stroke composite
  // otherwise add it to the temp stroke as the last vertex
  if (CGPointEqualToPoint(lastPoint, thisPoint))
  {
    Dot *singleDot = [[Dot alloc]
                       initWithLocation:thisPoint];
    [singleDot setColor:_strokeColor];
    [singleDot setSize:_strokeSize];

    //[scribble_ addMark:singleDot shouldAddToPreviousMark:NO];

    // retrieve a new NSInvocation for drawing and
    // set new arguments for the draw command
    NSInvocation *drawInvocation = [self drawScribbleInvocation];
    [drawInvocation setArgument:&singleDot atIndex:2];

    // retrieve a new NSInvocation for undrawing and
    // set a new argument for the undraw command
    NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
    [undrawInvocation setArgument:&singleDot atIndex:2];

    // execute the draw command with the undraw command
    [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
  }

  // reset the start point here
  _startPoint = CGPointZero;
  
  // if this is the last point of stroke
  // don't bother to draw it as the user
  // won't tell the difference
}



- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  // reset the start point here
  _startPoint = CGPointZero;
}

#pragma mark -
#pragma mark Scribble observer method

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context
{
  if ([object isKindOfClass:[Scribble class]] &&
      [keyPath isEqualToString:@"mark"])
  {
    id <Mark> mark = [change objectForKey:NSKeyValueChangeNewKey];
//      if (![mark isEqual:[NSNull null]]) {
          [_canvasView setMark:[(Scribble *)object newMark]];
          [_canvasView setNeedsDisplay];
//      }
    
    
  }
}

#pragma mark -
#pragma mark Draw Scribble Invocation Generation Methods

- (NSInvocation *) drawScribbleInvocation
{
  NSMethodSignature *executeMethodSignature = [_scribble
                                               methodSignatureForSelector:
                                               @selector(addMark:
                                                         shouldAddToPreviousMark:)];
  NSInvocation *drawInvocation = [NSInvocation
                                  invocationWithMethodSignature:
                                  executeMethodSignature];
  [drawInvocation setTarget:_scribble];
  [drawInvocation setSelector:@selector(addMark:shouldAddToPreviousMark:)];
  BOOL attachToPreviousMark = NO;
  [drawInvocation setArgument:&attachToPreviousMark atIndex:3];
  
  return drawInvocation;
}

- (NSInvocation *) undrawScribbleInvocation
{
  NSMethodSignature *unexecuteMethodSignature = [_scribble
                                                 methodSignatureForSelector:
                                                 @selector(removeMark:)];
  NSInvocation *undrawInvocation = [NSInvocation
                                    invocationWithMethodSignature:
                                    unexecuteMethodSignature];
  [undrawInvocation setTarget:_scribble];
  [undrawInvocation setSelector:@selector(removeMark:)];
  
  return undrawInvocation;
}

#pragma mark Draw Scribble Command Methods

- (void) executeInvocation:(NSInvocation *)invocation
        withUndoInvocation:(NSInvocation *)undoInvocation
{
  [invocation retainArguments];

  [[self.undoManager prepareWithInvocationTarget:self]
   unexecuteInvocation:undoInvocation
   withRedoInvocation:invocation];
  
  [invocation invoke];
}

- (void) unexecuteInvocation:(NSInvocation *)invocation
          withRedoInvocation:(NSInvocation *)redoInvocation
{
  [[self.undoManager prepareWithInvocationTarget:self]
   executeInvocation:redoInvocation
   withUndoInvocation:invocation];
  
  [invocation invoke];
}
@end
