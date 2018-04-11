//
//  CardMatchingGame.m
//  Machismo
//
//  Created by 彩月葵 on 2018/03/17.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "CardMatchingGame.h"

@implementation CardMatchingGame

+ (NSUInteger)mismatchPanelty {
    return 2;
}

+ (NSUInteger)matchBonus {
    return 4;
}

+ (NSUInteger)costToChoose {
    return 1;
}

@end
