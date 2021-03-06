//
//  SetCard.h
//  Matchismo
//
//  Created by John Eigenbrode on 2/16/13.
//  Copyright (c) 2013 JJRaptor. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger symbol, numberOfSymbols, shadingOfSymbols, colorOfSymbols; // 1..3

+ (NSArray *)validSymbols;

@end
