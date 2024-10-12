//
//  CollegeDetailViewController.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import UIKit

class CollegeDetailViewController: UIViewController {
    
    var showCollegeId: Int?
    var selectedCollege: College?
    let collegesModel = NJCollegesModel.sharedInstance

    @IBOutlet weak var collegeName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let collegeId = showCollegeId {
            
            selectedCollege = collegesModel.getCollege(findId: collegeId)
            
            if (selectedCollege != nil) {
                self.title = selectedCollege?.name
                collegeName.text = selectedCollege?.name
            }
            
        }
        
    }

}
