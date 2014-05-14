//
//  MKMainMenuScene.h
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class MKClient;

@interface MKMainMenuScene : SKScene <NSTextFieldDelegate>

@property (nonatomic) MKClient *client;

- (id)initWithSize:(CGSize)size client:(MKClient *)client;

@end
