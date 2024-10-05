//
//  SecondViewController.m
//  zadanie1
//
//  Created by Adam on 05/10/2024.
//

#import "SecondViewController.h"

@implementation SecondViewController

- (void)viewDidLoad {
    self.modifiedSurnameField.text = self.surname;
}

-(void)goBack:(id)sender {
    NSString* itemToPass = self.modifiedSurnameField.text;
    [self.delegate addItemViewController:self didFinishEnteringItem:itemToPass];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
