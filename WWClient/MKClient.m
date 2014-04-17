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
    addr.sin_addr.s_addr = inet_addr("169.254.24.9");
    
    if (connect(_sock, (struct sockaddr *)&addr, sizeof(addr)) < 0)
    {
        perror("connect");
        exit(2);
    }
    
    printf("Connected\n");
    
    recv(_sock, &background, sizeof(int), 0);
    
    _background = [NSNumber numberWithInt:background];
    
    _skill = 0;
    
    NSThread *enemyThread = [[NSThread alloc] initWithTarget:self
                                                    selector:@selector(listen)
                                                      object:nil];
    [enemyThread start];
}

- (void)listen
{
    while (1)
    {
        recv(_sock, &_skill, sizeof(unsigned int), 0);
    }
}

- (void)stop
{
    close(_sock);
}

- (void)sendCast:(unsigned int)skill
{
    send(_sock, &skill, sizeof(unsigned int), 0);
}

@end
