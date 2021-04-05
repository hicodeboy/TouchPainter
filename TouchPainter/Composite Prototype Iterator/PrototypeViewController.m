//
//  PrototypeViewController.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "PrototypeViewController.h"
#import "Mark.h"
#import "CanvasView.h"

@interface PrototypeViewController ()

@end

@implementation PrototypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    id <Mark> selectedMark;
    NSMutableArray *templateArray = [[NSMutableArray alloc] initWithCapacity:1];
    id <Mark> patternTemplate = [selectedMark copy];
    
    // save the patternTemplate in
    // a data structure so it can be
    // used later
    [templateArray addObject:patternTemplate];
    
    CanvasView *canvasView;
    id <Mark> currentMark;
    int patternIndex = 0;
    
    id <Mark> patternClone = [templateArray objectAtIndex:patternIndex];
    [currentMark addMark:patternClone];
    [canvasView setMark:currentMark];
    [canvasView setNeedsDisplay];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
