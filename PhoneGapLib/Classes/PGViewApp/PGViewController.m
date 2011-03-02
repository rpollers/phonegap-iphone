//
//  PGViewController.m
//
//  Created by Jesse MacFadyen on 11-01-30.
//  Copyright 2011 Nitobi. All rights reserved.
//

#import "PGViewController.h"
#import "PhoneGapCommand.h"



@implementation PGViewController

@synthesize webView;
@synthesize commandObjects;
@synthesize settings;
@synthesize baseUrl;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization.
//    }
//    return self;
//}

//- (void)loadView
//{
//	self.wantsFullScreenLayout = YES;
//	
//	CGRect screenBounds = [ [ UIScreen mainScreen ] bounds ];
//	CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ] ;
//	bounds.origin = screenBounds.origin;
//	
//	// Create the root view
//	UIView* rootView = [ [ UIView alloc ] initWithFrame:bounds];
//
//	rootView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
//	
//	// Create the gap view
//	UIGapView* gapView = [ [ UIGapView alloc ] initWithFrame:bounds];
//	
//	
//	
//	self.view = rootView;
//	self.webView = gapView;
//	
//	[ self.view insertSubview:gapView atIndex:0];
//	
//	[ gapView release];
//	[ rootView release ];
//	
//    
//
//}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	commandObjects = [[NSMutableDictionary alloc] initWithCapacity:4];
	
	self.wantsFullScreenLayout = YES;
	
	CGRect screenBounds = [ [ UIScreen mainScreen ] bounds ];
	CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ] ;
	bounds.origin = screenBounds.origin;

	
	// Create the gap view
	UIGapView* gapView = [ [ UIGapView alloc ] initWithFrame:bounds];
	
	
	self.webView = gapView;
	
	[ self.view addSubview:gapView];
	
	[ gapView release];
	
	
	self.webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	
	NSString* path = [self pathForResource:@"index.html"];
	
	NSURL *appURL  = [NSURL fileURLWithPath:path];
	
    NSURLRequest *appReq = [NSURLRequest requestWithURL:appURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
	
	self.webView.delegate = self;
	
	[ self.webView loadRequest:appReq];
	
	
}

-(void)viewWillAppear:(BOOL)animated
{
	[ super viewWillAppear:animated];
	

}

