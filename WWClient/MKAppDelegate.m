//
//  MKAppDelegate.m
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import "MKAppDelegate.h"
#import "MKMainMenuScene.h"
#import "MKClient.h"

@implementation MKAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _client = [[MKClient alloc] init];
    
    SKScene *scene = [[MKMainMenuScene alloc] initWithSize:CGSizeMake(1024, 768)
                                                    client:_client];

    scene.scaleMode = SKSceneScaleModeAspectFit;

    [self.skView presentScene:scene];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    if ([[self.skView.scene className] isEqualTo:@"MKMainMenuScene"])
    {
        [_client sendMessage:-1];
    } else
    {
        [_client sendMessage:-2];
    }
}

@end
