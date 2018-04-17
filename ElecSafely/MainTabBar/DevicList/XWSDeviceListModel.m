//
//  XWSDeviceListModel.m
//  ElecSafely
//
//  Created by lhb on 2018/4/4.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSDeviceListModel.h"

@implementation XWSDeviceListModel


- (void)setValue:(id)value forKey:(NSString *)key{
    
    [super setValue:[self getValue:value] forKey:key];
}

- (id)getValue:(id)value{
    
    if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
        return value;
    }else{
        NSString *strValue = [NSString stringWithFormat:@"%@",value];
        return strValue;
    }
}

    
- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
        
    
}
    
    
    
@end
