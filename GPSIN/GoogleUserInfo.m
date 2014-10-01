//
//  GoogleUserInfo.m
//  GPSIN
//
//  Created by Nikola Tonkev on 2014-09-30.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleUserInfo.h"

@implementation GoogleUserInfo{
    
}

@synthesize family_name, gender, given_name, id, name, link, picture, locale;


-(id)initWithNSDictionary:(NSDictionary *)data
{
    if (self = [super init])
    {
        [self setFamily_name: [data valueForKey:@"family_name"]];
        [self setName: [data valueForKey:@"name"]];
        [self setGender: [data valueForKey:@"gender"]];
        [self setGiven_name: [data valueForKey:@"given_name"]];
        [self setId: [data valueForKey:@"id"]];
        [self setLink: [data valueForKey:@"link"]];
        [self setLocale: [data valueForKey:@"locale"]];
        [self setPicture: [data valueForKey:@"picture"]];
    }
    return self;
}

-(NSString *)description{
    NSString *result = [NSString stringWithFormat:@"\n\nGoogleUserInfo {\nname = %@\nfamily_name = %@\ngender = %@\ngiven_name = %@\nid = %@\nlink = %@\nlocale = %@\npicture = %@\n}", self.name, self.family_name, self.gender, self.given_name, self.id, self.link, self.locale, self.picture];
    return result;
}


@end
