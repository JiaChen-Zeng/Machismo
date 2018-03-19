//
//  CardMatchingGame.m
//  Machismo
//
//  Created by 彩月葵 on 2018/03/17.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {
    self = [super init];
    if (!self || !deck) return nil;
    
    for (int i = 0; i < count; ++i) {
        [self.cards addObject:[deck drawRandomCard]];
    }
    
    return self;
}

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

static const int MISMATCH_PANELTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if (card.isMatched) return;
    
    if (card.isChosen) {
        card.chosen = NO;
    } else {
        for (Card *otherCard in self.cards) {
            if (!(otherCard.isChosen && !otherCard.isMatched)) continue;
            
            int matchScore = [card match:@[otherCard]];
            if (matchScore) {
                self.score += matchScore * MATCH_BONUS;
                card.matched = YES;
                otherCard.matched = YES;
            } else {
                self.score -= MISMATCH_PANELTY;
                otherCard.chosen = NO;
            }
            break; // only match 2 cards for now
        }
        self.score -= COST_TO_CHOOSE;
        card.chosen = YES;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return index < [self.cards count] ? self.cards[index]
                                      : nil;
}

@end
