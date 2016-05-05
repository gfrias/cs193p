//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Guillermo Frias on 27/03/16.
//  Copyright © 2016 Guille Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString*)operation;
- (NSString *)historial;

@end
