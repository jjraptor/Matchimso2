//
//  CardGameViewController.m
//  Matchismo
//
//  Created by John Eigenbrode on 2/12/13.
//  Copyright (c) 2013 JJRaptor. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) BOOL cardHasBeenFlipped;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSString *resultsString;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong, nonatomic) NSMutableArray *playHistory;
@property (weak, nonatomic) IBOutlet UISlider *resultsSlider;
@property (nonatomic) NSUInteger rank;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[self createDeck]usingOptions:[self gameOptions]];
    }
    return _game;
}

- (Deck *)createDeck
{
    //Abstract method
    return nil;
}


- (NSMutableArray *)playHistory
{
    if (!_playHistory) _playHistory = [[NSMutableArray alloc] init];
    return _playHistory;
}

- (NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][_rank];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (NSString *)resultsString
 {
 if (!_resultsString) _resultsString = @"No cards have been flipped!";
 return _resultsString;
 }

# pragma mark Abstact Methods

- (void)updateCardButton:(UIButton *)cardButton
{
    /* Abstract method to set card back image if used
       and select the appropriate highlighting
    */
}

- (NSAttributedString *)cardAttributedContents:(Card *)card forFaceUp:(BOOL)isFaceUp
{
    // Abstract method to obtain the contents of a card as an AttributedString
    return nil;
}

- (NSString *)textForSingleCard
{
    // Abstract method to obtain the contents of single card
    return nil;
}

- (NSAttributedString *)obtainCardsMatched
{
    // Abstract method to get the list of cards matched seperated by a space
    return nil;
}

- (NSDictionary *)gameOptions
{
    // Abstract method to set game options
    return nil;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:[self cardAttributedContents:card forFaceUp:NO] forState:UIControlStateNormal];
        [cardButton setAttributedTitle:[self cardAttributedContents:card forFaceUp:YES] forState:UIControlStateSelected];
        [cardButton setAttributedTitle:[self cardAttributedContents:card forFaceUp:YES] forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        [self updateCardButton:cardButton];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.resultsLabel.alpha = 1.0;
    [self updateResultsString];
    self.resultsSlider.maximumValue = self.flipCount+0.9;
    //[self.flipHistorySlider setValue:self.flipCount animated:YES];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)dealNewDeck:(UIButton *)sender
{
    self.game = nil;
    self.flipCount = 0;
    self.playHistory = nil;
    [self updateUI];}

- (NSString *)textForCardFlip
{
    PlayingCard *card = [self.game.lastMatchCards lastObject];
    _rank = card.rank;
    return [NSString stringWithFormat:@"%@%@ flipped %@",[self rankAsString], card.suit,(card.faceUp) ? @"up!" : @"back!"];
}

- (void)updateResultsString
{
    if (self.game.lastMatchCards) {
        NSString *text;
        if ([self.game.lastMatchCards count]>1) {
            if (self.game.lastMatchScore<0) {
                text = [NSString stringWithFormat:@"don't match! (%d penalty)",self.game.lastMatchScore];
            } else {
                text = [NSString stringWithFormat:@"match! %d points bonus",self.game.lastMatchScore];
            }
        } else
            text = [self textForSingleCard];
        
        NSMutableAttributedString *textToDisplay = [[NSMutableAttributedString alloc] initWithAttributedString:[self obtainCardsMatched]];
        [textToDisplay appendAttributedString:[[NSAttributedString alloc] initWithString:text]];
        self.resultsLabel.attributedText = textToDisplay;
        [self.playHistory addObject:textToDisplay];
    } else
        self.resultsLabel.attributedText = [[NSAttributedString alloc] initWithString:@"Play!"];
}


- (IBAction)browsePlayHistory:(UISlider *)sender
{
    if (self.flipCount) {
     self.resultsLabel.alpha = 0.5;
    int index = sender.value;
    if (index) self.resultsLabel.text = [self.playHistory objectAtIndex:index -1];
    }
}




- (void)viewDidLoad
{
    
}


@end
