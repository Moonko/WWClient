//
//  MKClient.m
//  WWClient
//
//  Created by Андрей Рычков on 10.04.14.
//  Copyright (c) 2014 Andrey Rychkov. All rights reserved.
//

#import "MKClient.h"

@implementation MKClient

- (void)start
{
    struct sockaddr_in addr;
    int background;
    
    _sock = socket(AF_INET, SOCK_STREAM, 0);
    if (_sock < 0)
    {
        perror("socket");
        exit(1);
    }
    
    addr.sin_family = AF_INET;
    addr.sin_port = htons(3425);
    addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    
    if (connect(_sock, (struct sockaddr *)&addr, sizeof(addr)) < 0)
    {
        perror("connect");
        exit(2);
    }
    
    printf("Connected\n");
    
    recv(_sock, &background, sizeof(int), 0);
    
    NSThread *enemyThread = [[NSThread alloc] initWithTarget:self
                                                    selector:@selector(listen)
                                                      object:nil];
    [enemyThread start];
    
    _background = [NSNumber numberWithInt:background];
    
    _skill = 0;
}

- (void)listen
{
    while (1)
    {
        recv(_sock, &_skill, sizeof(int), 0);
    }
}

- (void)stop
{
    close(_sock);
}

- (void)sendMessage:(int)message
{
    send(_sock, &message, sizeof(int), 0);
}

- (void)restart
{
    [self start];
}

@end
