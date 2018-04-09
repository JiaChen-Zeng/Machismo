//
//  Game.m
//  Machismo
//
//  Created by 彩月葵 on 2018/04/09.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "Game.h"

@interface Game()

@end

@implementation Game

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                    choosingCount:(NSUInteger)choosingCount {
    self = [super init];
    if (!self || !deck) return nil;
    
    for (int i = 0; i < count; ++i) {
        [self.cards addObject:[deck drawRandomCard]];
    }
    
    self.choosingCount = choosingCount;
    self.chosenCount = 0;
    
    return self;
}

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)setChoosingCount:(NSUInteger)choosingCount {
    if ([self.cards count] < choosingCount || choosingCount < 2) return;
    
    _choosingCount = choosingCount;
}

- (ChoosingResult *)chooseCardAtIndex:(NSUInteger)index {
    return nil;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return index < [self.cards count] ? self.cards[index]
    : nil;
}

@end
