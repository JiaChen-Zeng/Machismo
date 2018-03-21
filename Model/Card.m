//
//  Card.m
//  Machismo
//
//  Created by 彩月葵 on 2018/03/17.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "Card.h"

@implementation Card

+ (int)match:(NSArray *)cards {
    int score = 0;
    
    for (int i = 0; i < cards.count; ++i) {
        for (int j = i + 1; j < cards.count; ++j) {
            if ([((Card *)cards[i]).contents isEqualToString:((Card *)cards[j]).contents]) {
                score = 1;
            }
        }
    }
    
    return score;
}

@end
