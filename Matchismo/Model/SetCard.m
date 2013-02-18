//
//  SetCard.m
//  Matchismo
//
//  Created by John Eigenbrode on 2/16/13.
//  Copyright (c) 2013 JJRaptor. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int symbolSum = self.symbol;
    int numberOfSymbolsSum = self.numberOfSymbols;
    int shadingOfSymbolsSum = self.shadingOfSymbols;
    int colorOfSymbolsSum = self.colorOfSymbols;
    
    if (otherCards.count==2) {
        
        for (SetCard *otherCard in otherCards) {
            symbolSum += otherCard.symbol;
            numberOfSymbolsSum+=otherCard.numberOfSymbols;
            shadingOfSymbolsSum+=otherCard.shadingOfSymbols;
            colorOfSymbolsSum+=otherCard.colorOfSymbols;
        }
        
        if ((symbolSum%3==0)&&(numberOfSymbolsSum%3==0)&&(shadingOfSymbolsSum%3==0)&&(colorOfSymbolsSum%3==0))
            score = 1;
    }
    return score;
}

+ (NSArray *)validSymbols
{
    return @[@"▲",@"●",@"■"];
}

- (NSString *)contents
{
    NSArray *shapes = [SetCard validSymbols];
    NSString *symbolNumber = [@"" stringByPaddingToLength:self.numberOfSymbols withString: shapes[self.symbol-1] startingAtIndex:0];
    return [NSString stringWithFormat:@"%@",symbolNumber];
}


@end
