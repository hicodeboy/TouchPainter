//
//  PaletteViewController.m
//  TouchPainter
//
//  Created by hello on 2021/4/3.
//

#import "PaletteViewController.h"
#import "CommandSlider.h"
#import "SetStrokeColorCommand.h"
#import "SetStrokeSizeCommand.h"

@interface PaletteViewController () <SetStrokeColorCommandDelegate, SetStrokeSizeCommandDelegate>
@property (weak, nonatomic) IBOutlet CommandSlider *redSlider;
@property (weak, nonatomic) IBOutlet CommandSlider *greenSlider;
@property (weak, nonatomic) IBOutlet CommandSlider *blueSlider;
@property (weak, nonatomic) IBOutlet CommandSlider *sizeSlider;

@property (weak, nonatomic) IBOutlet UIView *paletteView;

@end

@implementation PaletteViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SetStrokeColorCommand *colorCommand = [[SetStrokeColorCommand alloc] init];
    colorCommand.delegate = self;
    __weak typeof(self) weakSelf = self;
    [colorCommand setRGBValuesProvider:^(CGFloat *red, CGFloat *green, CGFloat *blue) {
        *red = [weakSelf.redSlider value];
        *green = [weakSelf.greenSlider value];
        *blue = [weakSelf.blueSlider value];
    }];
    
    [colorCommand setPostColorUpdateProvider:^(UIColor *color) {
        weakSelf.paletteView.backgroundColor = color;
    }];
    
    _redSlider.command = colorCommand;
    _greenSlider.command = colorCommand;
    _blueSlider.command = colorCommand;
    
    
    SetStrokeSizeCommand *sizeCommand = [[SetStrokeSizeCommand alloc] init];
    sizeCommand.delegate = self;
    _sizeSlider.command = sizeCommand;
    
    
    
    
    // restore the original values of the sliders
    // and the color of the small palette view
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat redValue = [userDefaults floatForKey:@"red"];
    CGFloat greenValue = [userDefaults floatForKey:@"green"];
    CGFloat blueValue = [userDefaults floatForKey:@"blue"];
    CGFloat sizeValue = [userDefaults floatForKey:@"size"];
    
    [_redSlider setValue:redValue];
    [_greenSlider setValue:greenValue];
    [_blueSlider setValue:blueValue];
    [_sizeSlider setValue:sizeValue];
    
    UIColor *color = [UIColor colorWithRed:redValue
                                     green:greenValue
                                      blue:blueValue
                                     alpha:1.0];
    
    [_paletteView setBackgroundColor:color];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setFloat:[_redSlider value] forKey:@"red"];
    [userDefaults setFloat:[_greenSlider value] forKey:@"green"];
    [userDefaults setFloat:[_blueSlider value] forKey:@"blue"];
    [userDefaults setFloat:[_sizeSlider value] forKey:@"size"];
    [userDefaults synchronize];
}

- (IBAction)onCommandSliderValueChanged:(CommandSlider *)sender {
    [[sender command] execute];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)command:(SetStrokeColorCommand *)command didRequestColorComponentsForRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue {
    *red = [_redSlider value];
    *green = [_greenSlider value];
    *blue = [_blueSlider value];
}

- (void)command:(SetStrokeColorCommand *)command
didFinishColorUpdateWithColor:(UIColor *)color {
    _paletteView.backgroundColor = color;
}



- (void) command:(SetStrokeSizeCommand *)command
didRequestForStrokeSize:(CGFloat *)size {
    *size = _sizeSlider.value;
}


@end
