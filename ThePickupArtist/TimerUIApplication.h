//
//  TimerUIApplication.h
//  PocketWingman
//
//  Created by Jef DeWitt on 6/28/15.
//  Copyright (c) 2015 Jef DeWitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//the length of time before your application "times out". This number actually represents seconds, so we'll have to multiply it by 6 in the .m file for a total of 30 seconds
#define kApplicationTimeoutInMinutes 5

//the notification your AppDelegate needs to watch for in order to know that it has indeed "timed out"
#define kApplicationDidTimeoutNotification @"AppTimeOut"

@interface TimerUIApplication : UIApplication
{
    NSTimer     *myidleTimer;
}

-(void)resetIdleTimer;

@end
