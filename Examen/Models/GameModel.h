//
//  GameModel.h
//  PracticaTabs
//
//  Created by Virtual Box on 11/3/17.
//  Copyright © 2017 UAG. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol GameModel;
@interface GameModel : JSONModel

    @property (nonatomic) NSString* time;
    @property (nonatomic) NSString* startTime;
    @property (nonatomic) NSString* awayName;
    @property (nonatomic) NSString* homeName;
    @property (nonatomic) NSString* awayLogo;
    @property (nonatomic) NSString* homeLogo;
    
@end
