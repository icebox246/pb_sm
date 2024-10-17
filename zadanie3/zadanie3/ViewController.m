//
//  ViewController.m
//  zadanie3
//
//  Created by Adam on 17/10/2024.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self becomeFirstResponder];
    
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [tapRecognizer setNumberOfTapsRequired:3];
    [self.view addGestureRecognizer:tapRecognizer];
    
    [self.view addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)]];
    
    UISwipeGestureRecognizer* swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [swipeRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRecognizer];
    
    UILongPressGestureRecognizer* longPressRecognizer =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    [longPressRecognizer setMinimumPressDuration:2];
    [self.view addGestureRecognizer:longPressRecognizer];
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if(motion==UIEventSubtypeMotionShake) {
        [self showShakeDetectionAlert];
    }
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(IBAction)showShakeDetectionAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Shake gesture detected" message:@"Do you want to change background color" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        CGFloat hue = (CGFloat)rand() / (CGFloat)RAND_MAX;
        UIColor* color = [UIColor colorWithHue:hue saturation:0.8 brightness:1.0 alpha:1.0];
        [self.view setBackgroundColor:color];
    }];
    UIAlertAction *noButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        NSLog(@"User decided against changing background color");
    }];
    
    [alertController addAction:yesButton];
    [alertController addAction:noButton];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)tapGesture:(UITapGestureRecognizer*)sender {
    _gestureLabel.text = @"Tap detected";
}

- (IBAction)pinchGesture:(UIPinchGestureRecognizer*)sender {
    _gestureLabel.text = @"Pinch detected";
}

- (IBAction)swipeGesture:(UISwipeGestureRecognizer*)sender {
    _gestureLabel.text = @"Swipe detected";
}

- (IBAction)longPressGesture:(UILongPressGestureRecognizer*)sender {
    _gestureLabel.text = @"Long press detected";
}

@end
