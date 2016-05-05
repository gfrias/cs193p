//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Guillermo Frias on 27/03/16.
//  Copyright © 2016 Guille Inc. All rights reserved.
//

#import "CalculatorBrain.h"
#include <math.h>

@interface CalculatorBrain ()
@property(nonatomic, strong) NSMutableArray *operandStack;
@property(nonatomic, strong) NSString *history;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;
@synthesize history = _history;

- (NSMutableArray*)operandStack {
    if (!_operandStack){
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (NSString*)history {
    if (!_history){
        _history = @"";
    }
    return _history;
}

- (void)pushOperand:(double)operand {
    NSNumber *number = [NSNumber numberWithDouble:operand];
    self.history = [self.history stringByAppendingFormat:@"%g ", operand];
    
    [self.operandStack addObject:number];
}

- (double)popOperand {
    NSNumber *number = [self.operandStack lastObject];
    if (number) [self.operandStack removeLastObject];
    
    return [number doubleValue];
}

- (double)performOperation:(NSString*)operation {
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"×"]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]){
        result = [self popOperand] - [self popOperand];
    } else if ([operation isEqualToString:@"÷"]){
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    } else if ([operation isEqualToString:@"√"]){
        result = sqrt([self popOperand]);
    } else if ([operation isEqualToString:@"sin"]){
        result = sin([self popOperand]);
    } else if ([operation isEqualToString:@"cos"]){
        result = cos([self popOperand]);
    } else if ([operation isEqualToString:@"π"]){
        result = M_PI;
    } else if ([operation isEqualToString:@"+/-"]){
        result = -[self popOperand];
    } else if ([operation isEqualToString:@"C"]){
        return 0; //don't add to history
    } else if ([operation isEqualToString:@"AC"]){
        [self.operandStack removeAllObjects];
        self.history = @"";
        
        return 0;
    }
    
    NSString *tempHistory = [self.history stringByAppendingFormat: @"%@ ", operation];
    [self pushOperand:result];
    self.history = tempHistory;
    
    return result;
}

- (NSString*) historial {
    return [self.history stringByAppendingString:@""];
}

@end
