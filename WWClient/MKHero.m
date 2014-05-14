//
//  MKHero.m
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import "MKHero.h"
#import "MKElement.h"
#import "MKSkill.h"

@implementation MKHero

- (id)initWithTexture:(SKTexture *)texture
{
    if (self = [super initWithTexture:texture])
    {
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width - 100,
                                                                             self.size.height)];
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.dynamic = YES;
        self.physicsBody.categoryBitMask = heroCategory;
        self.physicsBody.contactTestBitMask = enemyFireballCategory | enemyBubbleCategory
        | enemyWindblastCategory | enemyOgreCategory | enemyVineCategory;
    }
    
    return self;
}

- (BOOL)isAttackedBy:(uint32_t)projectileCategory
{
    if ([super isAttackedBy:projectileCategory])
    {
        [self setTexture:[SKTexture textureWithImageNamed:@"wizard-2-dead.png"]];
        return YES;
    } else
    {
        return NO;
    }
}

- (void)castSkill:(MKSkill *)skill;
{
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"wizard-2-attack"],
                          [SKTexture textureWithImageNamed:@"wizard-2-prepare"]];
    
    [self runAction:[SKAction animateWithTextures:textures
                                     timePerFrame:1]];
    
    switch (skill.type)
    {
        case fireball:
        {
            [self fireball];
            break;
        }
        case earthwall:
        {
            [self earthwall];
            break;
        }
        case bubble:
        {
            [self bubble];
            break;
        }
        case icewall:
        {
            [self icewall];
            break;
        }
        case ogre:
        {
            [self ogre];
            break;
        }
        case vine:
        {
            [self vine];
            break;
        }
        case windblast:
        {
            [self windblast];
            break;
        }
    }
}

- (void)fireball
{
    if ([self haveEnoughMana])
    {
        SKTexture *texture = [SKTexture textureWithImageNamed:@"fireball-1@2x.png"];
        SKSpriteNode *fireball = [SKSpriteNode spriteNodeWithTexture:texture];
        fireball.position = CGPointMake(self.frame.size.width + 20,
                                        self.frame.size.height / 2);
        fireball.anchorPoint = CGPointZero;
        
        fireball.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:fireball.size];
        fireball.physicsBody.categoryBitMask = fireballCategory;
        fireball.physicsBody.affectedByGravity = NO;
        fireball.physicsBody.contactTestBitMask = enemyCategory | enemyEarthwallCategory
        | enemyIcewallCategory;
        fireball.physicsBody.collisionBitMask = 0x0;
        
        NSArray *textures = @[[SKTexture textureWithImageNamed:@"fireball-1@2x.png"],
                              [SKTexture textureWithImageNamed:@"fireball-2@2x.png"],
                              [SKTexture textureWithImageNamed:@"fireball-3@2x.png"],
                              [SKTexture textureWithImageNamed:@"fireball-4@2x.png"],
                              [SKTexture textureWithImageNamed:@"fireball-5@2x.png"],];
        
        SKAction *animation = [SKAction repeatActionForever:
                               [SKAction animateWithTextures:textures
                                                timePerFrame:0.3]];
        
        SKAction *seq = [SKAction sequence:@[[SKAction waitForDuration:0.5],
                                             [SKAction moveByX:450 y:0.0f
                                                      duration:5.0f]]];
        [self.scene addChild:fireball];
        [fireball runAction:animation];
        [fireball runAction:seq];
        [self playSoundWithName:@"fireball.mp3"];
    }
}

- (void)earthwall
{
    if (![self.scene childNodeWithName:@"earthwall"] && ![self.scene childNodeWithName:@"icewall"] && [self haveEnoughMana])
    {
        SKSpriteNode *earthwall = [SKSpriteNode spriteNodeWithImageNamed:@"earth-wall-right-1@2x.png"];
        earthwall.name = @"earthwall";
        earthwall.size = CGSizeMake(100, 200);
        earthwall.position = CGPointMake(self.size.width + 20, 25);
        earthwall.anchorPoint = CGPointZero;
        
        earthwall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:earthwall.size];
        earthwall.physicsBody.categoryBitMask = earthwallCategory;
        earthwall.physicsBody.affectedByGravity = NO;
        earthwall.physicsBody.contactTestBitMask = enemyFireballCategory | vineCategory
        | enemyWindblastCategory | enemyOgreCategory;
        earthwall.physicsBody.collisionBitMask = 0x0;
        earthwall.physicsBody.dynamic = YES;
        
        NSArray *textures = @[[SKTexture textureWithImageNamed:@"earth-wall-right-1@2x.png"],
                              [SKTexture textureWithImageNamed:@"earth-wall-right-2@2x.png"],
                              [SKTexture textureWithImageNamed:@"earth-wall-right-3@2x.png"],
                              [SKTexture textureWithImageNamed:@"earth-wall-right-4@2x.png"],];
        [self.scene addChild:earthwall];
        [earthwall runAction:[SKAction animateWithTextures:textures
                                              timePerFrame:0.3]];
        [self playSoundWithName:@"earthwall.mp3"];
    }
}

