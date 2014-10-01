//
//  GoogleUserInfo.h
//  GPSIN
//
//  Created by Nikola Tonkev on 2014-09-30.
//  Copyright (c) 2014 nousdynamics.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoogleUserInfo : NSObject {}

@property (nonatomic, strong) NSString *family_name;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *given_name;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *locale;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *picture;

-(id)initWithNSDictionary: (NSDictionary *)data;
-(NSString *)description;

@end

