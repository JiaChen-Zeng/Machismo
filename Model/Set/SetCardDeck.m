//
//  SetCardDeck.m
//  Machismo
//
//  Created by 彩月葵 on 2018/03/22.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    for (NSString *symbol  in [SetCard validSymbols]) {
        for (NSString *shading in [SetCard validShadings]) {
            for (NSString *color in [SetCard validColor]) {
                SetCard *card = [[SetCard alloc] init];
                card.symbol = symbol;
                card.shading = shading;
                card.color = color;
                [self addCard:card];
            }
        }
    }
    
    return self;
}

@end
