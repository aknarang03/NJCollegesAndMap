//
//  CollegesMapViewController.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import UIKit
import MapKit

class CollegesMapViewController: UIViewController {
    
    let collegesModel = NJCollegesModel.sharedInstance
    
    @IBOutlet weak var map: MKMapView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomToNewJersey()
        addColleges()
    }
    
    func zoomToNewJersey() { // NJ: 40.0583° N, 74.4057° W
        let njCenter = CLLocationCoordinate2D(latitude: 40.0583, longitude: -74.4057)
        let region = MKCoordinateRegion(center: njCenter, latitudinalMeters: 250000, longitudinalMeters: 250000)
        map.setRegion(region, animated: true)
    }
    
    func addColleges() {
        
        for college in collegesModel.njColleges {
            let annotation = MKPointAnnotation()
            annotation.title = college.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: college.coordinates[1], longitude: college.coordinates[0])
            map.addAnnotation(annotation)
        }
        
    }

}


