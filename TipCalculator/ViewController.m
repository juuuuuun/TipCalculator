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
@property (nonatomic) UITextField* tipPercentTextField;
@property (nonatomic) UILabel* tipAmountLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.billAmountTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.billAmountTextField];
    
    [self.billAmountTextField addTarget:self action:@selector(billAmountChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.billAmountTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.billAmountTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.billAmountTextField.backgroundColor = [UIColor whiteColor];
    
    [NSLayoutConstraint constraintWithItem:self.billAmountTextField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.billAmountTextField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.2 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.billAmountTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.8 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.billAmountTextField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40].active = YES;
    
    self.tipPercentTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.tipPercentTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tipPercentTextField];
    
    self.tipPercentTextField.backgroundColor = [UIColor whiteColor];
    self.tipPercentTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.tipPercentTextField.text = @"15";
    
    [self.tipPercentTextField addTarget:self action:@selector(tipPercentChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [NSLayoutConstraint constraintWithItem:self.tipPercentTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.billAmountTextField attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.tipPercentTextField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.billAmountTextField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.tipPercentTextField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.tipPercentTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.billAmountTextField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.0].active = YES;
    
    UISlider* tipSlider = [[UISlider alloc] initWithFrame:CGRectZero];
    tipSlider.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tipSlider];
    
    tipSlider.minimumValue = 0.0;
    tipSlider.maximumValue = 100.0;
    [tipSlider setValue:15.0 animated:YES];
    
    [tipSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [NSLayoutConstraint constraintWithItem:tipSlider attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tipPercentTextField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tipSlider attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:tipSlider attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.billAmountTextField attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0].active = YES;
    
    UIButton* calculateTipButton = [[UIButton alloc] initWithFrame:CGRectZero];
    calculateTipButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [calculateTipButton setTitle:@"Calculate Tip" forState:UIControlStateNormal];
    [calculateTipButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:calculateTipButton];
    
    [calculateTipButton addTarget:self action:@selector(calculateTip:) forControlEvents:UIControlEventTouchUpInside];
    
    [NSLayoutConstraint constraintWithItem:calculateTipButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:tipSlider attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20].active = YES;
    
    [NSLayoutConstraint constraintWithItem:calculateTipButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    
    self.tipAmountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.tipAmountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tipAmountLabel];
    self.tipAmountLabel.textAlignment = NSTextAlignmentCenter;
    self.tipAmountLabel.text = @"Tip Amount: ";
    
    [NSLayoutConstraint constraintWithItem:self.tipAmountLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.tipAmountLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:calculateTipButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.0].active = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppeared:) name:UIKeyboardWillShowNotification object:nil];
    
    
}

- (void) calculateTip:(UIButton *)sender {
    self.tipAmountLabel.text = [NSString stringWithFormat:@"Tip Amount is: $%.2f", self.billAmountTextField.text.integerValue * self.tipPercentTextField.text.integerValue / 100.0];
}

- (void) keyboardAppeared:(NSNotification *)notification {
    NSDictionary* keyboardInfo = notification.userInfo;
    NSValue* keyboardValue = keyboardInfo[UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardRect = keyboardValue.CGRectValue;
    
    self.view.transform = CGAffineTransformMakeTranslation(0, 0-keyboardRect.size.height);
}

- (void) sliderValueChanged:(UISlider *)slider {
    self.tipPercentTextField.text = [NSString stringWithFormat:@"%.f", slider.value];
    [self calculateTip: nil];
}

- (void) billAmountChanged:(UITextField *)sender {
    
    [self calculateTip: nil];
}

- (void) tipPercentChanged:(UITextField *)sender {
    [self calculateTip: nil];
}
@end
