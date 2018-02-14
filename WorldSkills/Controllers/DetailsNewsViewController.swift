//
//  DetailsNewsViewController.swift
//  DigitalSkills
//
//  Created by theSERG on 10/02/2018.
//  Copyright © 2018 seredkins. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailsNewsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var userLocation = CLLocation()
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        userLocation = location
        
        let centre = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: centre, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        buildRoute(to: [55.726781069021406, 37.75608349999999])

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    func buildRoute(to coordinates: [Double]) {
        
        // Creating MKMapItem objects
        let sourceMapItem = MKMapItem.init(fromCoordinates: [userLocation.coordinate.latitude, userLocation.coordinate.longitude])
        
        let destinationMapItem = MKMapItem.init(fromCoordinates: coordinates)
        
        // Creating annotation for destination MKMapItem object
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "You will go here"
        if let location = destinationMapItem.placemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        // Presenting annotation for destination MKMapItem object
        self.mapView.showAnnotations([destinationAnnotation], animated: true)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .any
        
        MKDirections(request: directionRequest).calculate
        { (response, error) in
            
            guard let response = response, error == nil else {
                print("\(error!.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self.showOnMap(route: response.routes[0])
            }
            
        }
    }
    
    func showOnMap(route: MKRoute) {
        self.mapView.add(route.polyline, level: .aboveRoads)
        let rect = route.polyline.boundingMapRect
        self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
    }
}

extension MKMapItem {
    convenience init(fromCoordinates coordinates: [Double]) {
        
        let location = CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1])
        
        let placeMark = MKPlacemark(coordinate: location)

        self.init(placemark: placeMark)
    }
}
