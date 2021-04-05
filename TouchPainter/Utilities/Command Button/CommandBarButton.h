//
//  CommandBarButton.h
//  TouchPainter
//
//  Created by hicodeboy on 2021/4/4.
//

#import <UIKit/UIKit.h>
#import "Command.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommandBarButton : UIBarButtonItem
@property (nonatomic, strong) IBOutlet Command *command;
@end

NS_ASSUME_NONNULL_END
