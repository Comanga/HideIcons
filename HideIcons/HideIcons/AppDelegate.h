//
//  AppDelegate.h
//  HideIcons
//
//  Created by corentin-brice larroque on 30/01/2014.
//  Copyright (c) 2014 Larroque. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSStatusItem    *_statusItem;
    NSImage         *_statusImage;
    NSImage         *_statusImageHighlight;
    
    BOOL            _isHidden;
}

@property (weak) IBOutlet NSMenu *statusMenu;
@property (weak) IBOutlet NSMenuItem *hideButton;
@property (weak) IBOutlet NSMenuItem *cleanButton;

- (IBAction)hideAndUnhideDesktop:(id)sender;
- (IBAction)cleanDesktop:(id)sender;

@end
