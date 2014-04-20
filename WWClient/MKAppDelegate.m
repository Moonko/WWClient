//
//  MKAppDelegate.m
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import "MKAppDelegate.h"
#import "MKMainMenuScene.h"

@implementation MKAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end
