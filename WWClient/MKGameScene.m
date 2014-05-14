//
//  MKGameScene.m
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import "MKGameScene.h"
#import "MKEnemy.h"
#import "MKHero.h"
#import "MKElement.h"
#import "MKClient.h"
#import "MKSkill.h"
#import <AVFoundation/AVFoundation.h>

@interface MKGameScene ()

@property (nonatomic) SKLabelNode *heroMana;

@end

@implementation MKGameScene

#pragma mark - Initialization

- (id)initWithSize:(CGSize)size client:(MKClient *)client
{
    if (self == [super initWithSize:size])
    {
        self.physicsWorld.contactDelegate = self;
        
        _client = client;
        
        NSThread *clientThread = [[NSThread alloc] initWithTarget:_client
                                                         selector:@selector(start)
                                                           object:nil];
        [clientThread start];
        
        while (!_client.background)
        {
            
        } 
        
        NSString *name = [NSString stringWithFormat:@"background%d.png", [_client.background intValue]];
        SKTexture *texture = [SKTexture textureWithImageNamed:name];
        _background = [SKSpriteNode spriteNodeWithTexture:texture];
        _background.anchorPoint = CGPointZero;
        [self addChild:_background];
        
        [self setUpPentagram];
        [self setUpButtons];
        [self setUpWizards];
        [self setUpHUD];
        [self setUpMusicPlayer];
    }
    
    return self;
}

- (void)setUpPentagram
{
    _elements = [NSMutableArray array];
    
    _pentagram = [[SKNode alloc] init];
    _pentagram.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame));
    
    [self addChild:_pentagram];
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"pentagram"];
    
    SKSpriteNode *earth = [[MKElement alloc] initWithTexture:[atlas textureNamed:@"pentagram-earth.png"]];
    SKSpriteNode *fire = [[MKElement alloc] initWithTexture:[atlas textureNamed:@"pentagram-fire.png"]];
    SKSpriteNode *life = [[MKElement alloc] initWithTexture:[atlas textureNamed:@"pentagram-heart.png"]];
    SKSpriteNode *water = [[MKElement alloc] initWithTexture:[atlas textureNamed:@"pentagram-water.png"]];
    SKSpriteNode *wind = [[MKElement alloc] initWithTexture:[atlas textureNamed:@"pentagram-wind.png"]];
    
    earth.position = CGPointMake(-100, 0);
    fire.position = CGPointMake(0, 300);
    life.position = CGPointMake(150, 160);
    water.position = CGPointMake(100, 0);
    wind.position = CGPointMake(-150, 160);
    
    [_elements addObject:earth];
    [_elements addObject:fire];
    [_elements addObject:life];
    [_elements addObject:water];
    [_elements addObject:wind];
    
    [_pentagram addChild:earth];
    [_pentagram addChild:fire];
    [_pentagram addChild:life];
    [_pentagram addChild:water];
    [_pentagram addChild:wind];
}

- (void)setUpButtons
{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"button.png"];
    _skillButton = [SKSpriteNode spriteNodeWithTexture:texture
                                                  size:CGSizeMake(150, 80)];
    _skillButton.anchorPoint = CGPointMake(0.5, 0.5);
    _skillButton.position = CGPointMake(0, 130);
    _skillButton.alpha = 0.25;
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chulkduster"];
    label.text = @"ATTACK";
    label.position = CGPointMake(0, -10);
    
    
    [_skillButton addChild:label];
    
    [_pentagram addChild:_skillButton];
}

- (void)setUpWizards
{
    SKTexture *texture1 = [SKTexture textureWithImageNamed:@"wizard-1-prepare.png"];
    SKTexture *texture2 = [SKTexture textureWithImageNamed:@"wizard-2-prepare.png"];
    
    _hero = [[MKHero alloc] initWithTexture:texture2];
    _hero.position = CGPointMake(_hero.size.width / 2 + 10,
                                 25 + _hero.size.height / 2);
    
    [self addChild:_hero];
    
    _enemy = [[MKEnemy alloc] initWithTexture:texture1];
    _enemy.position = CGPointMake(self.frame.size.width - _enemy.size.width / 2 - 10,
                                  25 + _hero.size.height / 2);
    
    [self addChild:_enemy];
}

- (void)setUpHUD
{
    SKSpriteNode *heroBar = [SKSpriteNode spriteNodeWithImageNamed:@"mana-container.png"];
    heroBar.anchorPoint = CGPointZero;
    heroBar.xScale = 1.5;
    heroBar.position = CGPointMake(0, self.frame.size.height - heroBar.size.height - 10);
    
    [self addChild:heroBar];
    
    SKSpriteNode *enemyBar = [SKSpriteNode spriteNodeWithImageNamed:@"mana-container.png"];
    enemyBar.anchorPoint = CGPointZero;
    enemyBar.xScale = 1.5;
    enemyBar.position = CGPointMake(self.frame.size.width - enemyBar.size.width,
                                    self.frame.size.height - heroBar.size.height - 10);
    [self addChild:enemyBar];
    
    SKTexture *heart = [SKTexture textureWithImageNamed:@"heart-full.png"];
    _heroHP = [NSMutableArray array];
    _enemyHP = [NSMutableArray array];
    
    for (int i = 0; i < 6; ++i)
    {
        SKSpriteNode *full = [SKSpriteNode spriteNodeWithTexture:heart];
        full.anchorPoint = CGPointZero;
        full.position = CGPointMake(10 + i * (full.size.width -5), 25);
        SKSpriteNode *copy = [full copy];
        [_heroHP addObject:full];
        [_enemyHP addObject:copy];
        
        [heroBar addChild:full];
        [enemyBar addChild:copy];
    }
    
    _heroMana = [SKLabelNode labelNodeWithFontNamed:@"chulkduster"];
    
    _heroMana.position = CGPointMake(100, heroBar.position.y - 10);
    
    _heroMana.text = @"60";
    
    [self addChild:_heroMana];
}

