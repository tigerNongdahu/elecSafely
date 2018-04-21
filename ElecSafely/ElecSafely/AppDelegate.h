//
//  AppDelegate.h
//  ElecSafely
//
//  Created by Tianfu on 11/12/2017.
//  Copyright © 2017 Tianfu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "XGPush.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

