//
//  ViewController.m
//  Calculator
//
//  Created by Guillermo Frias on 27/03/16.
//  Copyright © 2016 Guille Inc. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()

@property (nonatomic) BOOL isUserInTheMiddleOfEnteringANumber;

@property (nonatomic, strong) CalculatorBrain *calculatorBrain;
@end

@implementation ViewController

@synthesize display = _display;
@synthesize history = _history;

@synthesize isUserInTheMiddleOfEnteringANumber = _isUserInTheMiddleOfEnteringANumber;


@synthesize calculatorBrain = _calculatorBrain;

- (CalculatorBrain*) calculatorBrain {
    if (!_calculatorBrain){
        _calculatorBrain = [[CalculatorBrain alloc] init];
    }
    return _calculatorBrain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    if (self.isUserInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.isUserInTheMiddleOfEnteringANumber = YES;
    }
    
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.isUserInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    NSString *operation = sender.currentTitle;
    double result = [self.calculatorBrain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.isUserInTheMiddleOfEnteringANumber = [operation isEqualToString:@"+/-"];
    
    self.history.text = [self.calculatorBrain historial];
}

- (IBAction)enterPressed {
    [self.calculatorBrain pushOperand:[self.display.text doubleValue]];
    self.isUserInTheMiddleOfEnteringANumber = NO;
    
    self.history.text = [self.calculatorBrain historial];
}

- (IBAction)dotPressed {
    if (![self.display.text containsString:@"."]){
        if (!self.isUserInTheMiddleOfEnteringANumber){
            self.display.text = @"0";
        }
        self.display.text = [self.display.text stringByAppendingString:@"."];
        
        self.isUserInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)clearPressed {
    self.display.text = @"0";
    self.isUserInTheMiddleOfEnteringANumber = NO;
}
    

@end
