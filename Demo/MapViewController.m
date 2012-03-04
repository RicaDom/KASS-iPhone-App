//
//  MapViewController.m
//  Demo
//
//  Created by zhicai on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController
@synthesize currentMap = _currentMap;
@synthesize currentItem = _currentItem;

- (void) loadMapDemo {
    CLLocationCoordinate2D userCoordinate;
    userCoordinate.latitude = 39.281516;
    userCoordinate.longitude = -76.580806;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userCoordinate ,3000, 3000);
    [self.currentMap setRegion:region animated:YES];
    self.currentMap.scrollEnabled = YES;
    self.currentMap.zoomEnabled = YES;
    
    for(int i = 1; i<=5;i++){
        CGFloat latDelta = rand()*.035/RAND_MAX -.02;
        CGFloat longDelta = rand()*.03/RAND_MAX -.015;
        
        CLLocationCoordinate2D newCoord = { userCoordinate.latitude + latDelta, userCoordinate.longitude + longDelta };
        
//        MKPointAnnotation *anotationPoint = [[MKPointAnnotation alloc] init];
//        anotationPoint.coordinate = newCoord;
//        anotationPoint.title = @"KASS";
//        anotationPoint.subtitle = @"KASS ROCKS";
        ListItem *data = [ListItem new];
        [data setTitle:@"求购2012年东方卫视跨年演唱会门票"];
        [data setDescription:@"听说有很多明星，阵容强大啊，求门票啊~~ 听说有很多明星，阵容强大啊，求门票啊~~ 听说有很多明星，阵容强大啊，求门票啊~~"];
        data.askPrice = [NSDecimalNumber decimalNumberWithDecimal:
                         [[NSNumber numberWithFloat:89.75f] decimalValue]];
        ListingMapAnnotaion *listingA = [[ListingMapAnnotaion alloc] initWithCoordinate:newCoord title:data.title subTitle:data.description listingItemData:data];
        [self.currentMap addAnnotation:listingA];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    DLog(@"Creating listing annotation view...");
    MKAnnotationView* annotationView = nil;
    ListingImageAnnotationView* imageAnnotationView = (ListingImageAnnotationView*)[self.currentMap dequeueReusableAnnotationViewWithIdentifier:nil];
    if(nil == imageAnnotationView)
    {
        imageAnnotationView = [[ListingImageAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];	
        imageAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    
    annotationView = imageAnnotationView;
	[annotationView setEnabled:YES];
	[annotationView setCanShowCallout:YES];
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {

    self.currentItem = ((ListingMapAnnotaion *)[view annotation]).currentItem;
    if (self.currentItem != nil) {
        DLog(@"Current item title %@", ((ListingMapAnnotaion *)[view annotation]).currentItem.title);
        
        // TODO        
        [self performSegueWithIdentifier:@"messageItemSegue" sender:self];
    } 
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"messageItemSegue"]) {
//        BrowseItemViewController *bvc = [segue destinationViewController];
      
    }
}

//- (void)viewWillAppear:(BOOL)animated {  
//    // 1
//    CLLocationCoordinate2D zoomLocation;
//    zoomLocation.latitude = 39.281516;
//    zoomLocation.longitude = -76.580806;
//    // 2
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
//    // 3
//    MKCoordinateRegion adjustedRegion = [currentMap regionThatFits:viewRegion];                
//    // 4
//    [currentMap setRegion:adjustedRegion animated:YES];        
//}

//- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {    
//    MKAnnotationView *annotationView = [views objectAtIndex:0];
//    id<MKAnnotation> mp = [annotationView annotation];
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate] ,250,250);
//    [mv setRegion:region animated:YES];
//}


//- (void)mapView:(MKMapView *)mv didUpdateUserLocation:(MKUserLocation *)userLocation {
//    CLLocationCoordinate2D userCoordinate = userLocation.location.coordinate;
//
//    for(int i = 1; i<=5;i++){
//        CGFloat latDelta = rand()*.035/RAND_MAX -.02;
//        CGFloat longDelta = rand()*.03/RAND_MAX -.015;
//
//        CLLocationCoordinate2D newCoord = { userCoordinate.latitude + latDelta, userCoordinate.longitude + longDelta };
//        
//        MKPointAnnotation *anotationPoint = [[MKPointAnnotation alloc] init];
//        anotationPoint.coordinate = newCoord;
//        anotationPoint.title = @"KASS";
//        anotationPoint.subtitle = @"KASS ROCKS";
//        [currentMap addAnnotation:anotationPoint];
//    }
//}



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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [self loadMapDemo];
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setCurrentMap:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
