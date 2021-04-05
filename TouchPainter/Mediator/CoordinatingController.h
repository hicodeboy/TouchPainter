//
//  CoordinatingController.h
//  TouchPainter
//
//  Created by hello on 2021/4/3.
//

#import <Foundation/Foundation.h>
#import "CanvasViewController.h"
#import "ThumbnailViewController.h"
#import "PaletteViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoordinatingController : NSObject
@property (nonatomic, strong) UIViewController *activeViewController;
@property (nonatomic, strong) CanvasViewController *canvasViewController;

+ (instancetype) sharedInstance;
- (void)requestViewChangeByObject:(id)sender;

@end

NS_ASSUME_NONNULL_END
