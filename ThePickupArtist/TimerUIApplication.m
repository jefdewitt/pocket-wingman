//
//  TimerUIApplication.m
//  PocketWingman
//
//  Created by Jef DeWitt on 6/28/15.
//  Copyright (c) 2015 Jef DeWitt. All rights reserved.
//

#import "TimerUIApplication.h"

@implementation TimerUIApplication

//here we are listening for any touch. If the screen receives touch, the timer is reset
-(void)sendEvent:(UIEvent *)event
{
    [super sendEvent:event];
    
    if (!myidleTimer)
    {
        [self resetIdleTimer];
    }
    
    NSSet *allTouches = [event allTouches];
    if ([allTouches count] > 0)
    {
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
        if (phase == UITouchPhaseBegan)
        {
            [self resetIdleTimer];
        }
        
    }
}
//as labeled...reset the timer
-(void)resetIdleTimer
{
    if (myidleTimer)
    {
        [myidleTimer invalidate];
    }
    //multiply this number by 5 from the .h file for a total of 30 seconds
    int timeout = kApplicationTimeoutInMinutes * 6;
    myidleTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(idleTimerExceeded) userInfo:nil repeats:NO];
    
}
// if the timer reaches the limit as defined in kApplicationTimeoutInMinutes, post this notification
// return to starting view
-(void)idleTimerExceeded
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kApplicationDidTimeoutNotification object:nil];
}


@end
