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

@property (nonatomic) SKSpriteNode *startButton;
@property (nonatomic) SKSpriteNode *cancelButton;
@property (nonatomic) SKSpriteNode *background;
@property (nonatomic) SKLabelNode *start;
@property (nonatomic) SKLabelNode *cancel;
@property (nonatomic) AVAudioPlayer *musicPlayer;
@property (nonatomic) MKGameScene *game;
@property (nonatomic) NSTextField *field;

@end

@implementation MKMainMenuScene

- (id)initWithSize:(CGSize)size client:(MKClient *)client
{
    if (self = [super initWithSize:size])
    {
        _client = client;
        
        _background = [SKSpriteNode spriteNodeWithImageNamed:@"mainMenu.png"];
        _background.anchorPoint = CGPointZero;
        
        [self addChild:_background];
        
        _startButton = [SKSpriteNode spriteNodeWithImageNamed:@"button.png"];
        _startButton.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame) - 200);
        [self addChild:_startButton];
        
        _start = [SKLabelNode labelNodeWithFontNamed:@"Chulkduster"];
        _start.text = @"Start";
        _start.position = _startButton.position;
        
        [self addChild:_start];
        
        NSURL *musicURL = [[NSBundle mainBundle] URLForResource:@"theme"
                                                  withExtension:@"mp3"];
        _musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL
                                                              error:nil];
        _musicPlayer.numberOfLoops = -1;
        //[_musicPlayer play];
    }
    
    return self;
}

- (void)mouseDown:(NSEvent *)theEvent
{
    if ([_startButton containsPoint:[theEvent locationInNode:self]])
    {
        [_background setTexture:[SKTexture textureWithImageNamed:@"loading.png"]];
        [_startButton removeFromParent];
        [_start removeFromParent];
        
        _cancelButton = [SKSpriteNode spriteNodeWithImageNamed:@"button.png"];
        _cancelButton.position = CGPointMake(CGRectGetMidX(self.frame) + 350,
                                             CGRectGetMidY(self.frame) - 250);
        _cancel = [SKLabelNode labelNodeWithFontNamed:@"Chulkduster"];
        _cancel.text = @"Cancel";
        _cancel.position = _cancelButton.position;
        
        [self addChild:_cancelButton];
        [self addChild:_cancel];
        
        NSThread *waiting = [[NSThread alloc] initWithTarget:self
                                                    selector:@selector(waiting)
                                                      object:nil];
        [waiting start];
    }else if ([_cancelButton containsPoint:[theEvent locationInNode:self]])
    {
        int message = -1;
        send(_game.client.sock, &message, sizeof(int), 0);
        [_game.client stop];
        NSLog(@"Connection closed");
        SKScene *scene = [[MKMainMenuScene alloc] initWithSize:CGSizeMake(1024, 768)
                                                        client:_client];
        
        scene.scaleMode = SKSceneScaleModeAspectFit;
        
        [self.view presentScene:scene];
    }
}

- (void)waiting
{
    _game = [[MKGameScene alloc] initWithSize:CGSizeMake(1024, 768)
                                       client:_client];
    while (!_game.client.canStartGame)
    {
        if (_game.client.skill == 5)
        {
            _game.client.canStartGame = YES;
        }
        //WaitForAnotherPlayer;
    }
    [_game playMusic];
    [self.view presentScene:_game
                 transition:[SKTransition fadeWithDuration:2.0f]];
}

@end
