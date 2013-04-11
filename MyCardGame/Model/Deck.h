//
//  Deck.h
//  CardGAme
//
//  Created by Lihan Li on 9/04/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;


@end
