//
//  CardGameViewController.m
//  MyCardGame
//
//  Created by Lihan Li on 9/04/13.
//  Copyright (c) 2013 Stanford. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "ThreeCardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) BaseCardGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISwitch *threeCardModeSwitch;

@end

@implementation CardGameViewController


- (BaseCardGame *)game
{
    if (!_game) {
        
        if(self.threeCardModeSwitch.isOn) {
            _game = [[ThreeCardMatchingGame alloc]
                     initWithCardCount:self.cardButtons.count
                     usingDeck:[[PlayingCardDeck alloc] init]];
        } else {
            
            _game = [[CardMatchingGame alloc]
                     initWithCardCount:self.cardButtons.count
                     usingDeck:[[PlayingCardDeck alloc] init]];
        }
    }
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
    
}
-(void)updateUI{
    UIImage *cardBackImage = [UIImage imageNamed:@"playing_card_suits.jpg"];
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];        
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        if (card.isFaceUp) {
            [cardButton setImage:nil forState:UIControlStateNormal];
            
        } else {
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
            cardButton.imageEdgeInsets = UIEdgeInsetsMake(5,5,5,5);
        }
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.resultLabel.text = self.game.matchResult;
    
}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    NSLog(@"cardButtons index %d", [self.cardButtons indexOfObject:sender]);
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount ++;
    [self updateUI];
    
}
-(void) freezeCards
{
    for (UIButton *cardButton in self.cardButtons){
        cardButton.enabled = NO;
        cardButton.alpha = 0.3;
    }
}

- (IBAction)flipThreeCardMode:(UISwitch *)sender {
    [self freezeCards];
}

- (IBAction)resetGame:(id)sender {
    self.game = nil;
    [self updateUI];
}

- (void)viewDidUnload {
    [self setResultLabel:nil];
    [self setThreeCardModeSwitch:nil];
    [super viewDidUnload];
}
@end
