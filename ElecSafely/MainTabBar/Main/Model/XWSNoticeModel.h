//
//  XWSNoticeModel.h
//  ElecSafely
//
//  Created by TigerNong on 2018/4/4.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWSNoticeModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Contents;
@property (nonatomic, copy) NSString *ExpiredDate;
@property (nonatomic, copy) NSString *UpdataDate;
@end
