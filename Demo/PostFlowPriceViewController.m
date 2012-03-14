//
//  PostFlowPriceViewController.m
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PostFlowPriceViewController.h"

@implementation PostFlowPriceViewController
@synthesize priceTextField = _priceTextField;
@synthesize rightButton = _rightButton;
@synthesize postType = _postType;
@synthesize backButton = _backButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)loadCurrentPostingData
{
    if ([VariableStore sharedInstance].currentPostingItem.askPrice) {
        self.priceTextField.text = [NSString stringWithFormat:@"%@", [VariableStore sharedInstance].currentPostingItem.askPrice];
    }
}

- (void)saveCurrentPostingData
{
    if ([self.priceTextField.text length] > 0) {
        [VariableStore sharedInstance].currentPostingItem.askPrice = [NSDecimalNumber decimalNumberWithString:self.priceTextField.text];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PostFlowPriceToSetDateView"]) {
        PostFlowSetDateViewController *pvc = segue.destinationViewController;
        pvc.postType = self.postType;
    } 
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCurrentPostingData];
    [self.priceTextField becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UITextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    
    int intValue = [self.priceTextField.text intValue];
    if (self.priceTextField.text.length > 0 
        && intValue > 0
        && [[NSString stringWithFormat:@"%d",intValue] isEqualToString:self.priceTextField.text]) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } 
    [ViewHelper buildBackButton:self.backButton];
    [ViewHelper buildNextButtonDis:self.rightButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    int intValue = [self.priceTextField.text intValue];
    if (self.priceTextField.text.length > 0 
        && intValue > 0
        && [[NSString stringWithFormat:@"%d",intValue] isEqualToString:self.priceTextField.text]) {
        
        [ViewHelper buildNextButton:self.rightButton];
        //self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self saveCurrentPostingData];
}

- (void)viewDidUnload
{
    [self setPriceTextField:nil];
    [self setBackButton:nil];
    [self setRightButton:nil];
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)UITextFieldTextDidChangeNotification:(NSNotification *)notification {
    if ([notification object] == self.priceTextField) {
        int intValue = [self.priceTextField.text intValue];
        if (self.priceTextField.text.length > 0 
            && intValue > 0
            && [[NSString stringWithFormat:@"%d",intValue] isEqualToString:self.priceTextField.text]) {
            
            [ViewHelper buildNextButton:self.rightButton];
            //self.navigationItem.rightBarButtonItem.enabled = YES;
        } else {
            [ViewHelper buildNextButtonDis:self.rightButton];
            //self.navigationItem.rightBarButtonItem.enabled = NO;
        }
    }
}
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
