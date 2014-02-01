//
//  AppDelegate.m
//  HideIcons
//
//  Created by corentin-brice larroque on 30/01/2014.
//  Copyright (c) 2014 Larroque. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _isHidden = NO;
    _filesHidden = NO;
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    if (_isHidden || _filesHidden)
    {
        [self runCommandLine:@"defaults write com.apple.finder CreateDesktop -bool true"];
        [self runCommandLine:@"defaults write com.apple.finder AppleShowAllFiles 0"];
        [self runCommandLine:@"killall Finder"];
    }
}

- (void)awakeFromNib
{
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [_statusItem setToolTip:@"HideIcons by Corentin Larroque\nVersion 1.1"];
    [_statusItem setMenu:_statusMenu];
    [_statusItem setHighlightMode:YES];
    [self changeIcon:@"hideIcon"];
}

- (IBAction)hideAndUnhideDesktop:(id)sender
{
    if (!_isHidden)
    {
        [self runCommandLine:@"defaults write com.apple.finder CreateDesktop -bool false"];
        [self runCommandLine:@"killall Finder"];
        [_hideButton setTitle:@"Unhide Desktop Icons"];
        [self changeIcon:@"unhideIcon"];
        [_cleanButton setEnabled:NO];
        [_cleanByButton setEnabled:NO];
        _isHidden = YES;
    }
    else
    {
        [self runCommandLine:@"defaults write com.apple.finder CreateDesktop -bool true"];
        [self runCommandLine:@"killall Finder"];
        [_hideButton setTitle:@"Hide Desktop Icons"];
        [self changeIcon:@"hideIcon"];
        [_cleanButton setEnabled:YES];
        [_cleanByButton setEnabled:YES];
        _isHidden = NO;
    }
}

- (IBAction)hideAndShowHiddenFiles:(id)sender
{
    if (!_filesHidden)
    {
        [self runCommandLine:@"defaults write com.apple.finder AppleShowAllFiles 1"];
        [self runCommandLine:@"killall Finder"];
        [_showHiddenFilesButton setTitle:@"Hide Hidden Files"];
        _filesHidden = YES;
    }
    else
    {
        [self runCommandLine:@"defaults write com.apple.finder AppleShowAllFiles 0"];
        [self runCommandLine:@"killall Finder"];
        [_showHiddenFilesButton setTitle:@"Show Hidden Files"];
        _filesHidden = NO;
    }
}

- (IBAction)cleanDesktop:(id)sender
{
    [self runCommandLine:@"osascript -e 'tell application \"Finder\" to clean up window of desktop'"];
}

- (IBAction)cleanDesktopByName:(id)sender
{
    [self runCommandLine:@"osascript -e 'tell application \"Finder\" to clean up window of desktop by name'"];
}

- (IBAction)cleanDesktopByKind:(id)sender
{
    [self runCommandLine:@"osascript -e 'tell application \"Finder\" to clean up window of desktop by kind'"];
}

- (IBAction)cleanDesktopByDateModified:(id)sender
{
    [self runCommandLine:@"osascript -e 'tell application \"Finder\" to clean up window of desktop by modification date'"];
}

- (IBAction)cleanDesktopByDateCreated:(id)sender
{
    [self runCommandLine:@"osascript -e 'tell application \"Finder\" to clean up window of desktop by creation date'"];
}

- (IBAction)cleanDesktopBySize:(id)sender
{
    [self runCommandLine:@"osascript -e 'tell application \"Finder\" to clean up window of desktop by physical size'"];
}

- (IBAction)cleanDesktopByTags:(id)sender
{
    [self runCommandLine:@"osascript -e 'tell application \"Finder\" to clean up window of desktop by label index'"];
}

- (void)runCommandLine:(NSString *)cmd
{
    [[NSTask launchedTaskWithLaunchPath:@"/bin/sh"
                              arguments:[NSArray arrayWithObjects:@"-c", cmd, nil]] waitUntilExit];
}

- (void)changeIcon:(NSString *)imageName
{
    NSBundle    *bundle;
    
    bundle = [NSBundle mainBundle];
    _statusImage = [[NSImage alloc] initWithContentsOfFile:
                    [bundle pathForResource:imageName ofType:@"png"]];
    [_statusItem setImage:_statusImage];
}

@end
