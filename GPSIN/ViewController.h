//
//  ViewController.h
//  GPSIN
//
//  Created by Nikola Tonkev on 2014-08-21.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
#include "GoogleToken.h"
#include "GoogleUserInfo.h"
#import "KeychainItemWrapper.h"

@class GPPSignInButton;


@interface ViewController : UIViewController <GPPSignInDelegate>

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;
@property (strong, nonatomic) IBOutlet UIButton *signOutButton;
@property (strong, nonatomic) KeychainItemWrapper *keychainWrapper;


- (IBAction)signOutButton_TouchUpInside:(id)sender;


@end

