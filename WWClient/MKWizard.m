//
//  MKWizard.m
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import "MKWizard.h"

@implementation MKWizard

- (id)initWithTexture:(SKTexture *)texture
{
    if (self == [super initWithTexture:texture])
    {
        self.size = CGSizeMake(300, 300);
        self.userInteractionEnabled = NO;
        self.anchorPoint = CGPointMake(0.5, 0.5);
        self.health = 60.0f;
        self.mana = 60.0f;
    }
    return self;
}

- (BOOL)isAttackedBy:(uint32_t)projectileCategory
{
    _health -= 10.0f;
    
    if (_health <= 0.0f)
    {
        [self removeAllActions];
        return YES;
    } else
    {
        return NO;
    }
}

- (void)playSoundWithName:(NSString *)name
{
    SKAction *soundAction = [SKAction playSoundFileNamed:name
                                       waitForCompletion:NO];
    [self runAction:soundAction];
}

- (BOOL)haveEnoughMana
{
    if (self.mana >= 20.0f)
    {
        self.mana -= 20.0f;
        return  YES;
    }
    return NO;
}

@end
