//
//  ViewController.m
//  zadanie2
//
//  Created by Adam on 10/10/2024.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_informationButton setTitle:@"Information" forState:UIControlStateNormal];
}

- (IBAction)buttonClicked:(id)sender {
    UIAlertController *alertDialog= [UIAlertController alertControllerWithTitle:@"Information"
                                                                        message:[NSString stringWithFormat:@"The faculty is running %i programs at graduate and undergraduate level.",4]
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction=[UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action){}];
    
    [alertDialog addAction:defaultAction];
    
    [self presentViewController:alertDialog animated:YES completion:nil];
}

@end
