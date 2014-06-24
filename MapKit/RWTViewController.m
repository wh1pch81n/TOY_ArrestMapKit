//
//  RWTViewController.m
//  MapKit
//
//  Created by Derrick Ho on 6/23/14.
//  Copyright (c) 2014 Derrick Ho. All rights reserved.
//

#import "RWTViewController.h"

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

@end
