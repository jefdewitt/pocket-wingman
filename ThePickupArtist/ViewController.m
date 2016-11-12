//
//  ViewController.m
//  PocketWingman
//
//  Created by Jef DeWitt on 3/13/15.
//  Copyright (c) 2015 Jef DeWitt. All rights reserved.
//

#import "ViewController.h"
#import "DrawPadViewController.h"
#import "GameViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];

    self.instructions = [[NSArray alloc] initWithObjects:
                        @"Hey, do me a favor and press my button.",
                        @"All right, give me a shake.",
                        @"Thanks, I needed that.  How about a pinch?",
                        @"OUCH!",
                        @"Let's try something less painful.  Swipe my button below.", // end first view
                         
                        @"Will you finish a drawing for me?  It's connect the dots.",
                         
                        @"Coz I don't have any fingers.",
                         
                        @"Great!  Tap the pencil to start.  Tap the eraser to start over.",
                        @"Oh, c'mon.  Just give it a shot.  Touch the pencil to start.",
                        @"Hmm, lemme see...",
                        @"Whoa...",
                        @"It's so beautiful!",  // end second view
                        @"Hang on a sec.  I wanna show you a trick.",
                        @"Pick one of these numbers and I'll try to guess it.  I won't look, I promise.",
                        @"Okay, just a moment here.  I need time to think...",
                        @"Whoa, really???",
                        @"Haha!  I'm good!",
                        @"Well, I guess I'm not so good at guessing numbers.",
                        @"How about you just give me yours?",
                        @"Let's try again.  Pick a new number.",
                        nil];
    
    self.instructionsSetTwo = [[NSMutableArray alloc] initWithObjects:
                        @"Did you choose #1?",
                        @"Was it #2?",
                        @"How about #3?",
                        @"If I were a betting iPhone, and I am, I'd say it was #4.",
                        @"It was #5, wasn't it?",
                        nil];
    
    self.textLabel.text = self.instructions[0];
    self.buttonTwo.hidden = YES;
    self.bgImageViewOne.hidden = YES;

}

- (IBAction)buttonPress:(id)sender {
    
        self.textLabel.text = self.instructions[1];
        self.button.hidden = YES;

}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (self.button.hidden == YES) {
        self.textLabel.text = self.instructions[2];
        UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchWithGestureRecognizer:)];
        [self.view addGestureRecognizer:pinchGestureRecognizer];
        self.button.hidden = YES;
    }

}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if ( motion == UIEventSubtypeMotionShake) {
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if ( motion == UIEventSubtypeMotionShake) {
    }
}

-(void)handlePinchWithGestureRecognizer:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    
    pinchGestureRecognizer.scale = 1.0;
    
    self.bgImageViewOne.hidden = NO;
    self.textLabel.textColor = [UIColor colorWithRed:(251/255.0) green:(111/255.0) blue:(115/255.0) alpha:1];
    self.textLabel.text = self.instructions[3];
    [self hideBGImageViewOne];
    
    if ([self respondsToSelector:@selector(timeout)]) {
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
    }
    else {
        
    }
}

- (void)timeout {
    self.textLabel.textColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
    self.textLabel.text = self.instructions[4];
    self.buttonTwo.hidden = NO;
    
//    “Pushing the same view controller instance more than once is not supported” exception fix
//    if(![self.navigationController.topViewController isKindOfClass:[DrawPadViewController class]]) {
//        [self.navigationController pushViewController:self.drawPadViewController animated:YES];
//    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showDrawPadViewController"]){
        DrawPadViewController *drawPadViewController = (DrawPadViewController *)segue.destinationViewController;
        drawPadViewController.instructions = self.instructions;
        drawPadViewController.instructionsSetTwo = self.instructionsSetTwo;
        
    }
    if([segue.identifier isEqualToString:@"showGameiewController"]){
        GameViewController *gameViewController = (GameViewController *)segue.destinationViewController;
        gameViewController.instructionsSetThree = self.instructionsSetThree;
        gameViewController.instructionsSetFour = self.instructionsSetFour;
        
    }
}

- (void) hideBGImageViewOne {
    [UIView transitionWithView:self.bgImageViewOne
                      duration:2.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.bgImageViewOne setAlpha:0];
                    } completion:NULL];
}

- (IBAction)buttonTwo:(id)sender {
    // Swipe that leads to segue for next view
    [self performSegueWithIdentifier:@"showDrawPadViewController" sender:self];
}

@end
