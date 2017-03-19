//
//  TTVideoLoader.h
//  TestTask
//
//  Created by Дмитрий Фролов on 18.03.17.
//  Copyright © 2017 Дмитрий Фролов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKSdk.h"



@interface TTVideoLoader : NSObject


@property (strong, nonatomic)NSMutableArray *videosArray;
-(void)getVideoArray:(NSString *)searchRequest offset:(NSNumber *)offset response:(void (^)(NSMutableArray *))completion;

@end

