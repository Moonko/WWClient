//
//  MKEnemy.m
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import "MKEnemy.h"
#import "MKElement.h"
#import "MKSkill.h"

@implementation MKEnemy

- (id)initWithTexture:(SKTexture *)texture
{
    if (self == [super initWithTexture:texture])
    {
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.dynamic = YES;
        self.physicsBody.categoryBitMask = enemyCategory;
        self.physicsBody.contactTestBitMask = fireballCategory | windblastCategory
        | ogreCategory | bubbleCategory | vineCategory;
    }
    
    return self;
}

- (BOOL)isAttackedBy:(uint32_t)projectileCategory
{
    if ([super isAttackedBy:projectileCategory])
    {
        [self setTexture:[SKTexture textureWithImageNamed:@"wizard-1-dead.png"]];
        return YES;
    } else
    {
        return NO;
    }
}

- (void)castSkill:(unsigned int)type
{
    MKSkill *skill = [[MKSkill alloc] initWithType:type];
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"wizard-1-attack"],
                          [SKTexture textureWithImageNamed:@"wizard-1-prepare"]];
    
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
    SKTexture *texture = [SKTexture textureWithImageNamed:@"fireball-1@2x.png"];
    SKSpriteNode *fireball = [SKSpriteNode spriteNodeWithTexture:texture];
    fireball.position = CGPointMake(self.scene.size.width - self.size.width - fireball.size.width - 20,
                                    self.frame.size.height / 2);
    fireball.anchorPoint = CGPointZero;
    
    fireball.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:fireball.size];
    fireball.physicsBody.categoryBitMask = enemyFireballCategory;
    fireball.physicsBody.affectedByGravity = NO;
    fireball.physicsBody.contactTestBitMask = heroCategory | earthwallCategory
    | icewallCategory;
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
                                         [SKAction moveByX:-450 y:0.0f
                                                  duration:5.0f]]];
    [self.scene addChild:fireball];
    [fireball runAction:animation];
    [fireball runAction:seq];
    [self playSoundWithName:@"fireball.mp3"];
}

- (void)earthwall
{
    if (![self.scene childNodeWithName:@"enemyEarthwall"] && ![self.scene childNodeWithName:@"enemyIcewall"])
    {
        SKSpriteNode *earthwall = [SKSpriteNode spriteNodeWithImageNamed:@"earth-wall-left-1@2x.png"];
        earthwall.name = @"enemyEarthwall";
        earthwall.size = CGSizeMake(100, 200);
        earthwall.position = CGPointMake(self.scene.size.width - self.size.width - earthwall.size.width - 20, 25);
        earthwall.anchorPoint = CGPointZero;
        
        earthwall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:earthwall.size];
        earthwall.physicsBody.categoryBitMask = enemyEarthwallCategory;
        earthwall.physicsBody.affectedByGravity = NO;
        earthwall.physicsBody.contactTestBitMask = fireballCategory | windblastCategory
        | ogreCategory | vineCategory;
        earthwall.physicsBody.collisionBitMask = 0x0;
        earthwall.physicsBody.dynamic = YES;
        
        NSArray *textures = @[[SKTexture textureWithImageNamed:@"earth-wall-left-1@2x.png"],
                              [SKTexture textureWithImageNamed:@"earth-wall-left-2@2x.png"],
                              [SKTexture textureWithImageNamed:@"earth-wall-left-3@2x.png"],
                              [SKTexture textureWithImageNamed:@"earth-wall-left-4@2x.png"],];
        [self.scene addChild:earthwall];
        [earthwall runAction:[SKAction animateWithTextures:textures
                                              timePerFrame:0.3]];
        [self playSoundWithName:@"earthwall.mp3"];
    }
}

- (void)bubble
{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"bubble-1@2x.png"];
    
    SKSpriteNode *bubble = [SKSpriteNode spriteNodeWithTexture:texture];
    bubble.anchorPoint = CGPointZero;
    bubble.position = CGPointMake(self.scene.size.width - self.size.width - bubble.size.width - 20,
                                  self.frame.size.height / 2);
    
    bubble.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bubble.size];
    bubble.physicsBody.categoryBitMask = enemyBubbleCategory;
    bubble.physicsBody.affectedByGravity = NO;
    bubble.physicsBody.contactTestBitMask = heroCategory | icewallCategory;
    bubble.physicsBody.collisionBitMask = 0x0;
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"bubble-1@2x.png"],
                          [SKTexture textureWithImageNamed:@"bubble-2@2x.png"]];
    SKAction *animation = [SKAction repeatActionForever:
                           [SKAction animateWithTextures:textures timePerFrame:0.3]];
    SKAction *seq = [SKAction sequence:@[[SKAction waitForDuration:0.5],
                                         [SKAction moveByX:-450 y:0.0f duration:5.0f]]];
    [self.scene addChild:bubble];
    [bubble runAction:animation];
    [bubble runAction:seq];
    [self playSoundWithName:@"bubble.mp3"];
}

