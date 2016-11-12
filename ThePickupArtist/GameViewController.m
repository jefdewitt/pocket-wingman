//
//  GameViewController.m
//  PocketWingman
//
//  Created by Jef DeWitt on 3/21/15.
//  Copyright (c) 2015 Jef DeWitt. All rights reserved.
//

#import "GameViewController.h"
#import "ViewController.h"
#import "DrawPadViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    self.textFieldTwo.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    
    self.textLabel.text = self.instructions[12];

    [self hideYesAndNoButtons];
    [self hideFields];
    [self hideNumbers];
    self.startOverButton.hidden = YES;
    self.bgImageViewFour.hidden = YES;
    self.bgImageViewFive.hidden = YES;
    
    if ([self respondsToSelector:@selector(gamePrompt)]) {
        [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(gamePrompt) userInfo:nil repeats:NO];
    }
    else {
        
    }
}

-(void) gamePrompt {
    self.textLabel.text = self.instructions[13];
    [self showNumbers];
}

- (IBAction)oneButtonPress:(id)sender {
    [self numberInstructionCombo];
}

- (IBAction)twoButtonPress:(id)sender {
    [self numberInstructionCombo];
}

- (IBAction)threeButtonPress:(id)sender {
    [self numberInstructionCombo];
}

- (IBAction)fourButtonPress:(id)sender {
    [self numberInstructionCombo];
}

- (IBAction)fiveButtonPress:(id)sender {
    [self numberInstructionCombo];
}

-(void) numberInstructionCombo {
    [self hideNumbers];
    self.textLabel.text = self.instructions[14];
    
    if ([self respondsToSelector:@selector(numberPlusInstruction)]) {
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(numberPlusInstruction) userInfo:nil repeats:NO];
    }
    else {
        
    }
}

- (IBAction)noPressed:(id)sender {
    [self hideYesAndNoButtons];
    [self hideNumbers];
    self.textLabel.text = self.instructions[15];
    
    if ([self respondsToSelector:@selector(replyTwo)]) {
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(replyTwo) userInfo:nil repeats:NO];
    }
    else {
       
    }
}

- (IBAction)yesPressed:(id)sender {
    [self hideYesAndNoButtons];
    [self hideNumbers];
    self.textLabel.text = self.instructions[16];
    
    if ([self respondsToSelector:@selector(replyThree)]) {
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(replyThree) userInfo:nil repeats:NO];
    }
    else {
        
    }
}

- (void) replyTwo {
    self.textLabel.text = self.instructions[17];
    [self hideYesAndNoButtons];
    
    if ([self respondsToSelector:@selector(almostTheEnd)]) {
        [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(almostTheEnd) userInfo:nil repeats:NO];
    }
    else {
        
    }
}

- (void) almostTheEnd {
    self.textLabel.text = self.instructions[18];
    [self hideYesAndNoButtons];
    
    if ([self respondsToSelector:@selector(theEnd)]) {
        [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(theEnd) userInfo:nil repeats:NO];
    }
    else {
        
    }
}

- (void) replyThree {
    self.textLabel.text = self.instructions[19];
    [self showNumbers];
    [self hideYesAndNoButtons];
}

