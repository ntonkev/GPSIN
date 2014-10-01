//
//  GoogleToken.m
//  GPSIN
//
//  Created by Nikola Tonkev on 2014-09-30.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

#include "GoogleToken.h"

@implementation GoogleToken{

}

@synthesize access_token, expires_in, id_token, refresh_token, token_type;


-(id)initWithAccessToken: (NSString *)accs_tkn withExpiredIn: (NSInteger)expIn withIdTkn: (NSString *)id_tkn withRefTkn: (NSString *)ref_tkn withTknType: (NSString *)tkn_type
{
    if (self = [super init])
    {
        [self setAccess_token:accs_tkn];
        [self setExpires_in:expIn];
        [self setId_token:id_tkn];
        [self setRefresh_token:ref_tkn];
        [self setToken_type:tkn_type];
    }
    return self;
}

-(NSString *)description{
    NSString *result = [NSString stringWithFormat:@"\n\nGoogleToken {\naccess_token = %@\nexpires_in = %d\nid_token = %@\nrefresh_token = %@\ntoken_type = %@\n}", self.access_token, self.expires_in, self.id_token, self.refresh_token, self.token_type];
    return result;
}


@end
