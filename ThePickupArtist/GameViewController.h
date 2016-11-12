//
//  GameViewController.h
//  PocketWingman
//
//  Created by Jef DeWitt on 3/21/15.
//  Copyright (c) 2015 Jef DeWitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@class DrawPadViewController;
@class ViewController;

@interface GameViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic) NSArray *instructions;
@property (nonatomic) NSMutableArray *instructionsSetTwo;
@property (nonatomic) NSMutableArray *instructionsSetThree;
@property (nonatomic) NSMutableArray *instructionsSetFour;


@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;

@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIButton *threeButton;
@property (weak, nonatomic) IBOutlet UIButton *fourButton;
@property (weak, nonatomic) IBOutlet UIButton *fiveButton;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTwo;

@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *startOverButton;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageViewFour;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageViewFive;



- (IBAction)oneButtonPress:(id)sender;
- (IBAction)twoButtonPress:(id)sender;
- (IBAction)threeButtonPress:(id)sender;
- (IBAction)fourButtonPress:(id)sender;
- (IBAction)fiveButtonPress:(id)sender;

- (IBAction)yesPressed:(id)sender;
- (IBAction)noPressed:(id)sender;

- (IBAction)okPressed:(id)sender;
//- (IBAction)startOverPressed:(id)sender;

@end
