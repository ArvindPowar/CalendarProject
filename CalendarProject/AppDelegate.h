//
//  AppDelegate.h
//  CalendarProject
//
//  Created by Infinitum on 20/10/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property(nonatomic,retain) NSString *monthyearSTR;
@property(nonatomic,retain)NSMutableArray *tempArray;


@end

