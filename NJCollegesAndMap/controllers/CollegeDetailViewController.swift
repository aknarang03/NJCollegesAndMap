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
        
        if let collegeId = showCollegeId {
            
            selectedCollege = collegesModel.getCollege(findId: collegeId)
            
            if (selectedCollege != nil) {
                
                name.text = selectedCollege!.name
                addressLine1.text = "\(selectedCollege!.address)"
                addressLine2.text = "\(selectedCollege!.city), \(selectedCollege!.county), NJ"
                addressLine3.text = "\(selectedCollege!.zip)"
                phone.text = "\(selectedCollege!.areaCode)-\(selectedCollege!.phone)"
                
                let assetName = collegesModel.getImage(collegeName: selectedCollege!.name)
                logo.image = UIImage(named:assetName)
                
            }
            
        }
        
    }

}
