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

//static NSString * const kClientId = @"755255343089-oah0n3irag6sbho9hsu0g7t33th5vjhf.apps.googleusercontent.com";
static NSString * const kClientId = @"783241267105-s1si6l0t9h1dat18gih2j5bphg7st307.apps.googleusercontent.com";
static NSString * const kServerClientId = @"783241267105-s1si6l0t9h1dat18gih2j5bphg7st307.apps.googleusercontent.com";
static NSString * const kSecret = @"MbSGiXXwLPaanFbJSVseW9qs";

NSMutableData *responsData;



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Received %d bytes of data",[responsData length]);
    NSString *str = [[NSString alloc] initWithData:responsData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@\n", error.description);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responsData setLength:0];
    NSLog(@"%@\n", response.description);
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responsData appendData:data];
}

- (void)doRequestCallback: (NSString *)code {
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"https://dry-atoll-6423.herokuapp.com/oauth2callback?code=%@", code]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:3.0];
    [request setHTTPMethod:@"POST"];
    //NSString *args = [NSString stringWithFormat:@"code=%@", code];
    
    //NSData *requestBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    //[request setHTTPBody:requestBody];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    if (connection) {
        responsData = [NSMutableData data];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self disconnect];

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
        NSLog(@"server_code: %@",serverCode);
        
        
        NSString  *accessTocken = [auth valueForKey:@"accessToken"]; // access tocken pass in .pch file
        NSLog(@"accessTocken: %@",accessTocken);

        //request
        NSString  *code = [auth valueForKey:@"code"]; // access tocken pass in .pch file
        [self doRequestCallback: code];
        
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
