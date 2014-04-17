//
//  MKHero.h
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import "MKWizard.h"

@class MKSkill;

@interface MKHero : MKWizard

- (void)castSkill:(MKSkill *)skill;

@end
