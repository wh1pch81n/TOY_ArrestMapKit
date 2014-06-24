//
//  RWTViewController.h
//  MapKit
//
//  Created by Derrick Ho on 6/23/14.
//  Copyright (c) 2014 Derrick Ho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

extern NSString *const kBaltimorePDArrestDB_URL;

@interface RWTViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
