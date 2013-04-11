//
//  PlayingCard.h
//  CardGAme
//
//  Created by Lihan Li on 9/04/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger) maxRank;

@end
