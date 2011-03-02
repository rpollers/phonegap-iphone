//
//  PGAppDelegate.m
//  PhoneGapLib
//
//  Created by Jesse MacFadyen on 11-03-01.
//  Copyright 2011 Nitobi. All rights reserved.
//

#import "PGAppDelegate.h"
#import "PGViewController.h"


@implementation PGAppDelegate

@synthesize window;
@synthesize gapView;

- (id) init
{	
    self = [super init];
    if (self != nil) {
		// noop
    }
    return self; 
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	
	CGRect screenBounds = [ [ UIScreen mainScreen ] bounds ];
	
	UIWindow* win = [ [ UIWindow alloc ] initWithFrame:screenBounds ];
	
	win.autoresizesSubviews = YES;
	
	self.gapView = [ [ PGViewController alloc ] init];
	
	
	
//	CGRect webViewBounds = [ [ UIScreen mainScreen ] applicationFrame ] ;
//	
//	webViewBounds.origin = screenBounds.origin;
//	UIWebView webView = [ [ UIWebView alloc ] initWithFrame:webViewBounds];
//    webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
//	
//	viewController.webView = webView;
//	[viewController.view addSubview:webView];
	
	
//	//[[ self navigationController ] pushViewController:gapView animated:YES];
//
//	NSLog(@"index is : %d",[indexPath indexAtPosition: 1 ]);
//	NSLog(@"count is : %d",[ arrUrls count ]);
//
//

//
	self.window = win;
	[win addSubview:self.gapView.view];
	CGRect rect = self.gapView.view.frame;// = screenBounds;
	
	[win makeKeyAndVisible];
	[win release];
	return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	
}


@end
