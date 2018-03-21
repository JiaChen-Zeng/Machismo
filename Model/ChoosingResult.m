//
//  ChoosingResult.m
//  Machismo
//
//  Created by 彩月葵 on 2018/03/22.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "ChoosingResult.h"

@interface ChoosingResult()

@property (nonatomic, strong, readwrite) NSArray *cards; // of Card
@property (nonatomic, strong, readwrite) NSString *type;
@property (nonatomic, readwrite) NSInteger scoreDelta;

@end

@implementation ChoosingResult

- (instancetype)init:(NSArray *)cards
                type:(NSString *)type
          scoreDelta:(NSInteger)scoreDelta {
    self = [super init];
    if (!self) return nil;
    
    self.cards = cards;
    self.type = type;
    self.scoreDelta = scoreDelta;
    
    return self;
}

@end
