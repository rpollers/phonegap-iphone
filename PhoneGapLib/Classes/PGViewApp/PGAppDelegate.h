//
//  PGAppDelegate.h
//  PhoneGapLib
//
//  Created by Jesse MacFadyen on 11-03-01.
//  Copyright 2011 Nitobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGViewController.h"


@interface PGAppDelegate : NSObject < UIApplicationDelegate > 
{
	IBOutlet PGViewController* gapView;
	IBOutlet UIWindow *window;
}

@property (nonatomic, retain) PGViewController* gapView;
@property (nonatomic, retain) UIWindow *window;


- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;

@end
