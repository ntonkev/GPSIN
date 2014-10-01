//
//  GoogleToken.h
//  GPSIN
//
//  Created by Nikola Tonkev on 2014-09-30.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoogleToken : NSObject {}

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, assign) NSInteger expires_in;
@property (nonatomic, strong) NSString *id_token;
@property (nonatomic, strong) NSString *refresh_token;
@property (nonatomic, strong) NSString *token_type;

-(id)initWithAccessToken: (NSString *)accs_tkn withExpiredIn: (NSInteger)expIn withIdTkn: (NSString *)id_tkn withRefTkn: (NSString *)ref_tkn withTknType: (NSString *)tkn_type;
-(NSString *)description;

@end
