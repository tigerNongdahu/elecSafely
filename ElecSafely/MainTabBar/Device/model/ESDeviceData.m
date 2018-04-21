//
//  ESDeviceData.m
//  ElecSafely
//
//  Created by lhb on 2018/2/4.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "ESDeviceData.h"

@implementation ESDeviceData

- (void)setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"loopData"]) {
        
        NSArray *loopData = value;
        if ([self verifyArray:loopData]) {
            self.loopDatas = [self getLoopDatas:loopData];
        }
    } else if ([key isEqualToString:@"baseInf"]){
        
        NSDictionary *baseInf = value;
        if ([self verifyDictionary:baseInf]) {
            [self setValuesForKeysWithDictionary:baseInf];
        }
    }else{
        [super setValue:value forKey:key];
    }
}

- (NSArray *)getLoopDatas:(NSArray *)loopData{
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:8];
    for (int i = 0; i < loopData.count; i++) {
        NSDictionary *dic = [loopData objectAtIndex:i];
        XWSDeviceLoopData *data = [[XWSDeviceLoopData alloc] initWithDictionary:dic];
        [tempArr addObject:data];
        
        data.showLoopName = [NSString stringWithFormat:@"%@回路%@",data.Name,data.LoopNum];
        if ([data.DecimalVal intValue] == 0) {
            data.showDetectValue = data.IntegerVal;
        }else{
            data.showDetectValue = [NSString stringWithFormat:@"%@.%@",data.IntegerVal,data.DecimalVal];
        }
        if ([data.Scope boolValue]) {
            data.showScopeValue = [NSString stringWithFormat:@"%@-%@%@",data.LimitLow,data.LimitHigh,data.Unit];
        }else{
            data.showScopeValue = [NSString stringWithFormat:@"%@%@",data.LimitHigh,data.Unit];
        }
    }
    return [tempArr copy];
}

@end




@implementation XWSDeviceLoopData

@end


