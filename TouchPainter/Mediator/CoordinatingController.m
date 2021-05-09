//
//  CoordinatingController.m
//  TouchPainter
//
//  Created by hello on 2021/4/3.
//

typedef enum
{
  kButtonTagDone,
    kButtonTagOpenThumbnailView = 3,
  kButtonTagOpenPaletteView = 4,
  
} ButtonTag;

#import "CoordinatingController.h"
#import "Mark.h"
#import "PaletteViewController.h"
#import "ThumbnailViewController.h"

@implementation CoordinatingController


- (void) initialize
{
  
  _activeViewController = _canvasViewController;
}

+ (instancetype)sharedInstance {
    static CoordinatingController *sharedCoordinator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCoordinator = [[super allocWithZone:NULL] init];
        [sharedCoordinator initialize];
    });
    return sharedCoordinator;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (instancetype)copy {
    return self;
}

- (void)requestViewChangeByObject:(id)sender {
    if ([sender isKindOfClass:[UIBarButtonItem class]])
    {
      switch ([(UIBarButtonItem *)sender tag])
      {
          case kButtonTagOpenPaletteView:
          {
              PaletteViewController *controller = (PaletteViewController *)[self controllerWithIdentifier:@"PaletteViewController"];
            
              [_canvasViewController presentViewController:controller animated:YES completion:^{
                  
              }];
            
            // set the activeViewController to
            // paletteViewController
            _activeViewController = controller;
          }
            break;
          case kButtonTagOpenThumbnailView:
          {
              ThumbnailViewController *controller = (ThumbnailViewController *)[self controllerWithIdentifier:@"ThumbnailViewController"];
            
            // transition to the PaletteViewController
              [_activeViewController presentViewController:controller animated:YES completion:^{
                  
              }];
            
            // set the activeViewController to
            // paletteViewController
            _activeViewController = controller;
          }
            break;
          default:
          {
              [_canvasViewController dismissViewControllerAnimated:YES completion:^{
                  
              }];
            _activeViewController = _canvasViewController;
          }
              break;
            
      }
        
    } // every thing else goes to the main canvasViewController
    else
    {
        [self.canvasViewController.navigationController popViewControllerAnimated:true];
      
      // set the activeViewController back to
      // canvasViewController
      _activeViewController = _canvasViewController;
    }
}

- (UIViewController *)controllerWithIdentifier:(NSString *)identifier {
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = [mainStory instantiateViewControllerWithIdentifier:identifier];
    return controller;
}


@end
