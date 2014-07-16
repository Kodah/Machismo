//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Tom on 09/07/2014.
//  Copyright (c) 2014 SugWare. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSwitcher;

@end

@implementation CardGameViewController

-(CardMatchingGame *)game{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

-(Deck*)createDeck{
    return[[PlayingCardDeck alloc]init];
}

- (IBAction)touchCard:(UIButton*)sender {

    int chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    
    self.modeSwitcher.selectedSegmentIndex == 0 ? [self.game chooseCardAtIndex:chooseButtonIndex]
    : [self.game chooseChooseCardAtIndex:chooseButtonIndex];

    [self UpdateUI];

    
}

- (void)UpdateUI{
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}
- (IBAction)redealCardsButtonPressed:(id)sender {
    
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];

    [self UpdateUI];
}

-(NSString *) titleForCard:(Card *)card{
    return card.isChosen ? card.contents :@"";
}

-(UIImage *) backgroundForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"front" : @"back"];
}

@end




