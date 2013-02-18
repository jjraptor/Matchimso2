//
//  CardGameViewController.h
//  Matchismo
//
//  Created by John Eigenbrode on 2/12/13.
//  Copyright (c) 2013 JJRaptor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;

// Abstract methods to implement when subclassing
- (NSAttributedString *)cardAttributedContents:(Card *)card forFaceUp:(BOOL)isFaceUp;
- (void)updateCardButton:(UIButton *)cardButton;
- (NSAttributedString *)obtainCardsMatched;
- (NSString *)textForSingleCard;
- (NSDictionary *) gameOptions;
- (Deck *)createDeck;

@end
