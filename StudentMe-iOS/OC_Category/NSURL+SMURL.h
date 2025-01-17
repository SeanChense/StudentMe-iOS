//
//  NSURL+SMURL.h
//  StudentMe-iOS
//
//  Created by SeanChense on 15/7/25.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (SMURL)

+ (NSString *)smHostString;

#pragma mark - user
+ (NSString *)smLoginString;

#pragma mark - post
+ (NSString *)smForumlistString;
+ (NSString *)smForumTopiclistString;
+ (NSString *)smForumPostlistString;
+ (NSString *)smForumTopicAdminString;

#pragma mark - message
+ (NSString *)smMessageNotifylistString;
@end
