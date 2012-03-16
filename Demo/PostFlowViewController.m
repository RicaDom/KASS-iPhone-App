//
//  PostFlowViewController.m
//  Demo
//
//  Created by zhicai on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PostFlowViewController.h"
#import "KTTextView.h"

@implementation PostFlowViewController

@synthesize titleTextField = _titleTextField;
@synthesize postType = _postType;
@synthesize desTextField = _desTextField;
@synthesize cancelButton = _cancelButton;
@synthesize rightButton = _rightButton;

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
    self.titleTextField.text = [[[VariableStore sharedInstance] currentPostingItem] title];
    self.desTextField.text = [[[VariableStore sharedInstance] currentPostingItem] 
                                      description];
}

- (void)saveCurrentPostingData
{
    [VariableStore sharedInstance].currentPostingItem.title = self.titleTextField.text;
    [VariableStore sharedInstance].currentPostingItem.description = self.desTextField.text;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self saveCurrentPostingData];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCurrentPostingData];
    [self.titleTextField becomeFirstResponder];
    
    // navigation bar background color
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:NAVIGATION_BAR_BACKGROUND_COLOR_RED green:NAVIGATION_BAR_BACKGROUND_COLOR_GREEN blue:NAVIGATION_BAR_BACKGROUND_COLOR_BLUE alpha:NAVIGATION_BAR_BACKGROUND_COLOR_ALPHA];
    
#pragma mark - TODO
    // If it's a completed post template, stack all the views
    // and show the last step of posting process
    if (self.postType == POST_TYPE_TEMPLATE ) {
        //[self.navigationController popToRootViewControllerAnimated:NO];
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"Post Price"] animated:NO];
            
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"Post Due Date"] animated:NO];
        
        [self.navigationController pushViewController:
        [self.storyboard instantiateViewControllerWithIdentifier:@"Post Summary"] animated:NO];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UITextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    
    [ViewHelper buildCancelButton:self.cancelButton];
    if( [self.desTextField respondsToSelector:@selector(setPlaceholderText:)] )
      [self.desTextField setPlaceholderText:UI_TEXT_VIEW_DESCRIPTION];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PostFlowTitleToPriceView"]) {
        PostFlowPriceViewController *pvc = segue.destinationViewController;
        pvc.postType = self.postType;
    } 
}

- (void)rightButtonLoad 
{
    if (self.titleTextField.text.length > 0) {
        [ViewHelper buildNextButton:self.rightButton];
    } else {
        [ViewHelper buildNextButtonDis:self.rightButton];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self rightButtonLoad];
}

- (void)viewDidUnload
{
    [self setTitleTextField:nil];
    [self setDesTextField:nil];
    [self setCancelButton:nil];
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

- (IBAction)CancelAction:(id)sender {
    [self.titleTextField resignFirstResponder];
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

- (void)UITextFieldTextDidChangeNotification:(NSNotification *)notification {
    if ([notification object] == self.titleTextField) {
        [self rightButtonLoad];
    }
}

@end
