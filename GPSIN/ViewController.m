//
//  ViewController.m
//  GPSIN
//
//  Created by Nikola Tonkev on 2014-08-21.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

#import "ViewController.h"
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize signInButton;
@synthesize signOutButton;
@synthesize keychainWrapper;

//static NSString * const kClientId = @"755255343089-oah0n3irag6sbho9hsu0g7t33th5vjhf.apps.googleusercontent.com";
static NSString * const kClientId = @"783241267105-s1si6l0t9h1dat18gih2j5bphg7st307.apps.googleusercontent.com";
static NSString * const kServerClientId = @"783241267105-bc7pq09tr1nnogat72r9tgmaeg2mre28.apps.googleusercontent.com";
static NSString * const kSecret = @"MbSGiXXwLPaanFbJSVseW9qs";

NSMutableData *responsData;


-(void)doRegisterUser: (NSString *)access_token {
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://dry-atoll-6423.herokuapp.com/registeruser?access_token=%@", access_token]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    [NSURLConnection sendAsynchronousRequest:request queue: [NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSMutableDictionary * jsonResult = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableLeaves error:nil];
        
        GoogleUserInfo *googleUserInfo = [[GoogleUserInfo alloc] initWithNSDictionary:jsonResult];
        NSLog([googleUserInfo description]);
        //[self doRegisterUser: googleToken.access_token];
    }];
}

-(void)doRequestCallback: (NSString *)serverCode {
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://dry-atoll-6423.herokuapp.com/oauth2callback?code=%@", serverCode]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    [NSURLConnection sendAsynchronousRequest:request queue: [NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSMutableDictionary * jsonResult = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableLeaves error:nil];
        
        GoogleToken *googleToken = [[GoogleToken alloc] initWithAccessToken:[jsonResult valueForKey:@"access_token"] withExpiredIn:[jsonResult valueForKey:@"expires_in"] withIdTkn:[jsonResult valueForKey:@"id_token"] withRefTkn:[jsonResult valueForKey:@"refresh_token"] withTknType:[jsonResult valueForKey:@"token_type"]];
        NSLog([googleToken description]);
        [keychainWrapper  setObject:googleToken.access_token forKey:(__bridge id)kSecValueData];
        [self doRegisterUser: googleToken.access_token];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    id token = [keychainWrapper objectForKey:(__bridge id)kSecValueData];
    if([keychainWrapper objectForKey:(__bridge id)(kSecValueData)]){
        //NSLog([token  getValue]);
        NSLog(@"It's there: %@", [keychainWrapper objectForKey:(__bridge id)(kSecValueData)]);
    }
//    else{
//        [keychainWrapper  setObject:@"token" forKey:(__bridge id)kSecValueData];
//    }
    
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
   
    
    signIn.clientID = kClientId;
    signIn.homeServerClientID = kServerClientId;
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];

    signIn.delegate = self;
    //[signIn trySilentAuthentication];
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    //NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Do some error handling here.
    } else {
        NSString *serverCode = [GPPSignIn sharedInstance].homeServerAuthorizationCode;
        [self doRequestCallback: serverCode];
        
    }
}



- (void)disconnect {
    [[GPPSignIn sharedInstance] disconnect];
}

- (void)didDisconnectWithError:(NSError *)error {
    if (error) {
        NSLog(@"Received error %@", error);
    } else {
        // The user is signed out and disconnected.
        // Clean up user data as specified by the Google+ terms.
    }
}

- (void)presentSignInViewController:(UIViewController *)viewController {
    // This is an example of how you can implement it if your app is navigation-based.
    [[self navigationController] pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signOutButton_TouchUpInside:(id)sender {
    [self disconnect];
    
}

@end
