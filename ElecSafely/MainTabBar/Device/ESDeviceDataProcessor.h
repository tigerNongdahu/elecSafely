//
//  ESDeviceDataProcessor.h
//  ElecSafely
//
//  Created by lhb on 2018/2/4.
//  Copyright © 2018年 Tianfu. All rights reserved.
//  设备详情数据处理类

#import <Foundation/Foundation.h>

@class ESDeviceData;

@interface ESDeviceDataProcessor : NSObject

/*设备实时信息*/
- (void)requestDeviceStatusDataWithDeviceID:(NSString *)deviceID success:(void(^)(ESDeviceData *))success;

/*获取设备最近7天设备查询数据信息*/
- (void)requestDeviceChartHistoryDataWithDeviceID:(NSString *)deviceID success:(void(^)(NSArray *))success;

/*设备查询  设备复位*/
- (void)requestDeviceQueryResetDataWithDeviceID:(NSString *)deviceID success:(void(^)(BOOL))success;


@end
