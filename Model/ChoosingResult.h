//
//  ChoosingResult.h
//  Machismo
//
//  Created by 彩月葵 on 2018/03/22.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface ChoosingResult : NSObject

// designated initializer
- (instancetype)init:(NSArray *)cards
                type:(NSString *)type
          scoreDelta:(NSInteger)scoreDelta;

@property (nonatomic, strong, readonly) NSArray *cards; // of Card
@property (nonatomic, strong, readonly) NSString *type;
@property (nonatomic, readonly) NSInteger scoreDelta;

@end
