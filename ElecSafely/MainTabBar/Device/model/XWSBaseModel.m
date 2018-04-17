//
//  XWSBaseModel.m
//  ElecSafely
//
//  Created by lhb on 2018/4/11.
//  Copyright © 2018年 Tianfu. All rights reserved.
//

#import "XWSBaseModel.h"

@implementation XWSBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        if (![dict isKindOfClass:NSDictionary.class]) {
            dict = @{};
        }
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

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

- (BOOL)verifyArray:(id)obj{
    
    return [obj isKindOfClass:[NSArray class]];
}

- (BOOL)verifyDictionary:(id)obj{
    
    return [obj isKindOfClass:[NSDictionary class]];
}

- (BOOL)verifyString:(id)obj{
    
    return [obj isKindOfClass:[NSString class]];
}


@end
