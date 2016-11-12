//
//  DrawPadViewController.h
//  PocketWingman
//
//  Created by Jef DeWitt on 3/16/15.
//  Copyright (c) 2015 Jef DeWitt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class GameViewController;

@interface DrawPadViewController : UIViewController {
    CGPoint buttonBounds;
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
}

@property (nonatomic) ViewController *viewController;
@property (nonatomic) GameViewController *gameViewController;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic) NSArray *instructions;
@property (nonatomic) NSMutableArray *instructionsSetTwo;

@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *pencilButton;
@property (weak, nonatomic) IBOutlet UIButton *eraserButton;

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempImage;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *connectTheDots;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageViewTwo;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageViewThree;


- (IBAction)yesPressed:(id)sender;
- (IBAction)noPressed:(id)sender;

- (IBAction)pencilPressed:(id)sender;
- (IBAction)eraserPressed:(id)sender;
- (IBAction)donePressed:(id)sender;

@end
