//
//  ViewController.m
//  TextCheckerTest
//
//  Created by Morgan Chen on 2/7/15.
//  Copyright (c) 2015 Morgan Chen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (strong, nonatomic, readonly) UITextChecker *textChecker;

@end

@implementation ViewController

#pragma mark - Initializers / Life cycle methods

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    // set up text checker
    if (self) {
        _textChecker = [[UITextChecker alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.textField addTarget:self
                       action:@selector(textFieldTextDidChange:)
             forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Text Field shenanigans

- (IBAction)textFieldTextDidChange:(id)sender {
    NSRange rangeOfMisspelling = [self.textChecker rangeOfMisspelledWordInString:self.textField.text
                                                                           range:NSMakeRange(0, self.textField.text.length)
                                                                      startingAt:0
                                                                            wrap:NO
                                                                        language:@"en_US"];
    // no misspellings
    if (rangeOfMisspelling.location == NSNotFound) {
        self.textLabel.text = @"Valid word!";
    }
    
    // misspellings
    else {
        self.textLabel.text = @"Not a word.";
    }
}

@end
