//
//  MKClient.h
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <sys/types.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface MKClient : NSObject

@property (nonatomic) NSNumber *background;

@property (nonatomic) int sock;

@property (nonatomic) int skill;

@property (nonatomic) BOOL canStartGame;

- (void)sendMessage:(int)message;

- (void)stop;

@end
