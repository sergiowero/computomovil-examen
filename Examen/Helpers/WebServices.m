//
//  WebServices.m
//  Startwars_API
//
//  Created by Virtual Box on 11/8/17.
//  Copyright © 2017 UAG. All rights reserved.
//

#import "WebServices.h"

@implementation WebServices
//--------------------------------------------------------------------------------------------
+ (void)getGames:(void (^)(NSMutableArray<GameModel> *games)) handler{
    
    NSURLSession *session = [self getSession];
    NSMutableURLRequest * request = [self getRequest:[nURLEquiposAPI stringByAppendingString:@"2017/11/15"] forData:nil];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(data!=nil){
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"response received %@",jsonResponse);
            
            if(jsonResponse!=nil){
                
                NSMutableDictionary *gamesObj = jsonResponse[@"response"][@"games"];
                NSString *keyName = [[gamesObj allKeys] objectAtIndex:0];
                NSMutableArray *gameList = [gamesObj objectForKey:keyName];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    @try {
                        NSError *err = nil;
                        NSMutableArray<GameModel>  *games = (NSMutableArray<GameModel> *)[GameModel arrayOfModelsFromDictionaries:gameList error:&err];
                        handler(games);
                    }
                    @catch (NSException *exception) {
                        handler(nil);
                    }
                });
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(nil);
                });
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil);
            });
        }
    }] resume];
}


//**********************************************************************************************
#pragma mark                              Common methods
//**********************************************************************************************
+ (NSMutableURLRequest *) getRequest:(NSString *) url forData:(NSString *) data{
    
    NSURL *httpUrl = [NSURL URLWithString:url];
    NSLog(@"URL post = %@", url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    
    if(data){
        
        NSString * tempData = data;
        NSString *post = [[NSString alloc] initWithFormat:@"data=%@", tempData];
        NSLog(@"post parameters: %@",post);
        post = [post stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        [request setURL:httpUrl];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:[@"Write your user agent name " stringByAppendingString:version] forHTTPHeaderField:@"User-Agent"];
        [request setHTTPBody:postData];
        [NSURLRequest requestWithURL:httpUrl];
    }else{
        [request setURL:httpUrl];
        [request setHTTPMethod:@"GET"];
        //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:[@"iOS Equipos API " stringByAppendingString:version] forHTTPHeaderField:@"User-Agent"];
        [NSURLRequest requestWithURL:httpUrl];
    }
    
    return request;
    
    
}
//--------------------------------------------------------------------------------------------
+(NSURLSession *)getSession{
    
    // Create Session Configuration
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Configure Session Configuration
    [sessionConfiguration setAllowsCellularAccess:YES];
    [sessionConfiguration setHTTPMaximumConnectionsPerHost:20];
    [sessionConfiguration setHTTPAdditionalHeaders:@{@"Accept" : @"application/json"}];
    
    return [NSURLSession sessionWithConfiguration:sessionConfiguration];
}
//*********************************************************************************************
#pragma mark                                alloc
//*********************************************************************************************
+ (id)alloc {
    [NSException raise:@"Cannot be instantiated!" format:@"Static class 'ClassName' cannot be instantiated!"];
    return nil;
}

@end