- (void)icewall
{
    if (![self.scene childNodeWithName:@"enemyEarthwall"] && ![self.scene childNodeWithName:@"enemyIcewall"])
    {
        SKSpriteNode *icewall = [SKSpriteNode spriteNodeWithImageNamed:@"ice-wall-left-1@2x.png"];
        icewall.name = @"enemyIcewall";
        icewall.size = CGSizeMake(100, 200);
        icewall.position = CGPointMake(self.scene.size.width - self.size.width - icewall.size.width - 20, 25);
        icewall.anchorPoint = CGPointZero;
        
        icewall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:icewall.size];
        icewall.physicsBody.categoryBitMask = enemyIcewallCategory;
        icewall.physicsBody.affectedByGravity = NO;
        icewall.physicsBody.contactTestBitMask = fireballCategory | bubbleCategory
        | windblastCategory | ogreCategory;
        icewall.physicsBody.collisionBitMask = 0x0;
        icewall.physicsBody.dynamic = YES;
        
        NSArray *textures = @[[SKTexture textureWithImageNamed:@"ice-wall-left-1@2x.png"],
                              [SKTexture textureWithImageNamed:@"ice-wall-left-2@2x.png"],
                              [SKTexture textureWithImageNamed:@"ice-wall-left-3@2x.png"],
                              [SKTexture textureWithImageNamed:@"ice-wall-left-4@2x.png"],];
        [self.scene addChild:icewall];
        [icewall runAction:[SKAction animateWithTextures:textures
                                            timePerFrame:0.3]];
        [self playSoundWithName:@"icewall.mp3"];
    }
}


- (void)ogre
{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"ogre-1@2x.png"];
    SKSpriteNode *ogre = [SKSpriteNode spriteNodeWithTexture:texture];
    
    ogre.position = CGPointMake(self.scene.size.width - self.size.width - ogre.size.width - 20, 25);
    ogre.anchorPoint = CGPointZero;
    
    ogre.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ogre.size];
    ogre.physicsBody.categoryBitMask = enemyOgreCategory;
    ogre.physicsBody.affectedByGravity = NO;
    ogre.physicsBody.contactTestBitMask = heroCategory | enemyIcewallCategory
    | enemyEarthwallCategory;
    ogre.physicsBody.collisionBitMask = 0x0;
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"ogre-1@2x.png"],
                          [SKTexture textureWithImageNamed:@"ogre-2@2x.png"],
                          [SKTexture textureWithImageNamed:@"ogre-3@2x.png"]];
    SKAction *animation = [SKAction repeatActionForever:
                           [SKAction animateWithTextures:textures
                                            timePerFrame:0.3]];
    SKAction *seq = [SKAction sequence:@[[SKAction waitForDuration:0.5],
                                         [SKAction moveByX:-450 y:0.0f duration:10.0f]]];
    [self.scene addChild:ogre];
    [ogre runAction:animation];
    [ogre runAction:seq];
}

- (void)vine
{
    
}

- (void)windblast
{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"wind-blast-1@2x.png"];
    SKSpriteNode *windblast = [SKSpriteNode spriteNodeWithTexture:texture];
    windblast.position = CGPointMake(self.scene.size.width - self.size.width - windblast.size.width - 20,
                                     self.frame.size.height / 2);
    windblast.anchorPoint = CGPointZero;
    
    windblast.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:windblast.size];
    windblast.physicsBody.categoryBitMask = enemyWindblastCategory;
    windblast.physicsBody.affectedByGravity = NO;
    windblast.physicsBody.contactTestBitMask = heroCategory | icewallCategory;
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
                                         [SKAction moveByX:-450 y:0.0f
                                                  duration:5.0f]]];
    [self.scene addChild:windblast];
    [windblast runAction:animation];
    [windblast runAction:seq];
    [self playSoundWithName:@"windblast.mp3"];
}

@end
