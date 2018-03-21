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
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

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
    ChoosingResult *result = [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI:result];
}

- (IBAction)redealButtonTouched:(UIButton *)sender {
    self.game = nil;
    
    [self resetUI];
}

- (void)updateUI:(ChoosingResult *)result {
    for (int i = 0; i < self.cardButtons.count; ++i) {
        UIButton *cardButton = self.cardButtons[i];
        Card *card = [self.game cardAtIndex:i];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    self.ChoosingCountSegmentedControl.enabled = !self.game.started;
    
    NSString *resultText = nil;
    if ([result.type isEqualToString:RESULT_TYPE_FLIP_UP]) {
        resultText = @"{cards} flipped up.";
    } else if ([result.type isEqualToString:RESULT_TYPE_FLIP_DOWN]) {
        resultText = @"{cards} flipped down.";
    } else if ([result.type isEqualToString:RESULT_TYPE_MATCH]) {
        resultText = @"Matched {cards} for {score} points.";
    } else if ([result.type isEqualToString:RESULT_TYPE_MISMATCH]) {
        resultText = @"{cards} don't match! {score} points penalty!";
    }
    self.resultLabel.text = [@"Result: " stringByAppendingString:[[resultText stringByReplacingOccurrencesOfString:@"{cards}" withString:[self contentsForCards:result.cards]] stringByReplacingOccurrencesOfString:@"{score}" withString:[NSString stringWithFormat:@"%ld", (long)result.scoreDelta]]];
}

- (void)resetUI {
    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    
    self.scoreLabel.text = @"Score: 0";
    self.ChoosingCountSegmentedControl.enabled = YES;
    self.resultLabel.text = @"Result:";
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen || card.isMatched ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen || card.isMatched ? @"cardfront" : @"cardback"];
}

- (NSString *)contentsForCards:(NSArray *)cards {
    return [[cards valueForKey:@"contents"] componentsJoinedByString:@" "];
}

@end
