//
//  DrawPadViewController.m
//  PocketWingman
//
//  Created by Jef DeWitt on 3/16/15.
//  Copyright (c) 2015 Jef DeWitt. All rights reserved.
//

#import "DrawPadViewController.h"
#import "ViewController.h"
#import "GameViewController.h"

@interface DrawPadViewController ()

@end

@implementation DrawPadViewController

- (void)viewDidLoad {
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 2.0;
    opacity = 1.0;
    
    [super viewDidLoad];
    
    self.textLabel.text = self.instructions[5];
    
    self.doneButton.hidden = YES;
    self.mainImage.hidden = YES;
    self.bgImageViewTwo.alpha = 0;
    self.bgImageViewThree.hidden = YES;
    [self hidePencilAndEraser];
    [self hideYesAndNo];
    
    for (UIButton *button in self.connectTheDots)
    {
        button.hidden = YES;
    }
    
    if ([self respondsToSelector:@selector(timeout)]) {
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
    }

}

- (void)timeout {
    
    self.textLabel.text = self.instructions[6];
    [self showYesAndNo];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
        mouseSwiped = NO;
        UITouch *touch = [touches anyObject];
        lastPoint = [touch locationInView:self.view];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
        mouseSwiped = YES;
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self.view];
        
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
        
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
        [self.mainImage setAlpha:opacity];
        UIGraphicsEndImageContext();
        
        lastPoint = currentPoint;

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
        if(!mouseSwiped) {
            UIGraphicsBeginImageContext(self.view.frame.size);
            [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextStrokePath(UIGraphicsGetCurrentContext());
            CGContextFlush(UIGraphicsGetCurrentContext());
            self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
        UIGraphicsBeginImageContext(self.mainImage.frame.size);
        [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
        UIGraphicsEndImageContext();
    
    UITouch *touched = [[event allTouches] anyObject];
    CGPoint locationRelative = [touched locationInView:self.doneButton];
    
    if (CGRectContainsPoint(self.doneButton.bounds, locationRelative)) {
        
        self.mainImage.image = nil;
        self.textLabel.hidden = NO;
        [self hidePencilAndEraser];
        self.textLabel.text = self.instructions[9];
        [self hideMainImage];
        
        if ([self respondsToSelector:@selector(timeout2)]) {
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timeout2) userInfo:nil repeats:NO];
        }
        
        for (UIButton *button in self.connectTheDots)
        {
            button.hidden = YES;
        }
    }
}

- (IBAction)yesPressed:(id)sender {
    self.textLabel.text = self.instructions[7];
    [self hideYesAndNo];
    [self showPencilAndEraser];
}

- (IBAction)noPressed:(id)sender {
    self.textLabel.text = self.instructions[8];
    [self hideYesAndNo];
    [self showPencilAndEraser];
}

- (IBAction)pencilPressed:(id)sender {
    self.textLabel.hidden = YES;
    self.mainImage.hidden = NO;
    self.doneButton.hidden = NO;
    self.mainImage.image = nil;
    self.pencilButton.userInteractionEnabled = NO;
    
    for (UIButton *button in self.connectTheDots)
    {
        button.hidden = NO;
    }
}

- (IBAction)eraserPressed:(id)sender {
    self.mainImage.image = nil;
}

- (IBAction)donePressed:(id)sender {}

- (void)timeout2 {
    [self fadeInImage];
    self.textLabel.text = self.instructions[10];
    if ([self respondsToSelector:@selector(timeout3)]) {
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeout3) userInfo:nil repeats:NO];
    }
    else {
        
    }
}

- (void)timeout3 {
    self.bgImageViewTwo.hidden = YES;
    self.bgImageViewThree.hidden = NO;
    [self hideBGImageViewTwo];
    self.textLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(163/255.0) blue:(228/255.0) alpha:1];
    self.textLabel.text = self.instructions[11];
    if ([self respondsToSelector:@selector(timeout4)]) {
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeout4) userInfo:nil repeats:NO];
    }
    else {
        
    }
}
- (void)timeout4 {
    [self hideBGImageViewThree];
    if ([self respondsToSelector:@selector(timeout5)]) {
        [NSTimer scheduledTimerWithTimeInterval:1.75 target:self selector:@selector(timeout5) userInfo:nil repeats:NO];
    }
    else {
        
    }
}

- (void)timeout5 {
    [self performSegueWithIdentifier:@"showGameViewController" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showGameViewController"]){
        GameViewController *gameViewController = (GameViewController *)segue.destinationViewController;
        gameViewController.instructions = self.instructions;
        gameViewController.instructionsSetTwo = self.instructionsSetTwo;
        
    }
}

- (void)showPencilAndEraser{
    self.pencilButton.hidden = NO;
    self.eraserButton.hidden = NO;
}

- (void)hidePencilAndEraser{
    self.pencilButton.hidden = YES;
    self.eraserButton.hidden = YES;
}

- (void)hideYesAndNo{
    self.yesButton.hidden = YES;
    self.noButton.hidden = YES;
}

- (void)showYesAndNo{
    self.yesButton.hidden = NO;
    self.noButton.hidden = NO;
}

- (void) hideMainImage {
    [UIView transitionWithView:self.mainImage
                      duration:2.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.mainImage setAlpha:0];
                    } completion:NULL];
}

- (void)fadeInImage {
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:2.0];
    self.bgImageViewTwo.alpha = 1.0;
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"fade out" context:nil];
    [UIView setAnimationDuration:3.0];
    self.textLabel.alpha = 0;
    [UIView commitAnimations];
    
}

- (void) hideBGImageViewTwo {
    [UIView transitionWithView:self.bgImageViewTwo
                      duration:2.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.bgImageViewTwo setAlpha:0];
                    } completion:NULL];
    
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:1.0];
    self.textLabel.alpha = 1.0;
    [UIView commitAnimations];
}

- (void) hideBGImageViewThree {
    [UIView transitionWithView:self.bgImageViewThree
                      duration:2.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.bgImageViewThree setAlpha:0];
                    } completion:NULL];
}

@end
