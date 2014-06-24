//
//  MyLocation.h
//  MapKit
//
//  Created by Derrick Ho on 6/24/14.
//  Copyright (c) 2014 Derrick Ho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/**
 Mission
 1) creat a class that implements the MKAnnotation protocol.  this means it needs to return a tiel, subtile, and coordinate.  You can store other information on there if you want to.
 2) For every location you want marked on the map, create one of these classes and add it to the mapview with the addannotation methos.
 3) mark the view controller as the map view's delegate, and for each annotation you added it will call a method on the view controller called mapView:viewForAnnotation:.  Your job in this methodis to return an instace of MKAnnotationView to present as a visual indicator of the annotation.  We'll be using the base class, MKAnnotationView, in this tutorial bet there is a concrete subclass called MKPinAnnotationView which can be used if you want the standard pin you see in the Maps App.
 
 */

@interface MyLocation : NSObject <MKAnnotation>

- (id)initWithName:(NSString *)name
           address:(NSString *)address
        coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem *)mapItem;

@end
