//
//  ViewController.m
//  Machismo
//
//  Created by 彩月葵 on 2018/03/17.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ChoosingCountSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *choosingCountLabel;

@end

@implementation ViewController

//- (CardMatchingGame *)game {
//    if (!_game) _game = [self createGame];
//    return _game;
//}

- (CardMatchingGame *)createGame {
    return [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                             usingDeck:[self createDeck]
                                         choosingCount:[self.ChoosingCountSegmentedControl titleForSegmentAtIndex:self.ChoosingCountSegmentedControl.selectedSegmentIndex].integerValue];
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)cardButtonTouched:(UIButton *)sender {
    if (!self.game) self.game = [self createGame];
    
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    
    self.ChoosingCountSegmentedControl.enabled = !self.game.started;
}

- (IBAction)redealButtonTouched:(UIButton *)sender {
    self.game = nil;
    
    [self updateUI];
    
    self.ChoosingCountSegmentedControl.enabled = YES;
}

- (void)updateUI {
    if (self.game) {
        for (int i = 0; i < self.cardButtons.count; ++i) {
            UIButton *cardButton = self.cardButtons[i];
            Card *card = [self.game cardAtIndex:i];
            [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
            cardButton.enabled = !card.isMatched;
        }
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    } else {
        for (UIButton *cardButton in self.cardButtons) {
            [cardButton setTitle:@"" forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
            cardButton.enabled = YES;
        }
        self.scoreLabel.text = @"Score: 0";
    }
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen || card.isMatched ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen || card.isMatched ? @"cardfront" : @"cardback"];
}

@end
