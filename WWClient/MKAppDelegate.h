//
//  MKAppDelegate.h
//  WWClient
//

//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SpriteKit/SpriteKit.h>

@class MKClient;

@interface MKAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet SKView *skView;

@property (nonatomic) MKClient *client;

@end
