//
//  Father.m
//  ConclusionOnIOS
//
//  Created by 大麦 on 16/1/22.
//  Copyright (c) 2016年 lsp. All rights reserved.
//

#import "Father.h"

@interface Father ()

@property (nonatomic, retain) NSString *name;

-(void)sayHello;

@end

@implementation Father

- (id)init
{
    if (self = [super init]) {
        self.age = 27;
        self.name = @"wengzilin";
    }
    return self;
}
- (void)dealloc
{
    self.name = nil;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@, age:%d", _name, self.age];
}
- (void)sayHello
{
    NSLog(@"%@ says hello to you!", _name);
}
- (void)sayGoodbay
{
    NSLog(@"%@ says goodbya to you!", _name);
}

@end
