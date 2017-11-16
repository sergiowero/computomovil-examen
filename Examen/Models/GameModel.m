//
//  GameModel.m
//  PracticaTabs
//
//  Created by Virtual Box on 11/3/17.
//  Copyright © 2017 UAG. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
          @"awayName" : @"away_name",
          @"homeName" : @"home_name",
          @"awayLogo" : @"away_logo",
          @"homeLogo" : @"home_logo"
    }];
}
    
@end
