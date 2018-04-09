//
//  SetCard.h
//  Machismo
//
//  Created by 彩月葵 on 2018/03/22.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *shading;
@property (nonatomic, strong) NSString *color;

+ (NSUInteger)maxNumber;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColor;

@end
