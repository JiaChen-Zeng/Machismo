//
//  CardMatchingGame.h
//  Machismo
//
//  Created by 彩月葵 on 2018/03/17.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "ChoosingResult.h"

@interface CardMatchingGame : NSObject

extern NSString *const RESULT_TYPE_FLIP_UP;
extern NSString *const RESULT_TYPE_FLIP_DOWN;
extern NSString *const RESULT_TYPE_MATCH;
extern NSString *const RESULT_TYPE_MISMATCH;
extern NSString *const RESULT_TYPE_DISABLE;

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                    choosingCount:(NSUInteger)choosingCount;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger choosingCount;
@property (nonatomic, readonly) BOOL started;

- (ChoosingResult *)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
