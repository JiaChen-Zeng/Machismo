//
//  SetCard.m
//  Machismo
//
//  Created by 彩月葵 on 2018/03/22.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "SetCard.h"
#import "SetGame.h"

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

@end
