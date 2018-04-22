//
//  ViewController.m
//  Machismo
//
//  Created by 彩月葵 on 2018/03/17.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "GameViewController.h"
#import "Game.h"

@interface GameViewController ()

@property (strong, nonatomic) Game *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation GameViewController

// abstract
- (Game *)createGame {
    return nil;
}

- (IBAction)cardButtonTouched:(UIButton *)sender {
    if (!self.game) self.game = [self createGame];
    
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    ChoosingResult *result = [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI:result];
}

- (IBAction)redealButtonTouched:(UIButton *)sender {
    self.game = nil;
    
    [self resetUI];
}

- (void)updateUI:(ChoosingResult *)result {
    [self updateCards];
    [self updateControls:result];
}

- (void)updateCards {
    for (int i = 0; i < self.cardButtons.count; ++i) {
        UIButton *cardButton = self.cardButtons[i];
        Card *card = [self.game cardAtIndex:i];
        [self updateCardButton:cardButton
                          card:card];
    }
}

// abstract
- (void)updateCardButton:(UIButton *)cardButton
                    card:(Card *)card {
    // no actions
}

- (void)updateControls:(ChoosingResult *)result {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    [self updateResultLabel:self.resultLabel result:result];
}

// abstract
- (void)updateResultLabel:(UILabel *)resultLabel
                   result:(ChoosingResult *)result {
    // no actions
}

- (void)resetUI {
    [self resetCards];
    [self resetControls];
}
- (void)resetCards {
    for (UIButton *cardButton in self.cardButtons) {
        [self resetCardButton:cardButton];
    }
}

// abstract
- (void)resetCardButton:(UIButton *)cardButton {
    // no actions
}

- (void)resetControls {
    self.scoreLabel.text = @"Score: 0";
    self.resultLabel.text = @"Result:";
}

- (NSUInteger)cardCount {
    return self.cardButtons.count;
}

@end
