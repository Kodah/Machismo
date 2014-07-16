//
//  PlayingCard.m
//  Matchismo
//
//  Created by Tom on 09/07/2014.
//  Copyright (c) 2014 SugWare. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (NSString *) contents{
    
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (void) setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards{
    int score = 0;
    
    PlayingCard *otherCard = [otherCards firstObject];
    
    if ([otherCards count] == 1) {
        
        NSLog(@"%@ vs %@", otherCard.contents, self.contents);
        
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]){
        score = 1;
        }
    } else {
        for (Card *card in otherCards) {
            int cardScore = [self match:@[card]];
            score += cardScore;
        }
        if ([otherCards[0] rank] == [otherCards[1] rank]) {
            score += 4;
            NSLog(@"%lu vs %lu", (unsigned long)[otherCards[0] rank], (unsigned long)[otherCards[1] rank]);
            
        } else if ([otherCards[0] suit] == [otherCards[1] suit]){
            score += 1;
            NSLog(@"%lu vs %lu", (unsigned long)[otherCards[0] rank], (unsigned long)[otherCards[1] rank]);
        }
    }
    
    NSLog(@"%i", score);
    return score;
    
}

- (NSString *) suit{
    return _suit ? _suit : @"?";
}

+(NSUInteger)maxRank{
    return [[self rankStrings]count]-1;
}

+(NSArray *)validSuits{
    return @[@"♥︎",@"♦︎",@"♠︎",@"♣︎"];
}

+(NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",
             @"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}


@end


