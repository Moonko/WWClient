//
//  MKSkill.h
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKSkill : NSObject

@property (nonatomic) unsigned int type;

- (id)initWithElements:(NSArray *)elements;

- (id)initWithType:(unsigned int)type;

@end
