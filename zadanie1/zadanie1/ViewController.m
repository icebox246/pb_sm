//
//  ViewController.m
//  zadanie1
//
//  Created by Adam on 05/10/2024.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)enter:(id)sender {
    NSString* yourName = self.nameField.text;
    NSString* myName = @"Adam";
    NSString* message;
    
    if([yourName length] == 0) {
        yourName = @"World";
    }
    
    if ([yourName isEqualToString: myName]) {
        message = [NSString stringWithFormat:@"Hello %@, We have the same name!", yourName];
    } else {
        message = [NSString stringWithFormat:@"Hello %@!", yourName];
    }
    
    self.messageLabel.text = message;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"sendSurnameSegue"]) {
        SecondViewController* controller = (SecondViewController*)segue.destinationViewController;
        controller.surname = self.surnameField.text;
        controller.delegate = self;
    }
}

-(void)addItemViewController:(SecondViewController*)controller didFinishEnteringItem:(NSString *)item {
    NSLog(@"This was returned from second view controller: %@", item);
    self.surnameField.text = item;
}

@end
