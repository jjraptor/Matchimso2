//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by John Eigenbrode on 2/13/13.
//  Copyright (c) 2013 JJRaptor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

#define NUMBER_OF_MATCHES_KEY @"numberOfMatches"
#define MATCH_BONUS_KEY @"matchBonus"
#define MISMATCH_PENALTY_KEY @"mismatchPenalty"

@interface CardMatchingGame : NSObject

// Designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck
           usingOptions:(NSDictionary *)options;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@property (nonatomic, readonly) int lastMatchScore;
@property (readonly, strong, nonatomic) NSArray *lastMatchCards;
@property (strong, nonatomic, readonly) NSArray *cardsToMatch;
@property (nonatomic) int numberOfMatches;
@property (nonatomic) int matchBonus;
@property (nonatomic) int matchPenalty;


@end
