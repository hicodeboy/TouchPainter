//
//  SaveScribbleCommand.m
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import "SaveScribbleCommand.h"
#import "ScribbleManager.h"
#import "CoordinatingController.h"
#import "UIView+UIImage.h"


@implementation SaveScribbleCommand
- (void) execute
{
    CoordinatingController *coordinatingController = [CoordinatingController sharedInstance];
    CanvasViewController *canvasViewController = [coordinatingController canvasViewController];
   
    
    // finally show an alertbox that says
    // after the scribble is saved
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Your scribble is saved" message:@"" preferredStyle:UIAlertControllerStyleAlert];

    //2.添加按钮动作
        //2.1 确认按钮
        UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImage *canvasViewImage = [[canvasViewController canvasView] image];
            Scribble *scribble = [canvasViewController scribble];
            
            // use an instance of ScribbleManager
            // to save the scribble and its thumbnail
            ScribbleManager *scribbleManager = [[ScribbleManager alloc] init];
            [scribbleManager saveScribble:scribble thumbnail:canvasViewImage];
            NSLog(@"点击了确认按钮");
        }];
        //2.2 取消按钮
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消按钮");
        }];
    
    //3.将动作按钮 添加到控制器中
        [alert addAction:conform];
        [alert addAction:cancel];

    
    [canvasViewController presentViewController:alert animated:YES completion:^{
        
    }];
    
}
@end
