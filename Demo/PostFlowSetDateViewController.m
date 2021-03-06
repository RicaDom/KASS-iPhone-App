//
//  PostFlowSetDateViewController.m
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PostFlowSetDateViewController.h"
#import "UIResponder+VariableStore.h"

@implementation PostFlowSetDateViewController
@synthesize PostDurationPicker = _PostDurationPicker;
@synthesize PostDurationLabel = _PostDurationLabel;
@synthesize PostFlowSegment = _PostFlowSegment;
@synthesize rightButton = _rightButton;
@synthesize postType = _postType;
@synthesize backButton = _backButton;
NSArray *arrayTimePicker;

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

- (void)loadCurrentPostingData
{
    if ([VariableStore sharedInstance].currentPostingItem.postDuration) {
        NSArray *keys = [self.settings.expiredTimeDict
                         allKeysForObject:[VariableStore sharedInstance].currentPostingItem.postDuration];
        if (keys) {
            NSString *selectedItem = [keys objectAtIndex:0];
            if ([selectedItem length] != 0) {
                [self.PostDurationPicker selectRow:[arrayTimePicker indexOfObject:selectedItem] inComponent:0 animated:NO];
                self.PostDurationLabel.text = selectedItem;
            }
            //self.PostDurationPicker sele
        }
        //self.priceTextField.text = [NSString stringWithFormat:@"%@", [VariableStore sharedInstance].currentPostingItem.askPrice];
    }
}

- (void)saveCurrentPostingData
{
    if (self.PostDurationLabel.text) {
        [VariableStore sharedInstance].currentPostingItem.postDuration = [self.settings.expiredTimeDict objectForKey:self.PostDurationLabel.text];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PostFlowSetDateToSumView"]) {
        PostSummaryViewController *pvc = segue.destinationViewController;
        pvc.postType = self.postType;
    } 
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    arrayTimePicker = [self.settings.expiredTimeDict keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        return [(NSNumber *)obj1 compare:(NSNumber *)obj2];
    }];
    [self loadCurrentPostingData];
    
    [ViewHelper buildBackButton:self.backButton];
    [ViewHelper buildNextButtonDis:self.rightButton];
}

- (void)viewDidUnload
{
    [self setPostDurationPicker:nil];
    [self setPostDurationLabel:nil];
    [self setPostFlowSegment:nil];
    [self setBackButton:nil];
    [self setRightButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self.PostDurationPicker selectedRowInComponent:0] != 0) {
        //self.navigationItem.rightBarButtonItem.enabled = YES; 
        [ViewHelper buildNextButton:self.rightButton];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self saveCurrentPostingData];
}

#pragma mark -
#pragma mark Picker View Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	return [arrayTimePicker count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	return [arrayTimePicker objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	self.PostDurationLabel.text = [arrayTimePicker objectAtIndex:row];
	DLog(@"Selected Color: %@. Index of selected color: %i", [arrayTimePicker objectAtIndex:row], row);
    if (0 == row) {
        [ViewHelper buildNextButtonDis:self.rightButton];
        //self.navigationItem.rightBarButtonItem.enabled = NO;
    } else {
        [ViewHelper buildNextButton:self.rightButton];
        //self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
