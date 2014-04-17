//
//  MKElement.m
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import "MKElement.h"

@implementation MKElement

- (id) initWithTexture:(SKTexture *)texture
{
    if (self == [super initWithTexture:texture])
    {
        self.userInteractionEnabled = YES;
        self.anchorPoint = CGPointMake(0.5, 0.5);
        self.alpha = 0.25;
        
        _isSelected = NO;
    }
    
    return self;
}

- (void)mouseDown:(NSEvent *)theEvent
{
    if (!_isSelected)
    {
        _isSelected = YES;
        self.alpha = 0.6;
    } else
    {
        _isSelected = NO;
        self.alpha = 0.25;
    }
}

@end
