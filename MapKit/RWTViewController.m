//
//  RWTViewController.m
//  MapKit
//
//  Created by Derrick Ho on 6/23/14.
//  Copyright (c) 2014 Derrick Ho. All rights reserved.
//

#import "RWTViewController.h"
#import "ASIHTTPRequest.h"

static const float METERS_PER_MILE = 1609.344;
NSString *const kBaltimorePDArrestDB_URL = @"http://data.baltimorecity.gov/resource/3i3v-ibrt.json";

@interface RWTViewController ()

@end

@implementation RWTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /**a structure that contains the geographical coordinates using the wgs 84 reference frame*/
    CLLocationCoordinate2D zoomLocation; //well looky here its a c object
    zoomLocation.latitude = 39.281516; //Picking a specific latitude aka baltimoore
    zoomLocation.longitude = -76.580806; //picking a specific longitude aka baltimore
    
    /**Specify a location and specify how far out the fram should be.*/
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, //the center point
                                                                       0.5 * METERS_PER_MILE, //distance from north to south.
                                                                       0.5 * METERS_PER_MILE); //distance from east to west
    /**tells the mapview to display the region.*/
    [_mapView setRegion:viewRegion animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedRefresh:(id)sender {
    //1
    /**Gets the lat and long for the center of the map*/
    MKCoordinateRegion mapRegion = self.mapView.region;
    CLLocationCoordinate2D centerLocation = mapRegion.center;
    
    //2
    /**Reads in the command file template that you downloaded from the tutorial site, whish is the query string you need to send to the socrata API to get the arrests within a redius of a particular location.  It also has a hardcoded date restriction in there to keep the data set managable.  The command file is set up to be a query string, so you can substitute the lat/long and radius in there as parameters.  It has a hardcoded radius here (0.5 miles) to again keep the returned data managable.*/
    NSString *jsonFile = [[NSBundle mainBundle] pathForResource:@"command" ofType:@"json"];
    NSString *formatString = [NSString stringWithContentsOfFile:jsonFile encoding:NSUTF8StringEncoding error:nil];
    NSString *json = [NSString stringWithFormat:formatString, //never seen this before...a format like this.  Not sure how centerlocation.latitude and longitute is working with the format string since I don't see any of the placeholder flags.
                      centerLocation.latitude,
                      centerLocation.longitude,
                      0.5 * METERS_PER_MILE];
    
    //3
    /**creates a url for the web service endpoint to query*/
   // NSURL *url = [NSURL URLWithString:kBaltimorePDArrestDB_URL];
    NSURL *url = [NSURL URLWithString:@"http://data.baltimorecity.gov/api/views/INLINE/rows.json?method=index"];
    //NSURL *url = [NSURL URLWithString:@"http://data.baltimorecity.gov/resource/3i3v-ibrt.json?method=index"];
    //4
    /**creates a ASIHTTPRequest, and sets it up as a POT, passing in the JSON string as data*/
    ASIHTTPRequest *_request = [ASIHTTPRequest requestWithURL:url];  //wy are we prepending the variable name with an underscore?  its not a provate variable, its a local and temp variable.
    __weak ASIHTTPRequest *request = _request;  //the 'private' one is the strong reference while this one is a weak reference. hmm
    
    request.requestMethod = @"POST";
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    
    //5
    /**Sets up two blocks for the completion and the failure.  So far on this site we've been using callback methods instead of blocks with ASIHTTPRequest, but I wanted to show you the block method here because it's kind of cool and べんり.  Right now, these do nothing by log the results*/
    [request setDelegate:self];
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        NSLog(@"Response: %@", responseString);
    }];
    [request setFailedBlock:^{
        NSError *err = [request error];
        NSLog(@"Error: %@", err.localizedDescription);
    }];
    
    //6
    /**This line is the one that will start the asyncrounous event*/
    [request startAsynchronous];
}

@end
