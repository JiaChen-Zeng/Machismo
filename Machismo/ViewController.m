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
@property (weak, nonatomic) IBOutlet UISlider *choosingCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *choosingCountLabel;

@end

@implementation ViewController

- (CardMatchingGame *)game {
    if (!_game) _game = [self createGame];
    return _game;
}

- (CardMatchingGame *)createGame {
    return [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                             usingDeck:[self createDeck]
                                         choosingCount:self.choosingCountSlider.value];
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)cardButtonTouched:(UIButton *)sender {
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)redealButtonTouched:(UIButton *)sender {
    self.game = [self createGame];
    [self updateUI];
}

- (IBAction)choosingCountSliderChanged:(UISlider *)sender {
    int roundedValue = (int)round(sender.value);
    sender.value = roundedValue;
    self.choosingCountLabel.text = [NSString stringWithFormat:@"Choose Count: %d", roundedValue];
}

- (void)updateUI {
    for (int i = 0; i < self.cardButtons.count; ++i) {
        UIButton *cardButton = self.cardButtons[i];
        Card *card = [self.game cardAtIndex:i];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen || card.isMatched ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen || card.isMatched ? @"cardfront" : @"cardback"];
}

@end
