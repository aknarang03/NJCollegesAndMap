//
//  CollegeSummaryViewController.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import UIKit

class CollegesSummaryViewController: UIViewController {
    
    let collegesModel = NJCollegesModel.sharedInstance
    
    @IBOutlet weak var totalText: UILabel!
    @IBOutlet weak var northText: UILabel!
    @IBOutlet weak var southText: UILabel!
    @IBOutlet weak var centralText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testModel()
        showSummary()
    }
    
    func showSummary() {
        
        let data = collegesModel.getSummaryValues()
        
        totalText.text = String(data[0])
        northText.text = String(data[1])
        centralText.text = String(data[2])
        southText.text = String(data[3])
        
    }

}
