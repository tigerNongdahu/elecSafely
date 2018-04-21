//
//  XWSAlarmDeviceListModel.h
//  ElecSafely
//
//  Created by lhb on 2018/4/8.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWSAlarmDeviceListModel : NSObject

@property (nonatomic, copy) NSString *AlarmType;
@property (nonatomic, copy) NSString *CRCID;
@property (nonatomic, copy) NSString *Contents;
@property (nonatomic, copy) NSString *DID; //设备ID
@property (nonatomic, copy) NSString *Date;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *Name;


@end
