//
//  BaseCardGame.h
//  MyCardGame
//
//  Created by Lihan Li on 11/04/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface BaseCardGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;


- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (strong, nonatomic) NSString *matchResult;

@end
