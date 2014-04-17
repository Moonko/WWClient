//
//  MKGameScene.h
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class MKClient;
@class MKHero;
@class MKEnemy;
@class AVAudioPlayer;

@interface MKGameScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic) MKClient *client;

@property (nonatomic) AVAudioPlayer *musicPlayer;

@property (nonatomic) SKSpriteNode *background;
@property (nonatomic) SKSpriteNode *skillButton;
@property (nonatomic) SKNode *pentagram;

@property (nonatomic) MKHero *hero;
@property (nonatomic) MKEnemy *enemy;

@property (nonatomic) NSMutableArray *elements;
@property (nonatomic) NSMutableArray *heroHP;
@property (nonatomic) NSMutableArray *enemyHP;

- (void)playMusic;

@end
