//
//  CollegeDetailViewController.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import UIKit
import MapKit

class CollegeDetailViewController: UIViewController, MKMapViewDelegate {
    
    var showCollegeId: Int?
    var selectedCollege: College?
    let collegesModel = NJCollegesModel.sharedInstance
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var addressLine1: UILabel!
    @IBOutlet weak var addressLine2: UILabel!
    @IBOutlet weak var addressLine3: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        map.delegate = self
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        map.layer.cornerRadius = 10
        map.clipsToBounds = true
        
        if let collegeId = showCollegeId {
            
            selectedCollege = collegesModel.getCollege(findId: collegeId)
            
            if (selectedCollege != nil) {
                
                setViewpoint()
                addCollegeToMap()
                
                name.text = selectedCollege!.name
                addressLine1.text = collegesModel.formatAddress(input: "\(selectedCollege!.address) \(selectedCollege!.address2)")
                addressLine2.text = collegesModel.formatAddress(input: "\(selectedCollege!.city), \(selectedCollege!.county) County") + ", NJ"
                addressLine3.text = "\(selectedCollege!.zip)"
                
                if (selectedCollege!.phone == "" || selectedCollege!.phone == " " ) {
                    phone.text = "No phone number provided"
                } else {
                    phone.text = "Phone: \(selectedCollege!.areaCode)-\(selectedCollege!.phone)"
                }
                
                let assetName = collegesModel.getImage(collegeName: selectedCollege!.name)
                logo.image = UIImage(named:assetName)
                
            }
            
        }
        
    }
    
    func setViewpoint() {
        let coordinate = CLLocationCoordinate2D(latitude: selectedCollege!.coordinates[1], longitude: selectedCollege!.coordinates[0])
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.setRegion(region, animated: true)
    }
    
    func addCollegeToMap() {
        
        let logoString = collegesModel.getImage(collegeName: selectedCollege!.name)
            
        let annotation = CollegeAnnotation(latitude: selectedCollege!.coordinates[1], longitude: selectedCollege!.coordinates[0], title: selectedCollege!.name, logoString: logoString, id: selectedCollege!.id)
                
        map.addAnnotation(annotation)
        
    }
    
    // annotation view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
                
        guard !(annotation is MKUserLocation) else {
            return nil
        }
                
        let collegeAnnotation = annotation as? CollegeAnnotation
        
        let identifier = "CollegeAnnotation"
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    
        annotationView.image = UIImage(named: collegeAnnotation?.logoString! ?? "default_uni")
        annotationView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
                
        annotationView.canShowCallout = true
        annotationView.calloutOffset = CGPoint(x: -5.0, y: 5.0)
                
        let imageView = UIImageView (frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 60.0, height: 60.0)))
        imageView.image = UIImage(named: collegeAnnotation?.logoString! ?? "default_uni")
        
        return annotationView
    }

}
