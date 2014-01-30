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
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    if (_isHidden)
    {
        [self runCommandLine:@"defaults write com.apple.finder CreateDesktop -bool true"];
        [self runCommandLine:@"killall Finder"];
    }
}

- (void)awakeFromNib
{
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [_statusItem setToolTip:@"HideIcons by Corentin Larroque"];
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
        [_hideButton setTitle:@"Unhide desktop icons"];
        [self changeIcon:@"unhideIcon"];
        [_cleanButton setEnabled:YES];
        _isHidden = YES;
    }
    else
    {
        [self runCommandLine:@"defaults write com.apple.finder CreateDesktop -bool true"];
        [self runCommandLine:@"killall Finder"];
        [_hideButton setTitle:@"Hide desktop icons"];
        [self changeIcon:@"hideIcon"];
        [_cleanButton setEnabled:NO];
        _isHidden = NO;
    }
}

- (IBAction)cleanDesktop:(id)sender
{
    [self runCommandLine:@"osascript -e 'tell application \"Finder\" to clean up window of desktop'"];
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
