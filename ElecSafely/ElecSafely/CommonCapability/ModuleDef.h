//
//  ModuleDef.h
//  ElecSafely
//
//  Created by Tianfu on 11/12/2017.
//  Copyright © 2017 Tianfu. All rights reserved.
//

#ifndef ModuleDef_h
#define ModuleDef_h

#define FONT9  [UIFont systemFontOfSize:9]
#define FONT10 [UIFont systemFontOfSize:10]
#define FONT11 [UIFont systemFontOfSize:11]
#define FONT12 [UIFont systemFontOfSize:12]
#define FONT13 [UIFont systemFontOfSize:13]
#define FONT14 [UIFont systemFontOfSize:14]
#define FONT15 [UIFont systemFontOfSize:15]
#define FONT16 [UIFont systemFontOfSize:16]
#define FONT17 [UIFont systemFontOfSize:17]

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define UIColorRGB(rgb) ([[UIColor alloc] initWithRed:(((rgb >> 16) & 0xff) / 255.0f) green:(((rgb >> 8) & 0xff) / 255.0f) blue:(((rgb) & 0xff) / 255.0f) alpha:1.0f])

#define IS_IOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)
#define IS_IOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)
#define IS_IOS9 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO)
#define IS_IOS10 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) ? YES : NO)
#define IS_IOS11 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) ? YES : NO)

#endif /* ModuleDef_h */
