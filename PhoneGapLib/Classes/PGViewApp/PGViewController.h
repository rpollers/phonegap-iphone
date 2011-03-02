//
//  PGViewController.h
//
//  Created by Jesse MacFadyen on 11-01-30.
//  Copyright 2011 Nitobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGapView.h"
#import "JSON/JSON.h"
#import "InvokedUrlCommand.h"

@class InvokedUrlCommand;

@interface PGViewController : UIViewController < UIWebViewDelegate >  {

	IBOutlet UIGapView* webView;
	NSMutableDictionary *commandObjects;
	NSDictionary *settings;
	NSString* baseUrl;
}

@property (nonatomic, retain) UIGapView *webView;
@property (nonatomic, retain) NSMutableDictionary *commandObjects;
@property (nonatomic, retain) NSDictionary *settings;
@property (nonatomic, retain) NSString *baseUrl;








- (BOOL) execute:(InvokedUrlCommand*)command;
- (id) getCommandInstance:(NSString*)className;

- (BOOL)webView:(UIWebView *)theWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidFinishLoad:(UIWebView *)theWebView; 


- (NSDictionary*) deviceProperties;
- (NSString*) pathForResource:(NSString*)resourcepath;
- (NSString*) wwwFolderName;

@end
