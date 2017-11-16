//
//  WebServices.h
//  Startwars_API
//
//  Created by Virtual Box on 11/8/17.
//  Copyright © 2017 UAG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "GameModel.h"

@interface WebServices : NSObject<NSURLSessionDelegate>

+ (void)getGames:(void (^)(NSMutableArray<GameModel> *games)) handler;

@end
