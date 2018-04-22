//
//  CardMatchingGameViewController.m
//  Machismo
//
//  Created by 彩月葵 on 2018/04/22.
//  Copyright © 2018年 彩月葵. All rights reserved.
//

#import "CardMatchingGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface CardMatchingGameViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *ChoosingCountSegmentedControl;

@end

@implementation CardMatchingGameViewController

// concrete
- (Game *)createGame {
    return [[CardMatchingGame alloc] initWithCardCount:self.cardCount
                                             usingDeck:[[PlayingCardDeck alloc] init]
                                         choosingCount:[self.ChoosingCountSegmentedControl titleForSegmentAtIndex:self.ChoosingCountSegmentedControl.selectedSegmentIndex].integerValue];
}

// concrete
- (void)updateCardButton:(UIButton *)cardButton
                    card:(Card *)card {
    [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    cardButton.enabled = !card.isMatched;
}

// override
- (void)updateControls:(ChoosingResult *)result {
    [super updateControls:result];
    self.ChoosingCountSegmentedControl.enabled = !self.game.started;
}

// concrete
- (void)updateResultLabel:(UILabel *)resultLabel
                   result:(ChoosingResult *)result {
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
    
    resultLabel.text = [@"Result: " stringByAppendingString:[[resultText stringByReplacingOccurrencesOfString:@"{cards}" withString:[self contentsForCards:result.cards]] stringByReplacingOccurrencesOfString:@"{score}" withString:[NSString stringWithFormat:@"%ld", (long)result.scoreDelta]]];
}

// concrete
- (void)resetCardButton:(UIButton *)cardButton {
    [cardButton setTitle:@"" forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
    cardButton.enabled = YES;
}

// override
- (void)resetControls {
    [super resetControls];
    self.ChoosingCountSegmentedControl.enabled = YES;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
