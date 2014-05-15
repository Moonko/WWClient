//
//  MKAfterBattleScene.h
//  WWClient
//
//  Created by Андрей Рычков on 09.05.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class MKClient;

@interface MKAfterBattleScene : SKScene

@property (nonatomic) MKClient *client;

- (id)initWithSize:(CGSize)size win:(BOOL)yorno client:(MKClient *)client;

@end
