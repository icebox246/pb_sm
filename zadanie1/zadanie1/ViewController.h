//
//  ViewController.h
//  zadanie1
//
//  Created by Adam on 05/10/2024.
//

#import <UIKit/UIKit.h>

#import "SecondViewController.h"

@interface ViewController : UIViewController <SecondViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel* messageLabel;
@property (nonatomic, weak) IBOutlet UITextField* nameField;
@property (nonatomic, weak) IBOutlet UITextField* surnameField;

- (IBAction)enter:(id)sender;

@end

