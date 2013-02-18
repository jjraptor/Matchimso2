//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by John Eigenbrode on 2/17/13.
//  Copyright (c) 2013 JJRaptor. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (NSDictionary *) gameOptions
{
    return @{NUMBER_OF_MATCHES_KEY : @(3), MATCH_BONUS_KEY : @(16), MISMATCH_PENALTY_KEY : @(1)};
}

- (NSAttributedString *)cardAttributedContents:(Card *)card forFaceUp:(BOOL)isFaceUp
{
    NSArray *colorPallette = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
    NSArray *alphaPallette = @[@0,@0.2,@1];
    UIColor *cardOutlineColor = colorPallette[((SetCard *)card).colorOfSymbols-1];
    UIColor *cardColor = [cardOutlineColor colorWithAlphaComponent:(CGFloat)[alphaPallette[((SetCard *)card).shadingOfSymbols-1] floatValue]];
    NSDictionary *cardAttributes = @{NSForegroundColorAttributeName : cardColor, NSStrokeColorAttributeName : cardOutlineColor, NSStrokeWidthAttributeName: @-5};
    NSString *textToDisplay = card.contents;
    NSAttributedString *cardContents = [[NSAttributedString alloc] initWithString:textToDisplay attributes:cardAttributes];
    return cardContents;
}

- (void)updateCardButton:(UIButton *)cardButton
{
    Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
    if (card.isFaceUp) {
        cardButton.backgroundColor = [UIColor lightGrayColor];
    } else {
        cardButton.backgroundColor = nil;
    }
    cardButton.alpha = card.isUnplayable ? 0.0 : 1.0;
}

- (NSAttributedString *)obtainCardsMatched
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    NSAttributedString *space = [[NSAttributedString alloc] initWithString:@" "];
    for (Card *card in self.game.cardsToMatch) {
        [text appendAttributedString:[self cardAttributedContents:card forFaceUp:NO]];
        [text appendAttributedString:space];
    }
    return text;
}

- (NSString *)textForSingleCard
{
    Card *card = [self.game.cardsToMatch lastObject];
    return [NSString stringWithFormat:@"%@",(card.isFaceUp) ? @"selected!" : @"de-selected!"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


@end
