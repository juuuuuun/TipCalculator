//
//  ViewController.m
//  TipCalculator
//
//  Created by Jun Oh on 2019-01-18.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) UITextField* billAmountTextField;
@property (nonatomic) UILabel* tipAmountLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.billAmountTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.billAmountTextField];
    
    self.billAmountTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.billAmountTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.billAmountTextField.backgroundColor = [UIColor whiteColor];
    
    [NSLayoutConstraint constraintWithItem:self.billAmountTextField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.billAmountTextField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.2 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.billAmountTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.8 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.billAmountTextField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40].active = YES;
    
    UIButton* calculateTipButton = [[UIButton alloc] initWithFrame:CGRectZero];
    calculateTipButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [calculateTipButton setTitle:@"Calculate Tip" forState:UIControlStateNormal];
    [calculateTipButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:calculateTipButton];
    
    [calculateTipButton addTarget:self action:@selector(calculateTip:) forControlEvents:UIControlEventTouchUpInside];
    
    [NSLayoutConstraint constraintWithItem:calculateTipButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.billAmountTextField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20].active = YES;
    
    [NSLayoutConstraint constraintWithItem:calculateTipButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    
    self.tipAmountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.tipAmountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tipAmountLabel];
    self.tipAmountLabel.textAlignment = NSTextAlignmentCenter;
    self.tipAmountLabel.text = @"Tip Amount: ";
    
    [NSLayoutConstraint constraintWithItem:self.tipAmountLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.tipAmountLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:calculateTipButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.0].active = YES;
    
}

- (void) calculateTip:(UIButton *)sender {
    self.tipAmountLabel.text = [NSString stringWithFormat:@"Tip Amount is: $%.2f",self.billAmountTextField.text.integerValue * 0.15];
}

@end
