//
//  MKAfterBattleScene.m
//  WWClient
//
//  Created by Андрей Рычков on 09.05.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import "MKAfterBattleScene.h"
#import "MKMainMenuScene.h"
#import "MKClient.h"

@interface MKAfterBattleScene ()

@property (nonatomic) SKSpriteNode *startButton;
@property (nonatomic) SKLabelNode *start;
@property (nonatomic) SKSpriteNode *exitButton;
@property (nonatomic) SKLabelNode *exit;

@end

@implementation MKAfterBattleScene

- (id)initWithSize:(CGSize)size win:(BOOL)yOrNo client:(MKClient *)client
{
    if (self = [super initWithSize:size])
    {
        _client = client;
        self.backgroundColor = [SKColor whiteColor];
        if (yOrNo)
        {
            SKSpriteNode *won = [SKSpriteNode spriteNodeWithImageNamed:@"msg-you-won@2x.png"];
            won.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
            [self addChild:won];
        } else
        {
            SKSpriteNode *lose = [SKSpriteNode spriteNodeWithImageNamed:@"msg-you-lose@2x.png"];
            lose.position = CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMidY(self.frame));
            [self addChild:lose];
        }
        
        _startButton = [SKSpriteNode spriteNodeWithImageNamed:@"button.png"];
        _startButton.position = CGPointMake(CGRectGetMidX(self.frame),
                                            CGRectGetMidY(self.frame) - 200);
        [self addChild:_startButton];
        
        _start = [SKLabelNode labelNodeWithFontNamed:@"Chulkduster"];
        _start.text = @"Menu";
        _start.position = _startButton.position;
        
        [self addChild:_start];
        
        _exitButton = [SKSpriteNode spriteNodeWithImageNamed:@"button.png"];
        _exitButton.position = CGPointMake(CGRectGetMidX(self.frame) + 350,
                                           CGRectGetMidY(self.frame) - 250);
        [self addChild:_exitButton];
        
        _exit = [SKLabelNode labelNodeWithFontNamed:@"Chulkduster"];
        _exit.text = @"Exit";
        _exit.position = _exitButton.position;
        
        [self addChild:_exit];
    }
    
    return self;
}

- (void)mouseDown:(NSEvent *)theEvent
{
    if ([_startButton containsPoint:[theEvent locationInNode:self]])
    {
        [_client restart];
        MKMainMenuScene *scene = [[MKMainMenuScene alloc] initWithSize:CGSizeMake(1024, 768)
                                                                client:_client];
        scene.scaleMode = SKSceneScaleModeAspectFit;
        
        [self.view presentScene:scene];
        
    } else if ([_exitButton containsPoint:[theEvent locationInNode:self]])
    {
        exit(1);
    }
}

@end
