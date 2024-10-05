//
//  SecondViewController.h
//  zadanie1
//
//  Created by Adam on 05/10/2024.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SecondViewController;

@protocol SecondViewControllerDelegate<NSObject>

- (void) addItemViewController:(SecondViewController*)controller didFinishEnteringItem:(NSString*) item;

@end

@interface SecondViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField* modifiedSurnameField;

@property NSString* surname;

@property (nonatomic, weak) id <SecondViewControllerDelegate> delegate;

-(IBAction)goBack:(id)sender;

@end

NS_ASSUME_NONNULL_END
