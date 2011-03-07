 /*
 * PhoneGap is available under *either* the terms of the modified BSD license *or* the
 * MIT License (2008). See http://opensource.org/licenses/alphabetical for full text.
 * 
 * Created by Michael Nachbaur on 13/04/09.
 * Copyright (c) 2009 Decaf Ninja Software. All rights reserved.
 * Copyright (c) 2005-2010, Nitobi Software Inc.
 * Copyright (c) 2010, IBM Corporation
 */


#import "PhoneGapCommand.h"
#import "PhoneGapDelegate.h"


@implementation PhoneGapCommand
@synthesize webView;
@synthesize settings;


-(PhoneGapCommand*) initWithWebView:(UIWebView*)theWebView settings:(NSDictionary*)classSettings
{
    self = [self initWithWebView:theWebView];
    if (self)
        [self setSettings:classSettings];
    return self;
}

-(PhoneGapCommand*) initWithWebView:(UIWebView*)theWebView
{
    self = [super init];
    if (self)
	{
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppTerminate) name:UIApplicationWillTerminateNotification object:nil];
        [self setWebView:theWebView];
		
	}
    return self;
}

-(void)onAppTerminate
{
	// override this if you need to do any cleanup on app exit
	//NSLog(@"PhoneGapCommand::onAppTerminate",0);
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
	
    if (self.settings)
        [self.settings release];
    [super dealloc];
}

-(PhoneGapDelegate*) appDelegate
{
	return (PhoneGapDelegate*)[[UIApplication sharedApplication] delegate];
}

-(UIViewController*) appViewController
{
	return (UIViewController*)[self appDelegate].viewController;
}

- (void) writeJavascript:(NSString*)javascript
{
	[webView stringByEvaluatingJavaScriptFromString:javascript];
}

- (void) clearCaches
{
	// override
}

@end