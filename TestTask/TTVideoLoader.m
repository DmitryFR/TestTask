//
//  TTVideoLoader.m
//  TestTask
//
//  Created by Дмитрий Фролов on 18.03.17.
//  Copyright © 2017 Дмитрий Фролов. All rights reserved.
//

#import "TTVideoLoader.h"

@implementation TTVideoLoader


-(void)getVideoArray:(NSString *)searchRequest offset:(NSNumber *)offset response:(void (^)(NSMutableArray *))completion  {
    NSString *method = @"video.search";
    VKRequest *request = [VKRequest requestWithMethod:method parameters:@{VK_API_Q:searchRequest, VK_API_SORT:@2, VK_API_COUNT: @40, VK_API_OFFSET: @([offset intValue]) }];
    [request executeWithResultBlock:^(VKResponse *response) {
        self.videosArray = [response.json valueForKey:@"items"];
        NSLog(@"result:", response.json);
        completion(self.videosArray);
    } errorBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
        completion([[NSMutableArray alloc]init]);
    }];
    
}

@end