- (void)setUpMusicPlayer
{
    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:@"theme"
                                              withExtension:@"mp3"];
    _musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL
                                                          error:nil];
    _musicPlayer.numberOfLoops = -1;
    _musicPlayer.volume = 0.5;
}

- (void)playMusic
{
    [_musicPlayer play];
}

#pragma mark - Event handling

- (void)mouseDown:(NSEvent *)theEvent
{
    if ([_skillButton containsPoint:[theEvent locationInNode:_pentagram]])
    {
        if (_skillButton.alpha == 0.6f)
        {
            _skillButton.alpha = 0.25;
            
            MKSkill *skill = [[MKSkill alloc] initWithElements:_elements];
            
            [_hero castSkill:skill];
            [_client sendMessage:(int)skill.type];
            
            for (MKElement *element in _elements)
            {
                element.isSelected = NO;
                element.alpha = 0.25;
            }
        }
    }
}

#pragma mark - Rendering frames

- (void)update:(NSTimeInterval)currentTime
{
    for (MKElement *element in _elements)
    {
        if (element.isSelected == YES)
        {
            _skillButton.alpha = 0.6;
            break;
        }
        _skillButton.alpha = 0.25;
    }
    
    if (_client.skill != 0)
    {
        [_enemy castSkill:_client.skill];
        _client.skill = 0;
    }
    
    if (_hero.mana < 60.0f)
    {
        _hero.mana += 0.1;
    }
    _heroMana.text = [NSString stringWithFormat:@"%d MP", (int)_hero.mana];
}

- (void)updateHUD
{
    for (int i = 5; i >= _hero.health / 10.0f ; --i)
    {
        [[_heroHP objectAtIndex:i] setTexture:[SKTexture textureWithImageNamed:@"heart-damage.png"]];
    }
    for (int i = 5; i >= _enemy.health / 10.0f; --i)
    {
        [[_enemyHP objectAtIndex:i] setTexture:[SKTexture textureWithImageNamed:@"heart-damage.png"]];
    }
}

#pragma mark - Contacts handling

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *wallOrWizard, *skill;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        wallOrWizard = contact.bodyA;
        skill = contact.bodyB;
    } else
    {
        wallOrWizard = contact.bodyB;
        skill = contact.bodyA;
    }
    
    [skill.node removeFromParent];
    
    switch (wallOrWizard.categoryBitMask)
    {
        case heroCategory:
        {
            NSArray *textures = [NSArray arrayWithObjects:
                                 [SKTexture textureWithImageNamed:@"wizard-2-damage.png"],
                                 [SKTexture textureWithImageNamed:@"wizard-2-prepare.png"],
                                 nil];
            [_hero runAction:[SKAction animateWithTextures:textures
                                             timePerFrame:1.0f]];
            if ([_hero isAttackedBy:skill.categoryBitMask])
            {
                [[_heroHP objectAtIndex:0] setTexture:[SKTexture textureWithImageNamed:@"heart-damage.png"]];
                [_client sendMessage:3];
                [_client stop];
                [self endGame:YES];
            }
            printf("hero %f\n", _hero.health);
            break;
        }
        case enemyCategory:
        {
            if ([_enemy isAttackedBy:skill.categoryBitMask])
            {
                [[_enemyHP objectAtIndex:0] setTexture:
                 [SKTexture textureWithImageNamed:@"heart-damage.png"]];
                [_client sendMessage:4];
                [_client stop];
                [self endGame:NO];
            }else
            {
                NSArray *textures = [NSArray arrayWithObjects:
                                     [SKTexture textureWithImageNamed:@"wizard-1-damage.png"],
                                     [SKTexture textureWithImageNamed:@"wizard-1-prepare.png"],
                                     nil];
                [_enemy runAction:[SKAction animateWithTextures:textures
                                                   timePerFrame:1.0f]];
            }
            printf("enemy %f\n", _enemy.health);
            break;
        }
        case earthwallCategory:
        {
            [self destroyWallWithName:@"earthwall"];
            break;
        }
        case icewallCategory:
        {
            [self destroyWallWithName:@"icewall"];
            break;
        }
        case enemyEarthwallCategory:
        {
            [self destroyWallWithName:@"enemyEarthwall"];
            break;
        }
        case enemyIcewallCategory:
        {
            [self destroyWallWithName:@"enemyIcewall"];
            break;
        }
    }
    [self updateHUD];
}

- (void)destroyWallWithName:(NSString *)name
{
    [[self childNodeWithName:name] removeFromParent];
}

- (void)endGame:(BOOL)win
{
    exit(0);
}

@end
