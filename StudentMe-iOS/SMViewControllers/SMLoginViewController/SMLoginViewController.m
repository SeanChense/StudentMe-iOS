//
//  SMLoginViewController.m
//  StudentMe-iOS
//
//  Created by SeanChense on 15/8/16.
//  Copyright (c) 2015年 UESTC-BBS. All rights reserved.
//

#import "SMLoginViewController.h"
#import "SMLoginInputTableViewCell.h"


#import <UIBarButtonItem+BlocksKit.h>
#import <Masonry/Masonry.h>

static NSString *const identifier = @"SMLoginInputTableViewCell";

@interface SMLoginViewController ()

@end

@implementation SMLoginViewController {
    RACSignal *nameSignal, *passwordSignal, *btnSignal;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView {
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *btn_cancel = [[UIBarButtonItem alloc] bk_initWithTitle:@"取消" style:UIBarButtonItemStylePlain handler:^(id sender) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.navigationItem.leftBarButtonItem = btn_cancel;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerNib:[UINib nibWithNibName:identifier bundle:nil]
         forCellReuseIdentifier:identifier];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(120);
        make.height.equalTo(@82);
        make.width.equalTo(weakSelf.view);
    }];
    
    [self.btn_login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tableView.mas_bottom).with.offset(10);
    }];
    
    
    btnSignal = [self.btn_login rac_signalForControlEvents:UIControlEventTouchUpInside];
    [btnSignal subscribeNext:^(id x) {
        NSLog(@"Btn tapped");
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SMLoginInputTableViewCell *cell = (SMLoginInputTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[SMLoginInputTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    switch (indexPath.row) {
        case 0: {
            nameSignal = [[cell configureWithStyle:indexPath.row] map:^id(id value) {
                if (!value ||[(NSString *)value length] == 0) {
                    return @NO;
                } else {
                    return @YES;
                }
            }];
            
            

            break;
        }
        case 1: {
            passwordSignal = [[cell configureWithStyle:indexPath.row] map:^id(id value) {
                if (!value ||[(NSString *)value length] == 0) {
                    return @NO;
                } else {
                    return @YES;
                }

            }];
            break;
        }
        default:
            break;
    }
    
    if (!nameSignal || !passwordSignal) {
        return cell;
    }
    
    RACSignal *validInputSignal = [RACSignal combineLatest:@[nameSignal, passwordSignal] reduce:^id(NSNumber *nameBool, NSNumber *pwdBool){
        return @([nameBool boolValue] && [pwdBool boolValue]);
    }];
    
    RAC(self.btn_login, alpha) =
    [validInputSignal map:^id(NSNumber *value) {
        return [value boolValue] ? @1.0 : @0.3;

    }];
    
    RAC(self.btn_login, enabled) =
    [validInputSignal map:^id(NSNumber *value) {
        return value;
    }];
    
    
    return cell;
}



@end
