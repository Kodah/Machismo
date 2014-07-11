//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Tom on 11/07/2014.
//  Copyright (c) 2014 SugWare. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame();
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation CardMatchingGame

- (NSMutableArray *) cards{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            
            Card *card = [deck drawRandomCard];
            
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
            
        }
    }
    
    return self;
}


-(Card *)cardAtIndex:(NSUInteger)index{
    return (index <[self.cards count]) ? self.cards[index] : nil;
}

#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4
#define COST_TO_CHOSE 1

-(void)chooseCardAtIndex:(NSUInteger)index{
    
    
    Card *card = [self cardAtIndex:index];
    
    if (card.isChosen) {
        card.chosen = NO;
    } else {
        
        for (Card *otherCard in self.cards){
            if (otherCard.isChosen && !otherCard.isMatched){
                int matchScore = [card match:@[otherCard]];
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    otherCard.matched = YES;
                } else {
                    self.score -= MISMATCH_PENALTY;
                    otherCard.chosen = NO;
                }
                break;
            }
        }
        self.score -= COST_TO_CHOSE;
        card.chosen = YES;
    }
}
@end
