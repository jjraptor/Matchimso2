//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by John Eigenbrode on 2/13/13.
//  Copyright (c) 2013 JJRaptor. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardMatchingGame()
@property (strong, nonatomic)NSMutableArray *cards;
// Make public readonly properties privately readwrite
@property (readwrite, nonatomic) int score; 
@property (readwrite, nonatomic) int lastMatchScore;
@property (readwrite, strong, nonatomic) NSArray *lastMatchCards;
//@property (nonatomic) int matchSize;
@end

@implementation CardMatchingGame

- (NSMutableArray*)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4
#define NUMBER_OF_MATCHES 2

- (int) numberOfMatches
{
    if (!_numberOfMatches) _numberOfMatches = NUMBER_OF_MATCHES;
    return _numberOfMatches;
}

- (int) matchBonus
{
    if (!_matchBonus) _matchBonus = MATCH_BONUS;
    return _matchBonus;
}

- (int) matchPenalty
{
    if (!_matchPenalty) _matchPenalty = MISMATCH_PENALTY;
    return _matchPenalty;
}

// Designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck usingOptions:(NSDictionary *)options
{
    self = [super init];
    
    if (self) {
        self.numberOfMatches = 2;
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    if (options) {
        self.numberOfMatches = [options[NUMBER_OF_MATCHES_KEY] intValue];
        self.matchBonus = [options[MATCH_BONUS_KEY] intValue];
        self.matchPenalty = [options[MISMATCH_PENALTY_KEY] intValue];
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isUnplayable) {
        self.lastMatchCards = @[card];
        if (!card.isFaceUp) {
            self.lastMatchScore = 0;
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            
            for (Card *otherCard in self.cards)
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                    if (otherCards.count == self.numberOfMatches-1) {
                        int matchScore = [card match:otherCards];
                        self.lastMatchCards = [self.lastMatchCards arrayByAddingObjectsFromArray:otherCards];
                        
                        if (matchScore) {
                            for (Card *otherCard in otherCards)
                                otherCard.unplayable = YES;
                            card.unplayable = YES;
                            self.lastMatchScore = matchScore * self.matchBonus;
                        } else {
                            for (Card *otherCard in otherCards) {
                                otherCard.faceUp = NO;
                            }
                            self.lastMatchScore = -self.matchPenalty;
                        }
                    }
                }
            self.score += self.lastMatchScore - FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
