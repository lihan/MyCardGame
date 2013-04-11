//
//  BaseCardGame.m
//  MyCardGame
//
//  Created by Lihan Li on 11/04/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import "BaseCardGame.h"

@interface BaseCardGame()
@property (nonatomic, readwrite, retain) NSMutableArray *cards;
@property (nonatomic) int score;

@end

@implementation BaseCardGame


- (NSMutableArray *) cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck {
    
    self = [super init];
    
    if (self) {
        
        for (int i=0; i< cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    return self;
}

- (void)drawCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck {
    
    for (int i=0; i< cardCount; i++) {
        Card *card = [deck drawRandomCard];
        self.cards[i] = card;
    }
}


#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (void)flipCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    
    if (card.isUnplayable) {
        NSLog(@"Card %d is unplayable", index);
        return;
    }
    self.matchResult = [NSString stringWithFormat: @"Flipped up %@", card.contents];
    
    if (!card.isFaceUp) {
        for (Card *otherCard in self.cards) {
            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                int matchScore = [card match:@[otherCard]];
                
                if (matchScore) {
                    otherCard.unplayable = YES;
                    card.unplayable = YES;
                    int score = matchScore *MATCH_BONUS;
                    self.score += score;
                    self.matchResult = [NSString stringWithFormat: @"Matched %@ & %@ for %d points", card.contents, otherCard.contents, score];
                    
                } else {
                    otherCard.faceUp = NO;
                    self.score -= MISMATCH_PENALTY;
                    self.matchResult = [NSString stringWithFormat: @"%@ & %@ don't match! %d points penalty", card.contents, otherCard.contents, MISMATCH_PENALTY];
                }
                break;
            }
        }
        self.score -= FLIP_COST;
    }
    card.faceUp = !card.isFaceUp;
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return (index < self.cards.count) ? self.cards[index] : nil;
}


@end
