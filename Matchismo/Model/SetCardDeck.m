//
//  SetCardDeck.m
//  Matchismo
//
//  Created by John Eigenbrode on 2/16/13.
//  Copyright (c) 2013 JJRaptor. All rights reserved.
//

#import "SetCardDeck.h"

@implementation SetCardDeck

- (id)init
{
    if (self = [super init]) {
        for (NSUInteger symbol = 1; symbol <= 3; symbol++)
            for (NSUInteger numberOfSymbols = 1; numberOfSymbols <= 3; numberOfSymbols++)
                for (NSUInteger shadingOfSymbols = 1; shadingOfSymbols <= 3; shadingOfSymbols++)
                    for (NSUInteger colorOfSymbols = 1; colorOfSymbols <= 3; colorOfSymbols++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.numberOfSymbols = numberOfSymbols;
                        card.shadingOfSymbols = shadingOfSymbols;
                        card.colorOfSymbols = colorOfSymbols;
                        [self addCard:card atTop:YES];
                    }
        
    }
    return self;
}


@end
