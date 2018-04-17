//
//  ESDeviceData.h
//  ElecSafely
//
//  Created by lhb on 2018/2/4.
//  Copyright © 2018年 Tianfu. All rights reserved.
//  设备详情数据

#import "XWSBaseModel.h"

@class XWSDeviceLoopData;

@interface ESDeviceData : XWSBaseModel

/*baseInf*/
@property (nonatomic, copy) NSString *Alarm;///<
@property (nonatomic, copy) NSString *AlarmDate;
@property (nonatomic, copy) NSString *CRCID;
@property (nonatomic, copy) NSString *CustomerID;///<客户ID
@property (nonatomic, copy) NSString *CustomerName;///<客户名称
@property (nonatomic, copy) NSString *GroupID;///<分组ID
@property (nonatomic, copy) NSString *GroupName;///<分组名称
@property (nonatomic, copy) NSString *ID;///<设备ID
@property (nonatomic, copy) NSString *Name;///<设备名称
@property (nonatomic, copy) NSString *Online;///<
@property (nonatomic, copy) NSString *UpdataDate;

/*loopData*/
@property (nonatomic, strong) NSArray<XWSDeviceLoopData*> *loopDatas;///<回路类型值


@end


/*
 *LoopData
 */
@interface XWSDeviceLoopData : XWSBaseModel

@property (nonatomic, copy) NSString *DecimalVal;///<探测值的小数位
@property (nonatomic, copy) NSString *IntegerVal;///<探测值的整数位
@property (nonatomic, copy) NSString *LimitHigh;
@property (nonatomic, copy) NSString *LimitLow;
@property (nonatomic, copy) NSString *LoopNum;
@property (nonatomic, copy) NSString *LoopType;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *Scope;///<是否是范围值 0:设备值为LimitHigh  1:设备值为LimitLow-LimitHigh
@property (nonatomic, copy) NSString *Unit;


/*用于展示*/
@property (nonatomic, copy) NSString *showLoopName; ///<回路类型名   name + LoopNum
@property (nonatomic, copy) NSString *showDetectValue;///<探测值
@property (nonatomic, copy) NSString *showScopeValue;///<设备值  根据scope

@end





