//
//  AppDelegate.h
//  GPSIN
//
//  Created by Nikola Tonkev on 2014-08-21.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) KeychainItemWrapper *keychain;


@end

