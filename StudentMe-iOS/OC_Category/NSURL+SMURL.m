//
//  NSURL+SMURL.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/25.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "NSURL+SMURL.h"

@implementation NSURL (SMURL)

+ (NSString *)smHostString {
    return @"http://bbs.uestc.edu.cn";
}

#pragma mark - user
+ (NSString *)smLoginString {
    return [[self prefixbbsUrlString] stringByAppendingString:@"user/login"];
}

#pragma mark - post
+ (NSString *)smForumlistString {
    return [[self prefixbbsUrlString] stringByAppendingString:@"forum/forumlist"];
}

+ (NSString *)smForumTopiclistString {
    return [[self prefixbbsUrlString] stringByAppendingString:@"forum/topiclist"];
}

+ (NSString *)smForumPostlistString {
    return [[self prefixbbsUrlString] stringByAppendingString:@"forum/postlist"];
}

+ (NSString *)smForumTopicAdminString {
    return [[self prefixbbsUrlString] stringByAppendingString:@"forum/topicadmin"];
}

#pragma mark - message
+ (NSString *)smMessageNotifylistString {
    return [[self prefixbbsUrlString] stringByAppendingString:@"message/notifylist"];
}

#pragma mark - private method

+ (NSString *)prefixbbsUrlString {
    return [[self smHostString] stringByAppendingString:[self bbsMiddleUrlString]];
}

+ (NSString *)bbsMiddleUrlString {
    return @"/mobcent/app/web/index.php?r=";
}
@end
