//
//  PlayingCard.m
//  CardGAme
//
//  Created by Lihan Li on 9/04/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


@synthesize suit = _suit;

// Class methods
+ (NSArray *)validSuits {
    return @[@"♠",@"♣",@"♥",@"♦"];
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if (otherCards.count == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        
        if ([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        } else if (otherCard.rank == self.rank) {
            score = 4;
        }
    } else if (otherCards.count == 2) {
        PlayingCard *card1 = [otherCards objectAtIndex:0];
        PlayingCard *card2 = [otherCards lastObject];
        
        if ([card1.suit isEqualToString:self.suit] && [card2.suit isEqualToString:self.suit]){
            score = 4;
        } else if (card1.rank == self.rank && card2.rank == self.rank) {
            score = 12;
        }
    }
    return score;
}

-(NSString *)contents {

    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit {
    
    if ( [[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *) suit {
    return _suit ? _suit : @"?";
}

+(NSArray *) rankStrings {
    return @[@"?",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank {
    return [self rankStrings].count-1;
}

-(void)setRank:(NSUInteger)rank {
    if(rank <=[PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
