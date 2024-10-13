//
//  CollegeDetailViewController.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import UIKit
import MapKit

class CollegeDetailViewController: UIViewController {
    
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

}
