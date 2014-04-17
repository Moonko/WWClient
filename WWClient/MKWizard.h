//
//  MKWizard.h
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static const uint32_t heroCategory            =   0x1 << 0;
static const uint32_t enemyCategory           =   0x1 << 1;
static const uint32_t earthwallCategory       =   0x1 << 2;
static const uint32_t enemyEarthwallCategory  =   0x1 << 3;
static const uint32_t enemyIcewallCategory    =   0x1 << 4;
static const uint32_t icewallCategory         =   0x1 << 5;
static const uint32_t fireballCategory        =   0x1 << 6;
static const uint32_t windblastCategory       =   0x1 << 7;
static const uint32_t vineCategory            =   0x1 << 8;
static const uint32_t ogreCategory            =   0x1 << 9;
static const uint32_t bubbleCategory          =   0x1 << 10;
static const uint32_t enemyFireballCategory   =   0x1 << 11;
static const uint32_t enemyWindblastCategory  =   0x1 << 12;
static const uint32_t enemyVineCategory       =   0x1 << 13;
static const uint32_t enemyOgreCategory       =   0x1 << 14;
static const uint32_t enemyBubbleCategory     =   0x1 << 15;

static const unsigned int fireball  = 1001;
static const unsigned int earthwall = 11000;
static const unsigned int bubble    = 101;
static const unsigned int icewall   = 10011;
static const unsigned int ogre      = 10100;
static const unsigned int vine      = 10110;
static const unsigned int windblast = 1101;

@class MKSkill;

@interface MKWizard : SKSpriteNode

@property (nonatomic) CGFloat health;
@property (nonatomic) CGFloat mana;

- (BOOL)isAttackedBy:(uint32_t)projectileCategory;

- (void)playSoundWithName:(NSString *)name;

- (BOOL)haveEnoughMana;

@end
