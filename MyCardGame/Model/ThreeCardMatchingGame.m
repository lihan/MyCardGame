//
//  ThreeCardMatchingGame.m
//  MyCardGame
//
//  Created by Lihan Li on 11/04/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import "ThreeCardMatchingGame.h"
#import "PlayingCard.h"
@interface ThreeCardMatchingGame()
@property (nonatomic, readwrite, retain) NSMutableArray *cards;
@property (nonatomic) int score;

@end



@implementation ThreeCardMatchingGame

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
#define MATCH_BONUS 12

- (void)flipCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    
    if (card.isUnplayable) {
        NSLog(@"Card %d is unplayable", index);
        return;
    }
    
    self.matchResult = [NSString stringWithFormat: @"Flipped up %@", card.contents];
    
    NSArray *filtered = [self.cards filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(isFaceUp == YES)"]];
    NSLog(@"%d of cards faceUp", filtered.count);
    

    
    if (filtered.count == 2) {
        NSMutableArray *otherTwoCards = [[NSMutableArray alloc] init];
        
        for (PlayingCard *playingCard in filtered) {
            [otherTwoCards addObject:playingCard.contents];
        }
        NSString* cardString = [otherTwoCards componentsJoinedByString:@" & "];

        int matchScore = [card match:filtered];
        if (matchScore) {
            for (PlayingCard *playingCard in filtered) {
                playingCard.unplayable = YES;
            }
            card.unplayable = YES;
            int score = matchScore * MATCH_BONUS;
                    self.matchResult = [NSString stringWithFormat:@"Matched %@& %@ for %d points", cardString, card.contents, score];
            self.score += score;

            
        } else {
            for (PlayingCard *playingCard in filtered) {
                playingCard.faceUp = !playingCard.isFaceUp;
            }            
            self.score -= MISMATCH_PENALTY;
            self.matchResult = [NSString stringWithFormat:@"%@& %@ for don't match! %d point penalty", cardString, card.contents, MISMATCH_PENALTY];

        }
    }
    card.faceUp = !card.isFaceUp;
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return (index < self.cards.count) ? self.cards[index] : nil;
}


@end
