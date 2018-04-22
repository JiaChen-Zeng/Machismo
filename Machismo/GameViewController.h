//
//  ViewController.h
//  Machismo
//
//  Created by 彩月葵 on 2018/03/17.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

// abstract
@interface GameViewController : UIViewController

// protected
- (Game *)game;
// abstract
- (Game *)createGame;
// protected
- (void)updateCardButton:(UIButton *)cardButton
                    card:(Card *)card;
// protected
- (void)updateControls:(ChoosingResult *)result;
// protected
- (void)updateResultLabel:(UILabel *)resultLabel
                   result:(ChoosingResult *)result;
// protected
- (void)resetCards;
// protected
- (void)resetCardButton:(UIButton *)cardButton;
// protected
- (void)resetControls;
- (NSUInteger)cardCount;

@end

