//
//  MKMainMenuScene.m
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import "MKMainMenuScene.h"
#import "MKGameScene.h"
#import "MKClient.h"
#import <AVFoundation/AVFoundation.h>

@interface MKMainMenuScene ()

@property (nonatomic) SKSpriteNode *button;
@property (nonatomic) SKSpriteNode *background;
@property (nonatomic) SKLabelNode *start;
@property (nonatomic) AVAudioPlayer *musicPlayer;
@property (nonatomic) MKGameScene *game;

@end

@implementation MKMainMenuScene

- (id)initWithSize:(CGSize)size
{
    if (self == [super initWithSize:size])
    {
        _background = [SKSpriteNode spriteNodeWithImageNamed:@"mainMenu.png"];
        _background.anchorPoint = CGPointZero;
        
        [self addChild:_background];
        
        _button = [SKSpriteNode spriteNodeWithImageNamed:@"button.png"];
        _button.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame) - 200);
        [self addChild:_button];
        
        _start = [SKLabelNode labelNodeWithFontNamed:@"Chulkduster"];
        _start.text = @"Start";
        _start.position = _button.position;
        
        [self addChild:_start];
        
        NSURL *musicURL = [[NSBundle mainBundle] URLForResource:@"theme"
                                                  withExtension:@"mp3"];
        _musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL
                                                              error:nil];
        _musicPlayer.numberOfLoops = -1;
        [_musicPlayer play];
    }
    
    return self;
}

- (void)mouseDown:(NSEvent *)theEvent
{
    if ([_button containsPoint:[theEvent locationInNode:self]])
    {
        _game = [MKGameScene sceneWithSize:CGSizeMake(1024, 768)];
        
        [_button removeFromParent];
        [_start removeFromParent];
        [_background setTexture:[SKTexture textureWithImageNamed:@"loading.png"]];
        
        NSThread *waiting = [[NSThread alloc] initWithTarget:self selector:@selector(waiting)
                                                      object:nil];
        [waiting start];
    }
}

- (void)waiting
{
   while (!_game.client.background)
    {
        // Do nothing
    }
    [_game playMusic];
    [self.view presentScene:_game
                 transition:[SKTransition fadeWithDuration:2.0f]];
}

@end
