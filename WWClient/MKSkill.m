//
//  MKSkill.m
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import "MKSkill.h"
#import "MKElement.h"

@implementation MKSkill

- (id)initWithElements:(NSArray *)elements
{
    if (self == [super init])
    {
        _type = 0;
        
        for (MKElement *element in elements)
        {
            _type = (_type * 10) + [[NSNumber numberWithBool:element.isSelected] intValue];
        }
    }
    
    return self;
}

- (id)initWithType:(unsigned int)type
{
    if (self == [super init])
    {
        _type = type;
    }
    
    return self;
}

@end