- (IBAction)okPressed:(id)sender {
    
    if ( (self.textFieldTwo.text.length > 0) && (self.textField.text.length >= 10) ) {
    
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions( NULL, nil ); // create address book record
        
        ABRecordRef person = ABPersonCreate(); // create a person
        
        NSString *phone = self.textField.text; // the phone number to add
        NSString *newName = self.textFieldTwo.text; // the name to add
        
        //Phone number is a list of phone number, so create a multivalue
        ABMutableMultiValueRef phoneNumberMultiValue  = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(phoneNumberMultiValue, (__bridge CFTypeRef)(phone), kABPersonPhoneMobileLabel, NULL);
        
        
        ABRecordSetValue(person, kABPersonFirstNameProperty, (__bridge CFTypeRef)(newName) , nil); // first name of the new person
        ABRecordSetValue(person, kABPersonLastNameProperty, @"From Pocket Wingman", nil); // last name
        ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil); // set the phone number property
        ABAddressBookAddRecord(addressBook, person, nil); //add the new person to the record
        
        ABRecordRef group = ABGroupCreate(); //create a group
        ABRecordSetValue(group, kABGroupNameProperty,@"My Pocket Wingman Group", nil); // set group's name
        ABGroupAddMember(group, person, nil); // add the person to the group
        ABAddressBookAddRecord(addressBook, group, nil); // add the group
        
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    // First time access has been granted, add the contact
                    ABAddressBookSave(addressBook, nil);
                   
                    [self showAccessGrantedImage];
                    
                } else {
                    // User denied access
                    // Display an alert telling user the contact could not be added
                  
                    [self showPermissionDenied];
                }
            });
        }
        else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
            // The user has previously given access, add the contact
            ABAddressBookSave(addressBook, nil);
           
            [self showAccessGrantedImage];
        }
        else
        {
           
            [self showPermissionDenied];
        }
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"For real???" message:@"I gotta have your name and all ten digits, baby." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
}

- (void) showAccessGrantedImage {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideFields];
        self.startOverButton.hidden = NO;
        self.bgImageViewFour.hidden = NO;
        [self.view endEditing:YES]; // hides keyboard
    });
    
}

- (void) showAccessDeniedImage {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideFields];
        self.startOverButton.hidden = NO;
        self.bgImageViewFive.hidden = NO;
        [self.view endEditing:YES]; // hides keyboard
    });
    
}

- (void) showPermissionDenied {
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Dang it Doug!"
                                                                   message:@"Permission has been denied.  Numbers cannot be saved until the app settings have been changed.\
                                                                       Go to: Settings > Wingman"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                                  [self showAccessDeniedImage];
                                                                }];
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    });
    

}

- (NSString*) randomInstructions {
    if (self.oneButton) {
        [self.instructionsSetTwo removeObjectAtIndex:0];
    }else if(self.twoButton) {
        [self.instructionsSetTwo removeObjectAtIndex:1];
    }else if(self.threeButton) {
        [self.instructionsSetTwo removeObjectAtIndex:2];
    }else if(self.fourButton) {
        [self.instructionsSetTwo removeObjectAtIndex:3];
    }else{
        [self.instructionsSetTwo removeObjectAtIndex:4];
    }
    int random = arc4random_uniform((uint32_t)self.instructionsSetTwo.count);
    return [self.instructionsSetTwo objectAtIndex:random];
}

- (void) numberPlusInstruction {
    self.textLabel.text = [self randomInstructions];
    [self showYesAndNoButtons];
}

- (void) theEnd {
    self.textLabel.hidden = YES;
    [self showFields];
}

- (void) hideYesAndNoButtons {
    self.yesButton.hidden = YES;
    self.noButton.hidden = YES;
}

- (void) showYesAndNoButtons {
    self.yesButton.hidden = NO;
    self.noButton.hidden = NO;
}

- (void) hideNumbers {
    self.oneButton.hidden = YES;
    self.twoButton.hidden = YES;
    self.threeButton.hidden = YES;
    self.fourButton.hidden = YES;
    self.fiveButton.hidden = YES;
}

- (void) showNumbers {
    self.oneButton.hidden = NO;
    self.twoButton.hidden = NO;
    self.threeButton.hidden = NO;
    self.fourButton.hidden = NO;
    self.fiveButton.hidden = NO;
}

- (void) hideFields{
    self.textField.hidden = YES;
    self.textFieldTwo.hidden = YES;
    self.okButton.hidden = YES;
}

- (void) showFields{
    self.textField.hidden = NO;
    self.textFieldTwo.hidden = NO;
    self.okButton.hidden = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField // brings up keyboard
{
    [self.textField resignFirstResponder];
    [self.textFieldTwo resignFirstResponder];
    
    return YES;
}

@end


