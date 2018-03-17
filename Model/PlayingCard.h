//
//  PlayingCard.h
//  Machismo
//
//  Created by 彩月葵 on 2018/03/17.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
