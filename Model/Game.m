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

NSString *const RESULT_TYPE_FLIP_UP   = @"flip up";
NSString *const RESULT_TYPE_FLIP_DOWN = @"flip down";
NSString *const RESULT_TYPE_MATCH     = @"match";
NSString *const RESULT_TYPE_MISMATCH  = @"mismatch";
NSString *const RESULT_TYPE_DISABLE   = @"disable";

+ (NSUInteger)mismatchPanelty {
    return 0;
}

+ (NSUInteger)matchBonus {
    return 0;
}

+ (NSUInteger)costToChoose {
    return 0;
}

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
    self.started = YES;
    
    NSInteger oldScore = self.score;
    
    Card *card = [self cardAtIndex:index];
    if (card.isMatched) return [[ChoosingResult alloc] init:nil type:RESULT_TYPE_DISABLE scoreDelta:self.score - oldScore];
    
    if (card.isChosen) {
        [self setCardChosen:card chosen:NO];
        return [[ChoosingResult alloc] init:@[card] type:RESULT_TYPE_FLIP_DOWN scoreDelta:self.score - oldScore];
    } else {
        [self setCardChosen:card chosen:YES];
        
        if (self.choosingCount == self.chosenCount) {
            NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
            for (Card *chosenCard in self.cards) {
                if (!(chosenCard.isChosen && !chosenCard.isMatched)) continue;
                
                [chosenCards addObject:chosenCard];
                [self setCardChosen:chosenCard chosen:NO];
            }
            
            int matchScore = [card.class match:chosenCards];
            
            if (matchScore) {
                self.score += matchScore * self.class.matchBonus;
                
                for (Card *chosenCard in chosenCards) {
                    chosenCard.matched = YES;
                }
                
                return [[ChoosingResult alloc] init:chosenCards type:RESULT_TYPE_MATCH scoreDelta:self.score - oldScore];
            } else {
                self.score -= self.class.mismatchPanelty;
                
                return [[ChoosingResult alloc] init:chosenCards type:RESULT_TYPE_MISMATCH scoreDelta:self.score - oldScore];
            }
            
        } else {
            return [[ChoosingResult alloc] init:@[card] type:RESULT_TYPE_FLIP_UP scoreDelta:self.score - oldScore];
        }
    }
    
    return nil;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return index < [self.cards count] ? self.cards[index]
    : nil;
}

- (void)setCardChosen:(Card *)card
               chosen:(BOOL)chosen {
    if (card.isChosen != chosen) {
        self.chosenCount += chosen ? 1 : -1;
        if (chosen) self.score -= self.class.costToChoose;
    }
    
    card.chosen = chosen;
}

@end
