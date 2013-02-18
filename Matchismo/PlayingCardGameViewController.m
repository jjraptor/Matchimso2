//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by John Eigenbrode on 2/17/13.
//  Copyright (c) 2013 JJRaptor. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSDictionary *) gameOptions
{
    return @{NUMBER_OF_MATCHES_KEY : @(2), MATCH_BONUS_KEY : @(4), MISMATCH_PENALTY_KEY : @(2)};
}

- (void)updateCardButton:(UIButton *)cardButton
{
    Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
    // Set card back to UIImage
    if (!cardButton.isSelected) [cardButton setImage:[UIImage imageNamed:@"Penquin.jpg"] forState:UIControlStateNormal];
    else [cardButton setImage:nil forState:UIControlStateNormal];
    cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
}

- (NSAttributedString *)cardAttributedContents:(Card *)card forFaceUp:(BOOL)isFaceUp
{
    NSDictionary *cardAttributes = @{};
    NSString *textToDisplay = (isFaceUp) ? card.contents: @"";
    NSAttributedString *cardContents = [[NSAttributedString alloc] initWithString:textToDisplay attributes:cardAttributes];
    return cardContents;
}

- (NSAttributedString *)obtainCardsMatched
{
    NSString *text = [self.game.lastMatchCards componentsJoinedByString:@" "];
    text = [text stringByAppendingString:@" "];
    return [[NSAttributedString alloc] initWithString:text];
}

- (NSString *)textForSingleCard
{
    Card *card = [self.game.lastMatchCards lastObject];
    return [NSString stringWithFormat:@"flipped %@",(card.isFaceUp) ? @"up!" : @"back!"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
