//
//  XWSFliterConditionModel.m
//  ElecSafely
//
//  Created by lhb on 2018/4/6.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSFliterConditionModel.h"

NSString *const KeyCustomerName = @"客户名称";
NSString *const KeyCustomerGroup = @"客户分组";
NSString *const KeyDeviceStatus = @"设备状态";

NSString *const KeyDeviceName = @"设备名称";
NSString *const KeyAlarmType = @"报警类型";

@interface XWSFliterConditionModel(){
    
}
@end

@implementation XWSFliterConditionModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}


- (void)setLeftKeyName:(NSString *)leftKeyName{
    
    _leftKeyName = leftKeyName;
    
    if ([leftKeyName isEqualToString:KeyDeviceStatus]) {
        self.statusArr = @[@"全部",@"正常",@"报警",@"离线"];
        self.status = @"0";
        self.selectRightRow = 0;
    }
    
    if ([leftKeyName isEqualToString:KeyAlarmType]) {
        self.alarmArr = @[@"报警",@"离线"];
        self.alarmArrEn = @[@"alarm",@"offline"];
        self.alarmType = @"alarm";
        self.selectRightRow = 0;
    }
}


@end


/*
 客户名称
 */
@implementation XWSFliterCustomer


@end


/*
 客户分组
 */
@implementation XWSFliterGroup



@end

