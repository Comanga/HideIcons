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
    BOOL            _filesHidden;
}

@property (weak) IBOutlet NSMenu *statusMenu;
@property (weak) IBOutlet NSMenuItem *hideButton;
@property (weak) IBOutlet NSMenuItem *cleanButton;
@property (weak) IBOutlet NSMenuItem *cleanByButton;
@property (weak) IBOutlet NSMenuItem *showHiddenFilesButton;

- (IBAction)hideAndUnhideDesktop:(id)sender;
- (IBAction)cleanDesktop:(id)sender;
- (IBAction)hideAndShowHiddenFiles:(id)sender;
- (IBAction)cleanDesktopByName:(id)sender;
- (IBAction)cleanDesktopByKind:(id)sender;
- (IBAction)cleanDesktopByDateModified:(id)sender;
- (IBAction)cleanDesktopByDateCreated:(id)sender;
- (IBAction)cleanDesktopBySize:(id)sender;
- (IBAction)cleanDesktopByTags:(id)sender;

@end
