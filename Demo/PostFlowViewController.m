//
//  PostFlowViewController.m
//  Demo
//
//  Created by zhicai on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PostFlowViewController.h"

@implementation PostFlowViewController

@synthesize titleTextField = _titleTextField;
@synthesize descriptionTextField = _descriptionTextField;
@synthesize postType = _postType;

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
    self.descriptionTextField.text = [[[VariableStore sharedInstance] currentPostingItem] 
                                      description];
}

- (void)saveCurrentPostingData
{
    [VariableStore sharedInstance].currentPostingItem.title = self.titleTextField.text;
    [VariableStore sharedInstance].currentPostingItem.description = self.descriptionTextField.text;
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
    
#pragma mark - TODO
    // If it's a completed post template, stack all the views
    // and show the last step of posting process
    if (self.postType == POST_TYPE ) {
        //[self.navigationController popToRootViewControllerAnimated:NO];
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"Post Price"] animated:NO];
            
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"Post Due Date"] animated:NO];
        
        [self.navigationController pushViewController:
         [self.storyboard instantiateViewControllerWithIdentifier:@"Post Summary"] animated:NO];
    }
}


- (void)viewDidUnload
{
    [self setTitleTextField:nil];
    [self setDescriptionTextField:nil];
    [super viewDidUnload];
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
    //NSLog(@"controller class: %@", NSStringFromClass([self.navigationController.tabBarController class]));
    //printf("Index: %d", self.navigationController.tabBarController.selectedIndex);
    //[self.navigationController dismissModalViewControllerAnimated:YES];
    //[self.navigationController removeFromParentViewController];
    //[self.navigationController dismissModalViewControllerAnimated:YES];
    //[self dismissModalViewControllerAnimated:YES];
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
    
    //self.navigationController.tabBarController.selectedIndex = 2;
    //[self.navigationController.tabBarController.selectedViewController viewDidAppear:YES];
    //[self.navigationController.tabBarController
}
@end
