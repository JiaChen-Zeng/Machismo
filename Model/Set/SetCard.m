//
//  SetCard.m
//  Machismo
//
//  Created by 彩月葵 on 2018/03/22.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "SetCard.h"
#import "SetGame.h"

@interface SetCard()

@end

@implementation SetCard

+ (NSUInteger)maxNumber {
    return 3;
}

+ (NSArray *)validSymbols {
    return @[SYMBOL_TRIANGLE, SYMBOL_CIRCLE, SYMBOL_SQUARE];
}

+ (NSArray *)validShadings {
    return @[SHADING_SOLID, SHADING_GRAY, SHADING_OPEN];
}

+ (NSArray *)validColor {
    return @[COLOR_RED, COLOR_GREEN, COLOR_PURPLE];
}

+ (int)match:(NSArray *)cards {
    if (cards.count != 4) return 0;
    
    BOOL numberSame  = true;
    BOOL symbolSame  = true;
    BOOL shadingSame = true;
    BOOL colorSame   = true;
    for (unsigned i = 0; i < cards.count - 1; ++i) {
        SetCard *cardPrev = cards[i];
        SetCard *cardNext = cards[i + 1];
        
        if (cardPrev.number    !=              cardNext.number)   numberSame  = false;
        if (![cardPrev.symbol  isEqualToString:cardNext.symbol])  symbolSame  = false;
        if (![cardPrev.shading isEqualToString:cardNext.shading]) shadingSame = false;
        if (![cardPrev.color   isEqualToString:cardNext.color])   colorSame   = false;
    }
    
    BOOL numberDifferent  = true;
    BOOL symbolDifferent  = true;
    BOOL shadingDifferent = true;
    BOOL colorDifferent   = true;
    for (unsigned i = 0; i < cards.count; ++i) {
        for (unsigned j = i + 1; j < cards.count; ++j) {
            SetCard *cardPrev = cards[i];
            SetCard *cardNext = cards[i + 1];
            
            if (cardPrev.number   ==              cardNext.number)   numberDifferent  = false;
            if ([cardPrev.symbol  isEqualToString:cardNext.symbol])  symbolDifferent  = false;
            if ([cardPrev.shading isEqualToString:cardNext.shading]) shadingDifferent = false;
            if ([cardPrev.color   isEqualToString:cardNext.color])   colorDifferent   = false;
        }
    }
    
    return (numberSame  || numberDifferent)  &&
           (symbolSame  || symbolDifferent)  &&
           (shadingSame || shadingDifferent) &&
           (colorSame   || colorDifferent);
}

- (void)setNumber:(NSUInteger)number {
    if (SetCard.maxNumber < number) return;
    
    self.number = number;
}

- (void)setSymbol:(NSString *)symbol {
    if (![SetCard.validSymbols containsObject:symbol]) return;
    
    self.symbol = symbol;
}

- (void)setShading:(NSString *)shading {
    if (![SetCard.validShadings containsObject:shading]) return;
    
    self.shading = shading;
}

- (void)setColor:(NSString *)color {
    if (![SetCard.validColor containsObject:color]) return;
    
    self.color = color;
}

@end
