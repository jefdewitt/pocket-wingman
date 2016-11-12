//
//  ViewController.h
//  PocketWingman
//
//  Created by Jef DeWitt on 3/13/15.
//  Copyright (c) 2015 Jef DeWitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@class DrawPadViewController;
@class GameViewController;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic) NSArray *instructions;
@property (nonatomic) NSMutableArray *instructionsSetTwo;
@property (nonatomic) NSMutableArray *instructionsSetThree;
@property (nonatomic) NSMutableArray *instructionsSetFour;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageViewOne;

- (IBAction)buttonPress:(id)sender;

@end

