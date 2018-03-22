//
//  PlayingCard.m
//  Machismo
//
//  Created by 彩月葵 on 2018/03/17.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

+ (int)match:(NSArray *)cards {
    int score = 0;
    
    for (int i = 0; i < cards.count; ++i) {
        for (int j = i + 1; j < cards.count; ++j) {
            PlayingCard *card = cards[i];
            PlayingCard *otherCard = cards[j];
            if (card.rank == otherCard.rank) {
                score += 4;
            } else if ([card.suit isEqualToString:otherCard.suit]) {
                score += 1;
            }
        }
    }
    
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits {
    return @[@"♣︎", @"♦︎", @"♥︎", @"♠︎"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[PlayingCard rankStrings] count] - 1;
}

- (void)setRank:(NSInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
