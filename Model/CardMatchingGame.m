//
//  CardMatchingGame.m
//  Machismo
//
//  Created by 彩月葵 on 2018/03/17.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (nonatomic) NSUInteger chosenCount;
@property (nonatomic, readwrite) BOOL started;

@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                    choosingCount:(NSUInteger)choosingCount {
    self = [super init];
    if (!self || !deck) return nil;
    
    for (int i = 0; i < count; ++i) {
        [self.cards addObject:[deck drawRandomCard]];
    }
    
    self.choosingCount = 2;
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

static const int MISMATCH_PANELTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    self.started = YES;
    
    Card *card = [self cardAtIndex:index];
    if (card.isMatched) return;
    
    if (card.isChosen) {
        [self setCardChosen:card chosen:NO];
    } else {
        [self setCardChosen:card chosen:YES];
        
        if (self.choosingCount == self.chosenCount) {
            NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
            for (Card *chosenCard in self.cards) {
                if (!(chosenCard.isChosen && !chosenCard.isMatched)) continue;
                
                [chosenCards addObject:chosenCard];
            }
            
            int matchScore = [PlayingCard match:chosenCards];
            if (matchScore) {
                self.score += matchScore * MATCH_BONUS;
                
                for (Card *chosenCard in chosenCards) {
                    chosenCard.matched = YES;
                }
            } else {
                self.score -= MISMATCH_PANELTY;
            }
            
            for (Card *chosenCard in chosenCards) {
                [self setCardChosen:chosenCard chosen:NO];
            }
        }
    }
}

- (void)setCardChosen:(Card *)card
               chosen:(BOOL)chosen {
    if (card.isChosen != chosen) {
        self.chosenCount += chosen ? 1 : -1;
        if (chosen) self.score -= COST_TO_CHOOSE;
    }
    
    card.chosen = chosen;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return index < [self.cards count] ? self.cards[index]
                                      : nil;
}

@end