- (void)bubble
{
    if ([self haveEnoughMana])
    {
        SKTexture *texture = [SKTexture textureWithImageNamed:@"bubble-1@2x.png"];
        
        SKSpriteNode *bubble = [SKSpriteNode spriteNodeWithTexture:texture];
        bubble.anchorPoint = CGPointZero;
        bubble.position = CGPointMake(self.frame.size.width + 20,
                                      self.frame.size.height / 2);
        
        bubble.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bubble.size];
        bubble.physicsBody.categoryBitMask = bubbleCategory;
        bubble.physicsBody.affectedByGravity = NO;
        bubble.physicsBody.contactTestBitMask = enemyCategory | enemyIcewallCategory;
        bubble.physicsBody.collisionBitMask = 0x0;
        
        NSArray *textures = @[[SKTexture textureWithImageNamed:@"bubble-1@2x.png"],
                              [SKTexture textureWithImageNamed:@"bubble-2@2x.png"]];
        SKAction *animation = [SKAction repeatActionForever:
                               [SKAction animateWithTextures:textures timePerFrame:0.3]];
        SKAction *seq = [SKAction sequence:@[[SKAction waitForDuration:0.5],
                                             [SKAction moveByX:450 y:0.0f duration:5.0f]]];
        [self.scene addChild:bubble];
        [bubble runAction:animation];
        [bubble runAction:seq];
        [self playSoundWithName:@"bubble.mp3"];
    }
}

- (void)icewall
{
    if (![self.scene childNodeWithName:@"icewall"] && ![self.scene childNodeWithName:@"earthwall"] && [self haveEnoughMana])
    {
        SKSpriteNode *icewall = [SKSpriteNode spriteNodeWithImageNamed:@"ice-wall-right-1@2x.png"];
        icewall.name = @"icewall";
        icewall.size = CGSizeMake(100, 200);
        icewall.position = CGPointMake(self.size.width + 20, 25);
        icewall.anchorPoint = CGPointZero;
        
        icewall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:icewall.size];
        icewall.physicsBody.categoryBitMask = icewallCategory;
        icewall.physicsBody.affectedByGravity = NO;
        icewall.physicsBody.contactTestBitMask = enemyFireballCategory | enemyBubbleCategory
        | enemyWindblastCategory | enemyOgreCategory;
        icewall.physicsBody.collisionBitMask = 0x0;
        icewall.physicsBody.dynamic = YES;
        
        NSArray *textures = @[[SKTexture textureWithImageNamed:@"ice-wall-right-1@2x.png"],
                              [SKTexture textureWithImageNamed:@"ice-wall-right-2@2x.png"],
                              [SKTexture textureWithImageNamed:@"ice-wall-right-3@2x.png"],
                              [SKTexture textureWithImageNamed:@"ice-wall-right-4@2x.png"],];
        [self.scene addChild:icewall];
        [icewall runAction:[SKAction animateWithTextures:textures
                                              timePerFrame:0.3]];
        [self playSoundWithName:@"icewall.mp3"];
    }
}

- (void)ogre
{
    if ([self haveEnoughMana])
    {
        SKTexture *texture = [SKTexture textureWithImageNamed:@"ogre-1@2x.png"];
        SKSpriteNode *ogre = [SKSpriteNode spriteNodeWithTexture:texture];
        
        ogre.position = CGPointMake(self.size.width + 50, 25);
        ogre.anchorPoint = CGPointZero;
        
        ogre.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ogre.size];
        ogre.physicsBody.categoryBitMask = ogreCategory;
        ogre.physicsBody.affectedByGravity = NO;
        ogre.physicsBody.contactTestBitMask = enemyCategory | enemyIcewallCategory
        | enemyEarthwallCategory;
        ogre.physicsBody.collisionBitMask = 0x0;
        
        NSArray *textures = @[[SKTexture textureWithImageNamed:@"ogre-1@2x.png"],
                              [SKTexture textureWithImageNamed:@"ogre-2@2x.png"],
                              [SKTexture textureWithImageNamed:@"ogre-3@2x.png"]];
        SKAction *animation = [SKAction repeatActionForever:
                               [SKAction animateWithTextures:textures
                                                timePerFrame:0.3]];
        SKAction *seq = [SKAction sequence:@[[SKAction waitForDuration:0.5],
                                             [SKAction moveByX:450 y:0.0f duration:10.0f]]];
        [self.scene addChild:ogre];
        [ogre runAction:animation];
        [ogre runAction:seq];
    }
}

- (void)vine
{
    
}

- (void)windblast
{
    if ([self haveEnoughMana])
    {
        SKTexture *texture = [SKTexture textureWithImageNamed:@"wind-blast-1@2x.png"];
        SKSpriteNode *windblast = [SKSpriteNode spriteNodeWithTexture:texture];
        windblast.position = CGPointMake(self.frame.size.width + 20,
                                         self.frame.size.height / 2);
        windblast.anchorPoint = CGPointZero;
        
        windblast.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:windblast.size];
        windblast.physicsBody.categoryBitMask = windblastCategory;
        windblast.physicsBody.affectedByGravity = NO;
        windblast.physicsBody.contactTestBitMask = enemyCategory | enemyIcewallCategory;
        windblast.physicsBody.collisionBitMask = 0x0;
        
        NSArray *textures = @[[SKTexture textureWithImageNamed:@"wind-blast-1@2x.png"],
                              [SKTexture textureWithImageNamed:@"wind-blast-2@2x.png"],
                              [SKTexture textureWithImageNamed:@"wind-blast-3@2x.png"],
                              [SKTexture textureWithImageNamed:@"wind-blast-4@2x.png"],
                              [SKTexture textureWithImageNamed:@"wind-blast-5@2x.png"],
                              [SKTexture textureWithImageNamed:@"wind-blast-6@2x.png"],];
        
        SKAction *animation = [SKAction repeatActionForever:
                               [SKAction animateWithTextures:textures
                                                timePerFrame:0.3]];
        
        SKAction *seq = [SKAction sequence:@[[SKAction waitForDuration:0.5],
                                             [SKAction moveByX:450 y:0.0f
                                                      duration:5.0f]]];
        [self.scene addChild:windblast];
        [windblast runAction:animation];
        [windblast runAction:seq];
        [self playSoundWithName:@"windblast.mp3"];
    }
}

@end

