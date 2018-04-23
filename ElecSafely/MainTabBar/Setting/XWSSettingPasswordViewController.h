//
//  XWSSettingPasswordViewController.h
//  ElecSafely
//
//  Created by TigerNong on 2018/3/29.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSBasrViewController.h"

typedef NS_ENUM(NSInteger, XWSShowVCType) {
    XWSShowVCTypeSettingPassword = 0,//修改密码
    XWSShowVCTypeRegister,//注册
};


@interface XWSSettingPasswordViewController : XWSBasrViewController
@property (nonatomic, assign) XWSShowVCType type;
@end