-(void)viewDidAppear:(BOOL)animated
{
	
	[ super viewDidAppear:animated];	
	
//	CGRect screenBounds = [ [ UIScreen mainScreen ] bounds ];
//	CGRect bounds = [ [ UIScreen mainScreen ] applicationFrame ] ;
//	bounds.origin = screenBounds.origin;
//	
//	UIGapView* gapView = [ [ UIGapView alloc ] initWithFrame:bounds];
//	
//	//UIView* subView = [[ UIView alloc] initWithFrame:bounds];
//	
//	
//	[ self.view insertSubview:gapView atIndex:0];
//	
//	
//	NSString* path = [self pathForResource:@"index.html"];
//	NSURL *appURL  = [NSURL fileURLWithPath:path];
//	
//	
//    NSURLRequest *appReq = [NSURLRequest requestWithURL:appURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
//	
//	self.webView = gapView;
//	self.webView.delegate = self;
//	[self.webView loadRequest:appReq];
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


static NSString *gapVersion;
+ (NSString*) phoneGapVersion
{
	if (gapVersion == nil) {
		NSBundle *mainBundle = [NSBundle mainBundle];
		NSString *filename = [mainBundle pathForResource:@"VERSION" ofType:nil];
		// read from the filesystem and save in the variable
		gapVersion = [ [ NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:NULL ] retain ];
	}
	return gapVersion;
}

- (NSString*) wwwFolderName
{
	return @"www";
}

- (NSString*) pathForResource:(NSString*)resourcepath
{
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSMutableArray *directoryParts = [NSMutableArray arrayWithArray:[resourcepath componentsSeparatedByString:@"/"]];
    NSString       *filename       = [directoryParts lastObject];
    [directoryParts removeLastObject];
	
    NSString *directoryStr = [NSString stringWithFormat:@"%@/%@", [self wwwFolderName], [directoryParts componentsJoinedByString:@"/"]];
    return [mainBundle pathForResource:filename
								ofType:@""
						   inDirectory:directoryStr];
}

- (NSDictionary*) deviceProperties
{
	UIDevice *device = [UIDevice currentDevice];
    NSMutableDictionary *devProps = [NSMutableDictionary dictionaryWithCapacity:4];
    [devProps setObject:[device model] forKey:@"platform"];
    [devProps setObject:[device systemVersion] forKey:@"version"];
    [devProps setObject:[device uniqueIdentifier] forKey:@"uuid"];
    [devProps setObject:[device name] forKey:@"name"];
    [devProps setObject:[[self class] phoneGapVersion ] forKey:@"gap"];
	
    NSDictionary *devReturn = [NSDictionary dictionaryWithDictionary:devProps];
    return devReturn;
}

/**
 Returns an instance of a PhoneGapCommand object, based on its name.  If one exists already, it is returned.
 // */
-(id) getCommandInstance:(NSString*)className
{
    id obj = [commandObjects objectForKey:className];
    if (!obj) 
	{
        // attempt to load the settings for this command class
        NSDictionary* classSettings;
        classSettings = [settings objectForKey:className];
		
        if (classSettings)
            obj = [[NSClassFromString(className) alloc] initWithWebView:webView settings:classSettings];
        else
            obj = [[NSClassFromString(className) alloc] initWithWebView:webView];
        
        [commandObjects setObject:obj forKey:className];
		[obj release];
    }
    return obj;
}

- (void)webViewDidFinishLoad:(UIWebView *)theWebView 
{
	NSDictionary *deviceProperties = [ self deviceProperties];
    NSMutableString *result = [[NSMutableString alloc] initWithFormat:@"DeviceInfo = %@;", [deviceProperties JSONFragment]];

    NSLog(@"Device initialization: %@", result);
    [theWebView stringByEvaluatingJavaScriptFromString:result];
	[result release];

}

- (BOOL)webView:(UIWebView *)theWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSURL *url = [request URL];
	
	NSLog(@"webView request to load :: %@",url);
    /*
     * Get Command and Options From URL
     * We are looking for URLS that match gap://<Class>.<command>/[<arguments>][?<dictionary>]
     * We have to strip off the leading slash for the options.
     */
	if ([[url scheme] isEqualToString:@"gap"]) {
		
		InvokedUrlCommand* iuc = [[InvokedUrlCommand newFromUrl:url] autorelease];
        
		// Tell the JS code that we've gotten this command, and we're ready for another
        [theWebView stringByEvaluatingJavaScriptFromString:@"PhoneGap.queue.ready = true;"];
		
		// Check to see if we are provided a class:method style command.
		[self execute:iuc];
		
		return NO;
	}
    
    /*
     * If a URL is being loaded that's a local file URL, just load it internally
     */
    else if ([url isFileURL])
    {
        //NSLog(@"File URL %@", [url description]);
        return YES;
    }
    
    /*
     * We don't have a PhoneGap or local file request, load it in the main Safari browser.
     */
    else
    {
        //NSLog(@"Unknown URL %@", [url description]);
        //[[UIApplication sharedApplication] openURL:url];
        //return NO;
	}
	
	return YES;
}

- (BOOL) execute:(InvokedUrlCommand*)command
{
	if (command.className == nil || command.methodName == nil) 
	{
		return NO;
	}
	
	// Fetch an instance of this class
	PhoneGapCommand* obj = [self getCommandInstance:command.className];
	
	// construct the fill method name to ammend the second argument.
	NSString* fullMethodName = [[NSString alloc] initWithFormat:@"%@:withDict:", command.methodName];
	if ([obj respondsToSelector:NSSelectorFromString(fullMethodName)]) {
		[obj performSelector:NSSelectorFromString(fullMethodName) withObject:command.arguments withObject:command.options];
	}
	else {
		// There's no method to call, so throw an error.
		NSLog(@"Class method '%@' not defined in class '%@'", fullMethodName, command.className);
		[NSException raise:NSInternalInconsistencyException format:@"Class method '%@' not defined against class '%@'.", fullMethodName, command.className];
	}
	[fullMethodName release];
	
	return YES;
}



- (void)dealloc {
    [super dealloc];
	[commandObjects release];
}


@end
