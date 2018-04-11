//
//  SetGame.m
//  Machismo
//
//  Created by 彩月葵 on 2018/04/09.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "SetGame.h"

@implementation SetGame

NSString *const SYMBOL_TRIANGLE = @"▲";
NSString *const SYMBOL_CIRCLE   = @"●";
NSString *const SYMBOL_SQUARE   = @"■";

NSString *const SHADING_SOLID   = @"solid";
NSString *const SHADING_GRAY    = @"gray";
NSString *const SHADING_OPEN    = @"open";

NSString *const COLOR_RED       = @"red";
NSString *const COLOR_GREEN     = @"green";
NSString *const COLOR_PURPLE    = @"purple";

+ (NSUInteger)mismatchPanelty {
    return 5;
}

+ (NSUInteger)matchBonus {
    return 10;
}

+ (NSUInteger)costToChoose {
    return 1;
}

@end
